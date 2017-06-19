require 'securerandom' #consider using openssl random
require 'base64'
require 'openssl'
module HaystackRuby
  module Auth
    module Scram
      class Conversation
        attr_reader :auth_token, :nonce, :server_nonce, :server_salt

        def initialize(user, url)
          @user = user
          @url = url
          @nonce = SecureRandom.base64.tr('=','') #TODO check if problem to potentially strip =
          @digest = OpenSSL::Digest::SHA256.new 
          @handshake_token = Base64.strict_encode64(@user.username)
        end

        def authorize
          res = send_first_message
          parse_first_response(res)
          res = send_second_message
          parse_second_response(res)
        end

        def connection 
          @connection ||= Faraday.new(:url => @url) do |faraday|
            # faraday.response :logger                  # log requests to STDOUT
            faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
            faraday.headers['Accept'] = 'application/json' #TODO enable more formats
            faraday.headers['Content-Type'] = 'text/plain'
          end
        end

        # first message sent by client to server
        def send_first_message
          res = connection.get('about') do |req|
            req.headers['Authorization'] = "SCRAM handshakeToken=#{@handshake_token},data=#{Base64.urlsafe_encode64(first_message).tr('=','')}"
          end
          res
          
        end

        # pull server data out of response to first message
        def parse_first_response(response)

          # parse server response to first message
          response_str = response.env.response_headers['www-authenticate']
          unless response_str.index('scram ') == 0
            throw 'Invalid response from server'
          end
          response_str.slice! 'scram '
          response_vars = {}
          response_str.split(', ').each do |pair|
            key,value = pair.split('=')
            response_vars[key] = value
          end
          unless response_vars['hash'] == 'SHA-256'
            throw "Server requested unsupported hash algorithm: #{response_vars['hash']}"
          end

          # todo check handshake token (should be base64 encode of username)

          @server_first_msg = Base64.decode64(response_vars["data"])
          server_vars = {}
          @server_first_msg.split(',').each do |pair|
            key,value = pair.split '='
            server_vars[key] = value
          end
          @server_nonce = server_vars['r']
          @server_salt = server_vars['s'] #Base64.decode64(server_vars['s'])
          @server_iterations = server_vars['i'].to_i
        end

        def send_second_message
          res = connection.get('about') do |req|
            req.headers['Authorization'] = "SCRAM handshakeToken=#{@handshake_token},data=#{Base64.strict_encode64(client_final).tr('=','')}"
          end
          res
          
        end
        def parse_second_response(response)
          begin
            response_str = response.env.response_headers['authentication-info']
            response_vars = {}
            response_str.split(', ').each do |pair|
              key,value = pair.split('=')
              response_vars[key] = value
            end
            # decode data attribute to check server signature is as expected
            key,val = Base64.decode64(response_vars['data']).split('=')
            response_vars[key] = val
            server_sig = response_vars['v']
            unless server_sig == expected_server_signature
              throw "invalid signature from server"
            end
            @auth_token = response_vars['authToken']
          # rescue Exception => e
          #   raise
          end
          
        end

        def test_auth_token
          res = connection.get('about') do |req|
            req.headers['Authorization'] = "BEARER authToken=#{@auth_token}"
          end
        end

        private

# utility methods, closely matched with SCRAM notation and algorithm overview here: 
# https://tools.ietf.org/html/rfc5802#section-3

        def auth_message
          @auth_message ||= "#{first_message},#{@server_first_msg},#{without_proof}"
        end

        def client_final
          @client_final ||= "#{without_proof},p=" +
            client_proof(client_key, client_signature(stored_key(client_key), auth_message))
        end

        def client_key
          @client_key ||= hmac(salted_password, 'Client Key')
        end

        def client_proof(key, signature)
          @client_proof ||= Base64.strict_encode64(xor(key, signature))
        end

        def client_signature(key, message)
          @client_signature ||= hmac(key, message)
        end

        def expected_server_key
          @server_key ||= hmac(salted_password, 'Server Key')
        end

        def expected_server_signature
          @server_signature ||= Base64.strict_encode64(hmac(expected_server_key, auth_message)).tr('=','')
        end

        def first_message
          "n=#{@user.username},r=#{@nonce}"
        end

        def h(string)
          @digest.digest(string)
        end

        def hi(data)
          OpenSSL::PKCS5.pbkdf2_hmac(
            data, 
            Base64.decode64(@server_salt), 
            @server_iterations, 
            @digest.digest_length,
            @digest
          )
        end

        def hmac(data, key)
          OpenSSL::HMAC.digest(@digest,data,key)
        end


        def salted_password
          @salted_password ||= hi(@user.password)
        end

        def stored_key(key)
          h(key)
        end

        def without_proof
          @without_proof ||= "c=biws,r=#{@server_nonce}"
        end

        def xor(first, second)
          first.bytes.zip(second.bytes).map{ |(a,b)| (a ^ b).chr }.join('')
        end
      end
    end
  end
end
