Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'

  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  get "/dashboard", to: "dashboard#index"
  root "dashboard#home"

  resources :students, only: [] do
    collection do
      get :enrolled_courses
    end
  end

  resources :courses do
    resources :sections, only: [ :index ]
    member do
      get :watch
      get :view
      get 'watch/:lesson_id', to: 'courses#watch_lesson', as: :watch_lesson
    end

    resources :enrollments, only: [:create]
  end


  resources :instructor, only: [], as: 'instructor_courses' do
    collection do
      get :courses, to: 'instructor#courses', as: ''
    end
  end


  # Defines the root path route ("/")
  # root "posts#index"
end
