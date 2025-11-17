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

  # 管理者側
  namespace :admin do
    root to: 'homes#top'  # 管理者ホーム画面
    
    resources :items       # 商品管理(一覧・新規登録・編集・詳細)
    resources :genres, only: [:index, :create, :edit, :update]  # ジャンル管理
    resources :customers, only: [:index, :show, :edit, :update]  # 顧客管理
    
    resources :orders, only: [:show, :update] do  # 注文管理
      resources :order_details, only: [:update]  # 注文詳細(製作ステータス更新)
    end
  end

  # 顧客側(Public)
  scope module: :public do
    root to: 'homes#top'  # トップページ
    get '/about' => 'homes#about'  # アバウトページ
    
    # 商品
    resources :items, only: [:index, :show]  # 商品一覧・詳細
    
    # カート
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all'  # カート全削除
      end
    end
    
    # 注文
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confirm'  # 注文確認画面
        get 'thanks'    # 注文完了画面
      end
    end
    
    # 配送先
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    
    # 顧客マイページ
    get '/customers/my_page' => 'customers#show'
    get '/customers/information/edit' => 'customers#edit'
    patch '/customers/information' => 'customers#update'
    get '/customers/unsubscribe' => 'customers#unsubscribe'
    patch '/customers/withdraw' => 'customers#withdraw'
  end
end
