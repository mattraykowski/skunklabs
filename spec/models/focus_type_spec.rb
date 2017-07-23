require 'spec_helper'

describe FocusType do
  before(:each) { @focus_type = FactoryGirl.create(:focus_type) }
  subject { @focus_type }

  it { should respond_to :name }
  it { should respond_to :description }
end
