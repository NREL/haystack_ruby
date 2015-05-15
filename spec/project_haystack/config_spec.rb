require 'spec_helper'
describe ProjectHaystack::Config do
  describe '.projects' do
    context 'good config file' do
      before do
        @projects = ProjectHaystack::Config.projects
        @demo = @projects['demo']
      end
      it 'returns a project' do
        expect(@demo).to be_a_kind_of ProjectHaystack::Project
      end
    end
    context 'bad project in config file' do
    end
    context 'missing config file' do
    end
  end
end