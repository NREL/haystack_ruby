require 'spec_helper'
describe HaystackRuby::Config do
  describe '.projects' do
    context 'good config file' do
      before do
        @projects = HaystackRuby::Config.projects
        @demo = @projects[PROJECT]
      end
      it 'returns a project' do
        expect(@demo).to be_a_kind_of HaystackRuby::Project
      end
    end
    context 'bad project in config file' do
    end
    context 'missing config file' do
    end
  end
end