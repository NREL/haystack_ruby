require 'spec_helper'
describe ProjectHaystack::Project do
  before do
    @demo = ProjectHaystack::Config.projects['test']
  end
  describe '#connection' do
    context 'defined project name' do
      it 'returns valid Faraday connection' do
        expect(@demo.connection).to be_a_kind_of Faraday::Connection
      end
      it 'sets Authorization header' do
        expect(@demo.connection.headers['Authorization']).to_not be_nil
      end
      it 'accepts json' do
        expect(@demo.connection.headers['Accept']).to eq 'application/json'
      end
    end
    context 'undefined project name' do
    end
    context 'missing config file' do
    end
  end
  describe '#read' do
    context 'simple filter' do
      it 'returns cols' do
        expect(@demo.read({:filter => '"site"'})['cols']).to be_a_kind_of Array
      end
      it 'returns rows' do
        expect(@demo.read({:filter => '"site"'})['rows']).to be_a_kind_of Array
      end
    end
  end
end