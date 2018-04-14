require 'spec_helper'

describe LinkResource do
  before(:each) { @link_resource = FactoryGirl.create(:link_resource) }
  subject { @link_resource }

  it { is_expected.to respond_to :lab }
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :url }

  describe 'when lab is not present' do
    before(:each) { @link_resource.lab = nil }

    it { is_expected.not_to be_valid }
  end

  describe 'when name is not present' do
    before(:each) { @link_resource.name = nil }

    it { is_expected.not_to be_valid }
  end

  describe 'when url is not present' do
    before(:each) { @link_resource.url = nil }

    it { is_expected.not_to be_valid }
  end
end
