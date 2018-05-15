require 'spec_helper'

RSpec.describe ProfileController, type: :controller do
  describe 'notices' do
    login_user

    context 'when user is the current user' do
      it 'should update the meeting notice' do
        expect_any_instance_of(User).to receive(:update).with({ meeting_notice: 'true' }).and_return(true)
        put :notices, xhr: true, params: { id: @user.id, notices: 'true' }
      end
    end
  end
end
