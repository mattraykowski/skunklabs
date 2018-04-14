require 'spec_helper'

describe SuggestionsController do
  before(:each) { ActionMailer::Base.delivery_method = :test }

  describe "GET index" do
    it "assigns all suggestions as @suggestions" do
      suggestion = FactoryGirl.create(:suggestion, :with_creator)
      get :index, {}
      expect(assigns(:suggestions)).to eq([suggestion])
    end
  end

  describe "GET show" do
    it "assigns the requested suggestion as @suggestion" do
      suggestion = FactoryGirl.create(:suggestion, :with_creator)
      get :show, {id: suggestion.to_param}
      expect(assigns(:suggestion)).to eq(suggestion)
    end
  end

  describe "GET new" do
    describe "when authenticated" do
      login_user

      it "assigns a new suggestion as @suggestion" do
        get :new, {}
        expect(assigns(:suggestion)).to be_a_new(Suggestion)
      end
    end

    describe 'when not authenticated' do
      it 'should redirect to login' do
        get :new, {}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET edit" do
    describe "when authenticated" do
      login_user

      it "assigns the requested suggestion as @suggestion" do
        suggestion = FactoryGirl.create(:suggestion, creator: @user)
        get :edit, {id: suggestion.to_param}
        expect(assigns(:suggestion)).to eq(suggestion)
      end
    end

    describe "when not authenticated" do
      it 'should redirect to login' do
        suggestion = FactoryGirl.create(:suggestion, :with_creator)
        get :edit, {id: suggestion.to_param}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST create" do

    describe "when authenticated" do
      login_user

      describe "with valid params" do
        before(:each) do
          # Stage the attributes
          suggestion_state = FactoryGirl.create(:suggestion_state)
          @attrs = FactoryGirl.attributes_for(:suggestion)
          @attrs[:status_id] = suggestion_state.id

          # Create a 'team' to be emailed.
          @team_user = FactoryGirl.create :user, email: 'teamuser@test.com', login: 'teamuser', suggestion_team_member: true
        end

        it "creates a new Suggestion" do
          expect {
            post :create, {suggestion: @attrs}
          }.to change(Suggestion, :count).by(1)
        end

        it "assigns a newly created suggestion as @suggestion" do
          post :create, {suggestion: @attrs}
          expect(assigns(:suggestion)).to be_a(Suggestion)
          expect(assigns(:suggestion)).to be_persisted
        end

        it "redirects to the list of suggestions" do
          post :create, {suggestion: @attrs}
          expect(response).to redirect_to suggestions_path
        end

        it "should email all team members" do
          expect { post :create, {suggestion: @attrs} }.to change { ActionMailer::Base.deliveries.count }.by(1)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved suggestion as @suggestion" do
        # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Suggestion).to receive(:save).and_return(false)
          post :create, {suggestion: { "title" => "" }}
          expect(assigns(:suggestion)).to be_a_new(Suggestion)
        end

        it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Suggestion).to receive(:save).and_return(false)
          post :create, {suggestion: { "title" => "" }}
          expect(response).to render_template("new")
        end
      end
    end

    describe 'when not authenticated' do
      it 'should redirect to login' do
        post :create, {suggestion: @attrs}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PUT update" do
    describe "when authenticated" do
      login_user
      before(:each) { @suggestion = FactoryGirl.create(:suggestion, creator: @user) }

      describe "with valid params" do
        it "updates the requested suggestion" do
          # Assuming there are no other suggestions in the database, this
          # specifies that the Suggestion created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          allow_any_instance_of(Suggestion).to receive(:update).with({ "title" => "MyString" })
          put :update, {id: @suggestion.to_param, suggestion: { "title" => "MyString" }}
        end

        it "assigns the requested suggestion as @suggestion" do
          put :update, {id: @suggestion.to_param, suggestion: { "title" => "MyString" }}
          expect(assigns(:suggestion)).to eq(@suggestion)
        end

        it "redirects to the list of suggestions" do
          put :update, {id: @suggestion.to_param, suggestion: { "title" => "MyString" }}
          expect(response).to redirect_to suggestions_path
        end
      end

      describe "with invalid params" do
        it "assigns the suggestion as @suggestion" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Suggestion).to receive(:save).and_return(false)
          put :update, {id: @suggestion.to_param, suggestion: { "title" => "" }}
          expect(assigns(:suggestion)).to eq(@suggestion)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Suggestion).to receive(:save).and_return(false)
          put :update, {id: @suggestion.to_param, suggestion: { "title" => "" }}
          expect(response).to render_template("edit")
        end
      end

    end

    describe 'when not authenticated' do
      it 'should redirect to login' do
        user = FactoryGirl.create :user
        suggestion = FactoryGirl.create :suggestion, creator: user
        put :update, { id: suggestion.to_param, suggestion: { 'title' => '1' }}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

  describe "DELETE destroy" do
    describe "when authenticated" do
      login_user
      before(:each) { @suggestion = FactoryGirl.create(:suggestion, creator: @user) }
      it "destroys the requested suggestion" do
        expect {
          delete :destroy, {id: @suggestion.to_param}
        }.to change(Suggestion, :count).by(-1)
      end

      it "redirects to the suggestions list" do
        delete :destroy, {id: @suggestion.to_param}
        expect(response).to redirect_to(suggestions_url)
      end
    end

    describe 'when not authenticated' do
      it 'should redirect to login' do
        user = FactoryGirl.create :user
        suggestion = FactoryGirl.create :suggestion, creator: user
        delete :destroy, {  id: suggestion.to_param}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
