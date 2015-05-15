require 'spec_helper'
describe ProjectHaystack::Config do
  describe '.connection' do
    context 'defined project name' do
      before do
        @demo = ProjectHaystack::Config.connection 'demo'
      end
      it 'returns valid Faraday connection' do
        expect(@demo).to be_a_kind_of Faraday::Connection
      end
      it 'sets Authorization header' do
        expect(@demo.headers['Authorization']).to_not be_nil
      end
      it 'accepts json' do
        expect(@demo.headers['Accept']).to eq 'application/json'
      end
    end
    context 'undefined project name' do
    end
  end
end