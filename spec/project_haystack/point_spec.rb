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
        @data = @point.data(Date.parse('2015-06-15'))
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
      context 'Dates' do
        it 'returns data when two ascending Date values' do
          data = @point.data(Date.parse('2015-06-15'), Date.parse('2015-06-16'))
          expect(data.count).to be > 0
        end
        it 'throws error start is after finish' do
          expect {
            data = @point.data(Date.parse('2015-06-16'), Date.parse('2015-06-15'))
          }.to raise_error ArgumentError
        end
        it 'returns data when no finish' do
          data = @point.data(Date.parse('2015-06-15'))
          expect(data.count).to be > 0
        end
      end
      context 'DateTimes' do 
        it 'returns data when two ascending DateTime values' do
          data = @point.data(Date.parse('2015-06-15').to_datetime, Date.parse('2015-06-16').to_datetime)
          expect(data.count).to be > 0
        end
        it 'throws error start is after finish' do
          expect {
            @point.data(Date.parse('2015-06-16').to_datetime, Date.parse('2015-06-15').to_datetime)
            }.to raise_error ArgumentError

        end
        it 'returns data when one value' do
          data = @point.data(Date.parse('2015-06-15').to_datetime)
          expect(data.count).to be > 0
        end
      end
      it 'returns data when range is Date' do
        data = @point.data(Date.parse('2015-06-15'))
        expect(data.count).to be > 0
      end
      it 'does not accept string values for range' do
        expect { data = @point.data('2015-06-15') }.to raise_error ArgumentError
      end
      it 'returns data when range is start DateTime' do
        data = @point.data(Date.parse('2015-06-15').to_datetime)
        expect(data.count).to be > 0
      end
    end
  end
end