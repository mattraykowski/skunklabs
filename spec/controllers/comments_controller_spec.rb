require 'spec_helper'

describe CommentsController do

  # This should return the minimal set of attributes required to create a valid
  # Comment. As you add validations to Comment, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "user_id" => "1" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CommentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    before(:each) do
      @lab = FactoryGirl.create(:lab)
      @comment = FactoryGirl.create(:comment, lab: @lab, user: @lab.user)
    end

    it "assigns all comments as @comments" do
      #@comment = FactoryGirl.create(:comment, lab: @lab, user: @lab.user)
      get :index, {lab_id: @lab.id}
      expect(assigns(:comments)).to eq([@comment])
    end
  end

  describe "GET show" do
    before(:each) do
      @lab = FactoryGirl.create(:lab)
      @comment = FactoryGirl.create(:comment, lab: @lab, user: @lab.user)
    end

    it "assigns the requested comment as @comment" do
      get :show, {lab_id: @lab.id, id: @comment.to_param}
      expect(assigns(:comment)).to eq(@comment)
    end
  end

  describe "GET new" do
    describe 'when authenticated' do
      login_user
      before(:each) { @lab = FactoryGirl.create(:lab, user: @user) }

      it "assigns a new comment as @comment" do
        get :new, {lab_id: @lab.id}
        expect(assigns(:comment)).to be_a_new(Comment)
      end
    end

    describe 'when not authenticated' do
      before(:each) { @lab = FactoryGirl.create(:lab) }

      it 'should redirect to sign in' do
        get :new, {lab_id: @lab.id}

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET edit" do
    describe 'when authenticated' do
      login_user
      before(:each) do
        @lab = FactoryGirl.create(:lab, user: @user)
        @comment = FactoryGirl.create(:comment, lab: @lab, user: @lab.user)
      end

      it "assigns the requested comment as @comment" do

        get :edit, {lab_id: @lab.id, id: @comment.to_param}
        expect(assigns(:comment)).to eq(@comment)
      end
    end

    describe 'when not authenticated' do
      before(:each) do
        @lab = FactoryGirl.create(:lab)
        @comment = FactoryGirl.create(:comment, lab: @lab, user: @lab.user)
      end

      it 'should redirect to sign in' do
        get :edit, {lab_id: @lab.id, id: @comment.to_param}

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST create" do
    describe 'when authenticated' do
      login_user

      describe "with valid params" do
        before(:each) do
          @lab = FactoryGirl.create(:lab, user: @user)
          @attrs = FactoryGirl.attributes_for(:comment)
          @attrs.merge!({lab_id: @lab.id})
        end

        it "creates a new Comment" do
          expect {
            post :create, { lab_id: @lab.id, comment: @attrs }
          }.to change(Comment, :count).by(1)
        end

        it "assigns a newly created comment as @comment" do
          post :create, { lab_id: @lab.id, comment: @attrs }
          expect(assigns(:comment)).to be_a(Comment)
          expect(assigns(:comment)).to be_persisted
        end

        it "redirects to the comment's lab" do
          post :create, { lab_id: @lab.id, comment: @attrs }
          expect(response).to redirect_to(@lab)
        end
      end

      describe "with invalid params" do
        before(:each) do
          @lab = FactoryGirl.create(:lab, user: @user)
        end

        it "assigns a newly created but unsaved comment as @comment" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Comment).to receive(:save).and_return(false)
          post :create, {lab_id: @lab.id, comment: { lab_id: @lab.id, "user_id" => "invalid value" }}
          expect(assigns(:comment)).to be_a_new(Comment)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Comment).to receive(:save).and_return(false)
          post :create, {lab_id: @lab.id, comment: { lab_id: @lab.id, "user_id" => "invalid value" }}
          expect(response).to render_template("new")
        end
      end
    end

    describe 'when not authenticated' do
      before(:each) do
        @lab = FactoryGirl.create(:lab)
        @attrs = FactoryGirl.attributes_for(:comment)
        @attrs.merge!({lab_id: @lab.id})
      end

      it 'should redirect to sign in' do
        post :create, { lab_id: @lab.id, comment: @attrs }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PUT update" do
    describe 'when authenticated' do
      login_user
      before(:each) do
          @lab = FactoryGirl.create(:lab, user: @user)
          @comment = FactoryGirl.create(:comment, lab: @lab, user: @user)
       end

      describe "with valid params" do
        it "updates the requested comment" do

          # Assuming there are no other comments in the database, this
          # specifies that the Comment created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          allow_any_instance_of(Comment).to receive(:update).with({ "user_id" => "1" })
          put :update, {lab_id: @lab.id, id: @comment.to_param, comment: { "user_id" => "1" }}
        end

        it "assigns the requested comment as @comment" do
          put :update, {lab_id: @lab.id, id: @comment.to_param, comment: FactoryGirl.attributes_for(:comment) }

          expect(assigns(:comment)).to eq(@comment)
        end

        it "redirects to the lab" do
          put :update, {lab_id: @lab.id, id: @comment.to_param, comment: FactoryGirl.attributes_for(:comment) }

          expect(response).to redirect_to(@lab)
        end
      end

      describe "with invalid params" do
        it "assigns the comment as @comment" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Comment).to receive(:save).and_return(false)
          put :update, {lab_id: @lab.id, id: @comment.to_param, comment: { "comment" => "" }}
          expect(assigns(:comment)).to eq(@comment)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Comment).to receive(:save).and_return(false)
          put :update, {lab_id: @lab.id, id: @comment.to_param, comment: { "comment" => "" }}
          expect(response).to render_template("edit")
        end
      end
    end

    describe 'when not the user' do
      login_user
      before(:each) do
        @other_user = FactoryGirl.create(:user, email: 'non-owner@test.com', login: 'nonowner')
        @lab = FactoryGirl.create(:lab, user: @user)
        @comment = FactoryGirl.create(:comment, lab: @lab, user: @other_user)
      end

      it 'should not change the comment' do
        put :update, {lab_id: @lab.id, id: @comment.to_param, comment: { "comment" => "random comment" }}
        expect(assigns(:comment)).to eq(@comment)
      end

      it 'should redirect to the lab' do
        put :update, {lab_id: @lab.id, id: @comment.to_param, comment: FactoryGirl.attributes_for(:comment) }
        expect(response).to redirect_to(@lab)
      end
    end

    describe 'when not authenticated' do
      before(:each) do
          @lab = FactoryGirl.create(:lab)
          @comment = FactoryGirl.create(:comment, lab: @lab, user: @lab.user)
        end

      it 'should redirect to sign in' do
        put :update, {lab_id: @lab.id, id: @comment.to_param, comment: FactoryGirl.attributes_for(:comment) }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE destroy" do
    describe 'when authenticated' do
      login_user
      before(:each) do
          @lab = FactoryGirl.create(:lab, user: @user)
          @comment = FactoryGirl.create(:comment, lab: @lab, user: @user)
      end

      it "destroys the requested comment" do
        expect {
          delete :destroy, {lab_id: @lab.id, id: @comment.to_param}
        }.to change(Comment, :count).by(-1)
      end

      it "redirects to the comments list" do
        delete :destroy, {lab_id: @lab.id, id: @comment.to_param}
        expect(response).to redirect_to @lab
      end
    end

    describe 'when not the user' do
      login_user
      before(:each) do
        @other_user = FactoryGirl.create(:user, email: 'non-owner@test.com', login: 'nonowner')
        @lab = FactoryGirl.create(:lab, user: @user)
        @comment = FactoryGirl.create(:comment, lab: @lab, user: @other_user)
      end

      it 'should not destroy the requested comment' do
        expect {
          delete :destroy, {lab_id: @lab.id, id: @comment.to_param}
        }.to change(Comment, :count).by(0)
      end

      it 'should redirect to the lab' do
        delete :destroy, {lab_id: @lab.id, id: @comment.to_param}
        expect(response).to redirect_to @lab
      end
    end
  end

  describe 'when not authenticated' do
    before(:each) do
          @lab = FactoryGirl.create(:lab)
          @comment = FactoryGirl.create(:comment, lab: @lab, user: @lab.user)
      end
    it 'should redirect to sign in' do
      delete :destroy, {lab_id: @lab.id, id: @comment.to_param}

      expect(response).to redirect_to(new_user_session_path)
    end
  end

end
