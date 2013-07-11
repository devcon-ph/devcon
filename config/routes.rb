Devcon::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users, :controllers => { :registrations => "registrations", omniauth_callbacks: "omniauth_callbacks" }
  resources :users, :only => [:show]

  devise_scope :user do
    get 'login', :to => 'devise/sessions#new', :as => :new_user_session
    delete 'logout', :to => 'devise/sessions#destroy', :as => :destroy_user_session
    get 'register', :to => 'registrations#new', :as => :new_user_registration
    get 'settings', :to => 'devise/registrations#edit', :as => :edit_user_registration
  end

  resources :articles do
    resources :comments, :except => [:new]
  end

  resources :events do 
    collection do
      get :previous
    end

    member do
      get :ics
    end
    resources :event_partners, :except => [:index, :show]
    resources :participants, :except => [:index, :show]
  end
  resources :partners, :only => [:index, :show]
  resources :resource_people
  resources :venues

  resources :entities
  resources :categories
  resources :tags

  match '/contact', :to => 'static_pages#contact'
  match '/faq', :to => 'static_pages#faq', :as => 'faq'
  match '/feed' => 'static_pages#feed',
      :as => :feed,
      :defaults => { :format => 'atom' }

  root :to => 'static_pages#home'
  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'static_pages#error_404'
  end
end
#== Route Map
# Generated on 15 Mar 2013 08:29
#
#         new_user_session GET    /users/sign_in(.:format)                            devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                            devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                           devise/sessions#destroy
#            user_password POST   /users/password(.:format)                           devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)                       devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)                      devise/passwords#edit
#                          PUT    /users/password(.:format)                           devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                             registrations#cancel
#        user_registration POST   /users(.:format)                                    registrations#create
#    new_user_registration GET    /users/sign_up(.:format)                            registrations#new
#   edit_user_registration GET    /users/edit(.:format)                               registrations#edit
#                          PUT    /users(.:format)                                    registrations#update
#                          DELETE /users(.:format)                                    registrations#destroy
#                     user GET    /users/:id(.:format)                                users#show
#         new_user_session GET    /login(.:format)                                    devise/sessions#new
#     destroy_user_session DELETE /logout(.:format)                                   devise/sessions#destroy
#    new_user_registration GET    /register(.:format)                                 registrations#new
#   edit_user_registration GET    /settings(.:format)                                 devise/registrations#edit
#         article_comments GET    /articles/:article_id/comments(.:format)            comments#index
#                          POST   /articles/:article_id/comments(.:format)            comments#create
#     edit_article_comment GET    /articles/:article_id/comments/:id/edit(.:format)   comments#edit
#          article_comment GET    /articles/:article_id/comments/:id(.:format)        comments#show
#                          PUT    /articles/:article_id/comments/:id(.:format)        comments#update
#                          DELETE /articles/:article_id/comments/:id(.:format)        comments#destroy
#                 articles GET    /articles(.:format)                                 articles#index
#                          POST   /articles(.:format)                                 articles#create
#              new_article GET    /articles/new(.:format)                             articles#new
#             edit_article GET    /articles/:id/edit(.:format)                        articles#edit
#                  article GET    /articles/:id(.:format)                             articles#show
#                          PUT    /articles/:id(.:format)                             articles#update
#                          DELETE /articles/:id(.:format)                             articles#destroy
#          previous_events GET    /events/previous(.:format)                          events#previous
#                ics_event GET    /events/:id/ics(.:format)                           events#ics
#     event_event_partners POST   /events/:event_id/event_partners(.:format)          event_partners#create
#  new_event_event_partner GET    /events/:event_id/event_partners/new(.:format)      event_partners#new
# edit_event_event_partner GET    /events/:event_id/event_partners/:id/edit(.:format) event_partners#edit
#      event_event_partner PUT    /events/:event_id/event_partners/:id(.:format)      event_partners#update
#                          DELETE /events/:event_id/event_partners/:id(.:format)      event_partners#destroy
#       event_participants POST   /events/:event_id/participants(.:format)            participants#create
#    new_event_participant GET    /events/:event_id/participants/new(.:format)        participants#new
#   edit_event_participant GET    /events/:event_id/participants/:id/edit(.:format)   participants#edit
#        event_participant PUT    /events/:event_id/participants/:id(.:format)        participants#update
#                          DELETE /events/:event_id/participants/:id(.:format)        participants#destroy
#                   events GET    /events(.:format)                                   events#index
#                          POST   /events(.:format)                                   events#create
#                new_event GET    /events/new(.:format)                               events#new
#               edit_event GET    /events/:id/edit(.:format)                          events#edit
#                    event GET    /events/:id(.:format)                               events#show
#                          PUT    /events/:id(.:format)                               events#update
#                          DELETE /events/:id(.:format)                               events#destroy
#                 partners GET    /partners(.:format)                                 partners#index
#                  partner GET    /partners/:id(.:format)                             partners#show
#          resource_people GET    /resource_people(.:format)                          resource_people#index
#                          POST   /resource_people(.:format)                          resource_people#create
#      new_resource_person GET    /resource_people/new(.:format)                      resource_people#new
#     edit_resource_person GET    /resource_people/:id/edit(.:format)                 resource_people#edit
#          resource_person GET    /resource_people/:id(.:format)                      resource_people#show
#                          PUT    /resource_people/:id(.:format)                      resource_people#update
#                          DELETE /resource_people/:id(.:format)                      resource_people#destroy
#                   venues GET    /venues(.:format)                                   venues#index
#                          POST   /venues(.:format)                                   venues#create
#                new_venue GET    /venues/new(.:format)                               venues#new
#               edit_venue GET    /venues/:id/edit(.:format)                          venues#edit
#                    venue GET    /venues/:id(.:format)                               venues#show
#                          PUT    /venues/:id(.:format)                               venues#update
#                          DELETE /venues/:id(.:format)                               venues#destroy
#                 entities GET    /entities(.:format)                                 entities#index
#                          POST   /entities(.:format)                                 entities#create
#               new_entity GET    /entities/new(.:format)                             entities#new
#              edit_entity GET    /entities/:id/edit(.:format)                        entities#edit
#                   entity GET    /entities/:id(.:format)                             entities#show
#                          PUT    /entities/:id(.:format)                             entities#update
#                          DELETE /entities/:id(.:format)                             entities#destroy
#               categories GET    /categories(.:format)                               categories#index
#                          POST   /categories(.:format)                               categories#create
#             new_category GET    /categories/new(.:format)                           categories#new
#            edit_category GET    /categories/:id/edit(.:format)                      categories#edit
#                 category GET    /categories/:id(.:format)                           categories#show
#                          PUT    /categories/:id(.:format)                           categories#update
#                          DELETE /categories/:id(.:format)                           categories#destroy
#                     tags GET    /tags(.:format)                                     tags#index
#                          POST   /tags(.:format)                                     tags#create
#                  new_tag GET    /tags/new(.:format)                                 tags#new
#                 edit_tag GET    /tags/:id/edit(.:format)                            tags#edit
#                      tag GET    /tags/:id(.:format)                                 tags#show
#                          PUT    /tags/:id(.:format)                                 tags#update
#                          DELETE /tags/:id(.:format)                                 tags#destroy
#                  contact        /contact(.:format)                                  static_pages#contact
#                      faq        /faq(.:format)                                      static_pages#faq
#                     feed        /feed(.:format)                                     static_pages#feed {:format=>"atom"}
#                     root        /                                                   static_pages#home
# 
# Routes for Ckeditor::Engine:
#         pictures GET    /pictures(.:format)             ckeditor/pictures#index
#                  POST   /pictures(.:format)             ckeditor/pictures#create
#          picture DELETE /pictures/:id(.:format)         ckeditor/pictures#destroy
# attachment_files GET    /attachment_files(.:format)     ckeditor/attachment_files#index
#                  POST   /attachment_files(.:format)     ckeditor/attachment_files#create
#  attachment_file DELETE /attachment_files/:id(.:format) ckeditor/attachment_files#destroy
