Rails.application.routes.draw do
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

namespace :public do
    get 'top' =>'homes#top'
    get 'homes/about'

    resources :items,only: [:index,:show]

   	resources :customers,only: [:show,:edit,:update] do
  		collection do
  	     get 'quit'
  	     patch 'out'
  	  end
  	end

    resources :cart_items,only: [:index,:update,:create,:destroy] do
      collection do
        delete '/' => 'cart_items#all_destroy'
      end
    end

    resources :orders,only: [:new,:index,:show,:create] do
      collection do
        post 'comfirm'
        get 'thanx'
      end
    end

    resources :addresses,only: [:index,:create,:edit,:update,:destroy]
  end

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    get 'top'=>'homes#top'
    resources :items,only: [:index,:new,:create,:show,:edit,:update,]
    resources :genres,only: [:index,:create,:edit,:update]
    resources :customers,only: [:index,:show,:edit,:update]
    resources :order_items, only: [:update]
    resources :orders,only: [:show,:update] do
  	  member do
        get :current_index
        resource :order_details,only: [:update]
      end
      collection do
        get :today_order_index
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
