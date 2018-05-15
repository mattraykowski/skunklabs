Rails.application.routes.draw do

  resources :suggestions do
    member do
      # These get passed to the SuggestionVotes controller for voting.
      get "vote", to: "suggestion_votes#vote"
      get "unvote", to: "suggestion_votes#unvote"
    end
  end

  resources :labs do
    member do
      put :start
      put :complete
      put :block
      put :abandon
    end

    resources :team_roles do
      member do
        get :take_role
        get :release_role
      end
    end

    resources :comments
    resources :link_resources

    get 'support' => 'lab_supporters#support'
    get 'unsupport' => 'lab_supporters#unsupport'
    get 'supporters' => 'lab_supporters#supporters'
  end

  scope '/admin' do
    resources :role_types
    resources :focus_types
    resources :suggestion_states
    resources :users, only: [:index, :edit] do
      member do
        put :admin
        put :team
        put :notices
      end

      collection do
        get 'noticelist'
      end
    end
  end

  get '/profile/show' => 'profile#show'
  put '/profile/notices' => 'profile#notices'


  devise_for :users
  get "pages/index"
  get "pages/about"
  get '/recent_updates' => 'pages#recent_updates'
  root to: 'pages#index'
end
