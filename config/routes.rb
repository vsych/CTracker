CurrencyTracker::Application.routes.draw do
  root :to => "currencies#index"

  resources :countries, :only => [:index, :show] do
    member do
      get :visit
    end
    collection do
      get :statistic
    end
  end
  resources :currencies, :only => [:index, :show] do
    member do
      get :collect
    end
    collection do
      get :statistic
    end
  end
  resources :sessions, :only => [:new, :create] do
    collection do
      delete :destroy
    end
  end
end
