require 'spec_helper'

describe LabsController do

  describe 'GET index' do
    it 'assigns all lab as @labs' do
      lab = FactoryGirl.create :lab
      get :index, {}
      expect(assigns(:labs)).to eq([lab])
    end
  end

  describe 'GET show' do
    it 'assigns the requested lab as @lab' do
      lab = FactoryGirl.create :lab
      get :show, params: {:id => lab.to_param}
      expect(assigns(:lab)).to eq(lab)
    end
  end

  describe 'GET new' do
    describe 'when authenticated' do
      login_user

      it 'assigns a new lab as @lab' do
        get :new, {}
        expect(assigns(:lab)).to be_a_new(Lab)
      end
    end

    describe 'when not authenticated' do
      it 'should redirect to login' do
        get :new, {}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET edit' do
    describe 'when authenticated' do
      login_user

      it 'assigns the requested lab as @lab' do
        lab = FactoryGirl.create :lab, user: @user
        get :edit, params: {:id => lab.to_param}
        expect(assigns(:lab)).to eq(lab)
      end
    end

    describe 'when not authenticated' do
      it 'should redirect to sign in' do
        lab = FactoryGirl.create :lab
        get :edit, params: {:id => lab.to_param}

        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

  describe 'POST create' do
    describe 'when authenticated' do
      login_user

      describe 'with valid params' do
        valid_attribues_for_lab

        it 'creates a new Lab' do
          expect {
            post :create, params: {lab: @attrs}
          }.to change(Lab, :count).by(1)
        end

        it 'assigns a newly created lab as @lab' do
          post :create, params: {lab: @attrs}
          expect(assigns(:lab)).to be_a(Lab)
          expect(assigns(:lab)).to be_persisted
        end

        it 'redirects to the created lab' do
          post :create, params: {lab: @attrs}
          expect(response).to redirect_to(Lab.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved lab as @lab' do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Lab).to receive(:save).and_return(false)
          post :create, params: {:lab => { 'user_id' => 'invalid value' }}
          expect(assigns(:lab)).to be_a_new(Lab)
        end

        it 're-renders the "new" template' do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Lab).to receive(:save).and_return(false)
          post :create, params: {:lab => { 'user_id' => 'invalid value' }}
          expect(response).to render_template('new')
        end
      end
    end

    describe 'when not authenticated' do
      it 'should redirect to login' do
        post :create, params: {lab: @attrs}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PUT update' do
    describe 'when authenticated' do
      login_user

      describe 'with valid params' do
        it 'updates the requested lab' do
          lab = FactoryGirl.create :lab, user: @user
          # Assuming there are no other lab in the database, this
          # specifies that the Lab created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          allow_any_instance_of(Lab).to receive(:update).with({ 'goals' => '1' })
          put :update, params: { id: lab.to_param, lab: { 'goals' => '1' }}
        end

        it 'assigns the requested lab as @lab' do
          lab = FactoryGirl.create :lab, user: @user
          put :update, params: { id: lab.to_param, lab: FactoryGirl.attributes_for(:lab)}
          expect(assigns(:lab)).to eq(lab)
        end

        it 'redirects to the lab' do
          lab = FactoryGirl.create :lab, user: @user
          put :update, params: { id: lab.to_param, lab: FactoryGirl.attributes_for(:lab)}
          expect(response).to redirect_to(lab)
        end
      end

      describe 'with invalid params' do
        it 'assigns the lab as @lab' do
          lab = FactoryGirl.create :lab, user: @user
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Lab).to receive(:save).and_return(false)
          put :update, params: { id: lab.to_param, lab: { 'user_id' => 'invalid value' }}
          expect(assigns(:lab)).to eq(lab)
        end

        it 're-renders the "edit" template' do
          lab = FactoryGirl.create :lab, user: @user
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Lab).to receive(:save).and_return(false)
          put :update, params: { id: lab.to_param, lab: { 'user_id' => 'invalid value' }}
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'when not authenticated' do
      it 'should redirect to login' do
        user = FactoryGirl.create :user
        lab = FactoryGirl.create :lab, user: user
        put :update, params: { id: lab.to_param, lab: { 'goals' => '1' }}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE destroy' do
    describe 'when authenticated' do
      login_user

      it 'destroys the requested lab' do
        lab = FactoryGirl.create :lab, user: @user
        expect {
          delete :destroy, params: {:id => lab.to_param}
        }.to change(Lab, :count).by(-1)
      end

      it 'redirects to the lab list' do
        lab = FactoryGirl.create :lab, user: @user
        delete :destroy, params: {id: lab.to_param}
        expect(response).to redirect_to(labs_url)
      end
    end

    describe 'when not authenticated' do
      it 'should redirect to login' do
        user = FactoryGirl.create :user
        lab = FactoryGirl.create :lab, user: user
        delete :destroy, params: { id: lab.to_param}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
