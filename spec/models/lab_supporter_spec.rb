require 'spec_helper'

describe LabSupporter do
  before(:each) do
    @lab = FactoryBot.create(:lab)
    @alt_user = FactoryBot.create(:user, email: 'altuser@example.com', login: 'altuser')
    @lab_supporter = FactoryBot.create(:lab_supporter, lab: @lab, user: @alt_user)
  end

  subject { @lab_supporter }

  # Check attributes.
  it { is_expected.to respond_to :lab }
  it { is_expected.to respond_to :user }

  describe 'when lab is not present' do
    before(:each) { @lab_supporter.lab = nil }

    it { is_expected.not_to be_valid }
  end

  describe 'when user is not present' do
    before(:each) { @lab_supporter.user = nil }

    it { is_expected.not_to be_valid }
  end

  describe "when a user tries to support a lab twice" do
    it "should not be valid" do
      dup_supporter = @lab_supporter.dup
      expect(dup_supporter.valid?).to be false
    end
  end
end
