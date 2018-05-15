require 'spec_helper'

describe Comment do
  before(:each) do
    @lab = FactoryBot.create(:lab)
    @comment = FactoryBot.create(:comment, lab: @lab, user: @lab.user)
  end
  subject { @comment }

  # Check attributes.
  it { is_expected.to respond_to :user }
  it { is_expected.to respond_to :lab }
  it { is_expected.to respond_to :comment }
  it { is_expected.to respond_to :subject }
  it { is_expected.to respond_to :is_update }
  it { is_expected.to respond_to :progress }

  describe 'when user is not present' do
    before(:each) { @comment.user = nil }

    it { is_expected.not_to be_valid }
  end

  describe 'when lab is not present' do
    before(:each) { @comment.lab = nil }

    it { is_expected.not_to be_valid }
  end

  describe 'when subject is not present' do
    before(:each) { @comment.subject = nil }

    it { is_expected.not_to be_valid }
  end

  describe 'when comment is not present' do
    before(:each) { @comment.comment = nil }

    it { is_expected.not_to be_valid }
  end
end
