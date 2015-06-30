require 'spec_helper'
require 'models/point_demo'
describe ProjectHaystack::Point do
  before do
    @point = PointDemo.new('demo','@ShortPump.ElecMeter-Main.kWh','New_York')
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
        @res = @point.his_read('yesterday')
      end
      it 'returns 2 columns' do
        expect(@res['cols'].count).to eq 2
      end
      it 'returns array of rows' do
        expect(@res['rows']).to be_a_kind_of Array
      end
    end
  end
  
  describe '#meta' do
    context 'valid id' do
      it 'returns metadata for the point' do
        expect(@point.meta).to be_a_kind_of Hash 
      end
    end
  end

  describe '#data' do
    context 'valid id and range' do
      before do
        @data = @point.data('2015-06-15')
        @d = @data.first
      end
      it 'returns data with expected format' do
        expect(@d[:time]).to_not be_nil 
        expect(@d[:value]).to_not be_nil
      end
      it 'returns time as epoch' do
        expect(@d[:time]).to be_a_kind_of Integer
      end
    end
    context 'various range formats' do
      it 'returns data when range is array start and end Dates' do
        data = @point.data([Date.parse('2015-06-15'), Date.parse('2015-06-16')])
        expect(data.count).to be > 0
      end
      it 'returns data when range is start Date (no end)' do
        data = @point.data(['2015-06-15'])
        expect(data.count).to be > 0
      end
      it 'returns data when range is array start and end DateTimes' do
        data = @point.data([Date.parse('2015-06-15').to_datetime, Date.parse('2015-06-16').to_datetime])
        expect(data.count).to be > 0
      end
      it 'returns data when range is start DateTime (no end)' do
        data = @point.data([Date.today.prev_day.to_datetime])
        expect(data.count).to be > 0
      end
    end
  end
end