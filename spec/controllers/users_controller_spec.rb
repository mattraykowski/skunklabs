require 'spec_helper'

describe UsersController do

  describe 'noticelist' do
    login_user

    context 'when current user is not an admin' do
      it 'should redirect the user to root' do
        get :noticelist, {}
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when current user is an admin' do
      before(:each) do
        @user.admin = true
        @user.save
      end

      it 'assigns all users as @users' do
        get :noticelist, {}
        expect(assigns(:users)).to eq([@user])
      end
    end
  end

  describe 'notices' do
    login_user


    context 'when current user is not an admin' do
      context 'when user is not the current user' do
        before(:each) do
          @other_user = FactoryBot.create(:user, email: 'otheruser@email.com', login: 'otheruser')
        end

        it 'should rediect the user to root' do
          put :notices, xhr: true, params: { id: @other_user.id, notices: 'true' }
          expect(response).to redirect_to(root_url)
        end
      end

      context 'when user is the current user' do
        it 'should update the meeting notice' do
          expect_any_instance_of(User).to receive(:update).with({ meeting_notice: 'true' }).and_return(true)
          put :notices, xhr: true, params: { id: @user.id, notices: 'true' }
        end
      end
    end

    context 'when current user is an admin' do
      before(:each) do
        @user.admin = true
        @user.save
      end

      it 'should update the meeting notice' do
        expect_any_instance_of(User).to receive(:update).with({ meeting_notice: 'true' }).and_return(true)
        put :notices, xhr: true, params: { id: @user.id, notices: 'true' }
      end
    end
  end

  describe 'admin' do
    login_user


    context 'when current user is not an admin' do
      it 'should rediect the user to root' do
        put :admin, xhr: true, params: { id: @user.id, admin: 'true' }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when current user is an admin' do
      before(:each) do
        @user.admin = true
        @user.save
      end

      it 'should update the admin flag' do
        expect_any_instance_of(User).to receive(:update).with({ admin: 'true' }).and_return(true)
        put :admin, xhr: true, params: { id: @user.id, admin: 'true' }
      end
    end
  end

  describe 'team' do
    login_user


    context 'when current user is not an admin' do
      it 'should rediect the user to root' do
        put :team, xhr: true, params: { id: @user.id, team: 'true' }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when current user is an admin' do
      before(:each) do
        @user.admin = true
        @user.save
      end

      it 'should update the suggestion team flag' do
        expect_any_instance_of(User).to receive(:update).with({ suggestion_team_member: 'true' }).and_return(true)
        put :team, xhr: true, params: { id: @user.id, team: 'true' }
      end
    end
  end

end
