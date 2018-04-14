require 'spec_helper'

describe FocusType do
  before(:each) { @focus_type = FactoryGirl.create(:focus_type) }
  subject { @focus_type }

  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :description }
end
