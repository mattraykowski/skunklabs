require 'spec_helper'

describe Comment do
  before(:each) do
    @lab = FactoryGirl.create(:lab)
    @comment = FactoryGirl.create(:comment, lab: @lab, user: @lab.user)
  end
  subject { @comment }

  # Check attributes.
  it { should respond_to :user }
  it { should respond_to :lab }
  it { should respond_to :comment }
  it { should respond_to :subject }
  it { should respond_to :is_update }
  it { should respond_to :progress }

  describe 'when user is not present' do
    before(:each) { @comment.user = nil }

    it { should_not be_valid }
  end

  describe 'when lab is not present' do
    before(:each) { @comment.lab = nil }

    it { should_not be_valid }
  end

  describe 'when subject is not present' do
    before(:each) { @comment.subject = nil }

    it { should_not be_valid }
  end

  describe 'when comment is not present' do
    before(:each) { @comment.comment = nil }

    it { should_not be_valid }
  end
end
