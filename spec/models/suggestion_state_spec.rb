require 'spec_helper'

describe SuggestionState do
  before(:each) { @suggestion_state = FactoryGirl.create(:suggestion_state) }
  subject { @suggestion_state }

  # Check attributes.
  it { should respond_to :name }
  it { should respond_to :done }
  
  describe 'when name is not present' do
    before(:each) { @suggestion_state.name = nil }

    it { should_not be_valid }
  end
end
