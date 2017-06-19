require 'spec_helper'

describe HaystackRuby::Auth::Scram::Conversation do
  describe 'connection' do

    # it 'receives authorization challenge response to hello' do
    #   expect(conv.hello.status.should == 401 )
    # end
    before :each do
      user = OpenStruct.new
      user.username = CONF[PROJECT]['username']
      user.password = CONF[PROJECT]['password']
      url = HaystackRuby::Config.projects[PROJECT].url
      @conv = HaystackRuby::Auth::Scram::Conversation.new(user, url)
    end
    it 'receives auth challenge response to first message' do
      expect(@conv.send_first_message.status).to be == 401
    end
    it 'sends valid rnonce in continue message' do
      res = @conv.send_first_message
      @conv.parse_first_response(res)
      puts "nonce #{@conv.nonce}, servernonce #{@conv.server_nonce}"
      expect(@conv.nonce.length).to be > 0 
      expect(@conv.server_nonce.index(@conv.nonce)).to be == 0 
    end
    it 'server responds to second client message with authorization' do
      res = @conv.send_first_message
      @conv.parse_first_response(res)
      expect(@conv.send_second_message.status).to be == 200
    end
    it 'should have nonempty auth token after full authorization' do
      @conv.authorize
      expect(@conv.auth_token).not_to be_empty
    end
    it 'should load page using auth token' do
      @conv.authorize
      expect(@conv.test_auth_token.status).to be == 200
    end
  end
end