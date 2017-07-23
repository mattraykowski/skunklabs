require 'spec_helper'

describe LinkResource do
  before(:each) { @link_resource = FactoryGirl.create(:link_resource) }
  subject { @link_resource }

  it { should respond_to :lab }
  it { should respond_to :name }
  it { should respond_to :url }

  describe 'when lab is not present' do
    before(:each) { @link_resource.lab = nil }

    it { should_not be_valid }
  end

  describe 'when name is not present' do
    before(:each) { @link_resource.name = nil }

    it { should_not be_valid }
  end

  describe 'when url is not present' do
    before(:each) { @link_resource.url = nil }

    it { should_not be_valid }
  end
end
