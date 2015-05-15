require 'spec_helper'
describe ProjectHaystack::Config do
  describe '.connection' do
    it 'returns valid Faraday connection' do
      demo = ProjectHaystack::Config.connection 'demo'
      expect(demo).to be_a_kind_of Faraday::Connection
    end
  end
end