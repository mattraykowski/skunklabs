require 'spec_helper'

describe SuggestionState do
  before(:each) { @suggestion_state = FactoryBot.create(:suggestion_state) }
  subject { @suggestion_state }

  # Check attributes.
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :done }
  
  describe 'when name is not present' do
    before(:each) { @suggestion_state.name = nil }

    it { is_expected.not_to be_valid }
  end
end
