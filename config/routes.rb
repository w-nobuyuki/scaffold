# ユーザーのURLアクセスをどのコントローラーのどのアクションで待ち受けるか設定するファイル
Rails.application.routes.draw do
  # resources :entriesで以下のルーティングを生成している
  # entries   GET    /entries(.:format)                entries#index
  #           POST   /entries(.:format)                entries#create
  # new_entry GET    /entries/new(.:format)            entries#new
  #           GET    /entries/:id/edit(.:format)       entries#edit
  # entry     GET    /entries/:id(.:format)            entries#show
  #           PATCH  /entries/:id(.:format)            entries#update
  #           PUT    /entries/:id(.:format)            entries#update
  #           DELETE /entries/:id(.:format)            entries#destroy
  resources :blogs do
    resources :entries, except: [:index] do
      resources :comments, only: [:create, :destroy] do
        member do
          patch :approve
        end
      end
    end
  end
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get 'home/index'
  root to: 'blogs#index'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
