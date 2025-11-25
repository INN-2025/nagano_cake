Rails.application.routes.draw do
  # 顧客側(Public)
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    
    resources :items, only: [:index, :show] do
      collection do
        get 'search'
      end
    end
    
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
        resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get 'thanks'
      end
    end
    
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  
  end
  
  namespace :public do
    get 'customers/my_page', to: 'customers#show', as: 'customer_my_page'
    get 'customers/information/edit', to: 'customers#edit', as: 'customer_edit'
    patch 'customers/information', to: 'customers#update', as: 'customer_update'
    get 'customers/unsubscribe', to: 'customers#unsubscribe', as: 'customer_unsubscribe'
    patch 'customers/withdraw', to: 'customers#withdraw', as: 'customer_withdraw'
  end

  # 管理者用Devise
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  },path: 'admin', path_names: {
  sign_in: 'sign_in',
  sign_out: 'sign_out'
  }
  
  # 顧客用Devise
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # ログアウトがGETメソッドで実行されるルーティング
    devise_scope :customer do
      get '/customers/sign_out' => 'devise/sessions#destroy'
    end

  # 管理者側
  namespace :admin do
    root to: 'homes#top'
    get 'sessions/new'

    resources :items do
      collection do
        get 'search'
      end
    end

    resources :genres, only: [:index, :create, :edit, :update]

    resources :customers, only: [:index, :show, :edit, :update] do
      collection do
        get 'search'
      end
    end

    resources :orders, only: [:index, :show, :update] do
      resources :order_details, only: [:update]
    end
  end



end
