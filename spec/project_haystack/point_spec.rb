require 'spec_helper'
require 'models/point_demo'
describe ProjectHaystack::Point do
  before do
    @point = PointDemo.new('demo','@ShortPump.ElecMeter-Main.kWh')
  end
  describe '#haystack_project' do
    context 'real project name' do
      it 'responds to method' do
        expect(@point).to respond_to :haystack_project
      end
      it 'returns a project' do
        expect(@point.haystack_project).to be_a_kind_of ProjectHaystack::Project
      end
    end
  end
  describe '#hisRead' do
    context 'valid id and range' do
      before do
        @res = @point.his_read('"yesterday"')
      end
      it 'returns 2 columns' do
        expect(@res['cols'].count).to eq 2
      end
      it 'returns array of rows' do
        expect(@res['rows']).to be_a_kind_of Array
      end
    end
  end
end