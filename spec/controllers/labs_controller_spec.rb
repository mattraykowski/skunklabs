require 'spec_helper'

describe LabsController do

  describe 'GET index' do
    it 'assigns all lab as @labs' do
      lab = FactoryGirl.create :lab
      get :index, {}
      assigns(:labs).should eq([lab])
    end
  end

  describe 'GET show' do
    it 'assigns the requested lab as @lab' do
      lab = FactoryGirl.create :lab
      get :show, {:id => lab.to_param}
      assigns(:lab).should eq(lab)
    end
  end

  describe 'GET new' do
    describe 'when authenticated' do
      login_user

      it 'assigns a new lab as @lab' do
        get :new, {}
        assigns(:lab).should be_a_new(Lab)
      end
    end

    describe 'when not authenticated' do
      it 'should redirect to login' do
        get :new, {}
        response.should redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET edit' do
    describe 'when authenticated' do
      login_user

      it 'assigns the requested lab as @lab' do
        lab = FactoryGirl.create :lab, user: @user
        get :edit, {:id => lab.to_param}
        assigns(:lab).should eq(lab)
      end
    end

    describe 'when not authenticated' do
      it 'should redirect to sign in' do
        lab = FactoryGirl.create :lab
        get :edit, {:id => lab.to_param}

        response.should redirect_to(new_user_session_path)
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
            post :create, {lab: @attrs}
          }.to change(Lab, :count).by(1)
        end

        it 'assigns a newly created lab as @lab' do
          post :create, {lab: @attrs}
          assigns(:lab).should be_a(Lab)
          assigns(:lab).should be_persisted
        end

        it 'redirects to the created lab' do
          post :create, {lab: @attrs}
          response.should redirect_to(Lab.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved lab as @lab' do
          # Trigger the behavior that occurs when invalid params are submitted
          Lab.any_instance.stub(:save).and_return(false)
          post :create, {:lab => { 'user_id' => 'invalid value' }}
          assigns(:lab).should be_a_new(Lab)
        end

        it 're-renders the "new" template' do
          # Trigger the behavior that occurs when invalid params are submitted
          Lab.any_instance.stub(:save).and_return(false)
          post :create, {:lab => { 'user_id' => 'invalid value' }}
          response.should render_template('new')
        end
      end
    end

    describe 'when not authenticated' do
      it 'should redirect to login' do
        post :create, {lab: @attrs}
        response.should redirect_to(new_user_session_path)
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
          Lab.any_instance.should_receive(:update).with({ 'goals' => '1' })
          put :update, { id: lab.to_param, lab: { 'goals' => '1' }}
        end

        it 'assigns the requested lab as @lab' do
          lab = FactoryGirl.create :lab, user: @user
          put :update, { id: lab.to_param, lab: FactoryGirl.attributes_for(:lab)}
          assigns(:lab).should eq(lab)
        end

        it 'redirects to the lab' do
          lab = FactoryGirl.create :lab, user: @user
          put :update, { id: lab.to_param, lab: FactoryGirl.attributes_for(:lab)}
          response.should redirect_to(lab)
        end
      end

      describe 'with invalid params' do
        it 'assigns the lab as @lab' do
          lab = FactoryGirl.create :lab, user: @user
          # Trigger the behavior that occurs when invalid params are submitted
          Lab.any_instance.stub(:save).and_return(false)
          put :update, { id: lab.to_param, lab: { 'user_id' => 'invalid value' }}
          assigns(:lab).should eq(lab)
        end

        it 're-renders the "edit" template' do
          lab = FactoryGirl.create :lab, user: @user
          # Trigger the behavior that occurs when invalid params are submitted
          Lab.any_instance.stub(:save).and_return(false)
          put :update, { id: lab.to_param, lab: { 'user_id' => 'invalid value' }}
          response.should render_template('edit')
        end
      end
    end

    describe 'when not authenticated' do
      it 'should redirect to login' do
        user = FactoryGirl.create :user
        lab = FactoryGirl.create :lab, user: user
        put :update, { id: lab.to_param, lab: { 'goals' => '1' }}
        response.should redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE destroy' do
    describe 'when authenticated' do
      login_user

      it 'destroys the requested lab' do
        lab = FactoryGirl.create :lab, user: @user
        expect {
          delete :destroy, {:id => lab.to_param}
        }.to change(Lab, :count).by(-1)
      end

      it 'redirects to the lab list' do
        lab = FactoryGirl.create :lab, user: @user
        delete :destroy, {id: lab.to_param}
        response.should redirect_to(labs_url)
      end
    end

    describe 'when not authenticated' do
      it 'should redirect to login' do
        user = FactoryGirl.create :user
        lab = FactoryGirl.create :lab, user: user
        delete :destroy, {  id: lab.to_param}
        response.should redirect_to(new_user_session_path)
      end
    end
  end
end