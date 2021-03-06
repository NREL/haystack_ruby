require 'spec_helper'
describe HaystackRuby::Project do
  before do
    @demo = HaystackRuby::Config.projects[PT_PROJ]
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
  describe '#add_rec' do
    context 'point' do
      it 'returns id' do
        params = [{name: 'sp',type: 'Marker',value: 'M'},{name: 'dis',type: 'String',value: 'Test'},{name: 'point', type: 'Marker', value: 'M'},{name: 'equipRef',type: 'Ref',value: '@1d56759c-8f9214b6'},{name: 'siteRef', type: 'Ref', value: '@1d56758c-c15f5708'}]
        res = @demo.add_rec(params )
        expect(res).to be_a_kind_of String
      end
    end
  end
end