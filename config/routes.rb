Rails.application.routes.draw do
  # 管理者用Devise
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
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
    
    resources :items
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]

    resources :order, only:[:show, :update] do
      resources :order_details, only: [:update]
    end
  end


  # 顧客側(Public)
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    
    resources :items, only: [:index, :show]
    
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
    
    get '/customers/my_page' => 'customers#show'
    get '/customers/information/edit' => 'customers#edit'
    patch '/customers/information' => 'customers#update'
    get '/customers/unsubscribe' => 'customers#unsubscribe'
    patch '/customers/withdraw' => 'customers#withdraw'
  end
end
