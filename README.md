# GetTradies
Mobile and Web App to connect Clients to Tradespeople

jobs GET    /jobs(.:format)              jobs#index
             POST   /jobs(.:format)              jobs#create
     new_job GET    /jobs/new(.:format)          jobs#new
    edit_job GET    /jobs/:id/edit(.:format)     jobs#edit
         job GET    /jobs/:id(.:format)          jobs#show
             PATCH  /jobs/:id(.:format)          jobs#update
             PUT    /jobs/:id(.:format)          jobs#update
             DELETE /jobs/:id(.:format)          jobs#destroy
    sessions GET    /sessions(.:format)          sessions#index
             POST   /sessions(.:format)          sessions#create
 new_session GET    /sessions/new(.:format)      sessions#new
edit_session GET    /sessions/:id/edit(.:format) sessions#edit
     session GET    /sessions/:id(.:format)      sessions#show
             PATCH  /sessions/:id(.:format)      sessions#update
             PUT    /sessions/:id(.:format)      sessions#update
             DELETE /sessions/:id(.:format)      sessions#destroy
       users GET    /users(.:format)             users#index
             POST   /users(.:format)             users#create
    new_user GET    /users/new(.:format)         users#new
   edit_user GET    /users/:id/edit(.:format)    users#edit
        user GET    /users/:id(.:format)         users#show
             PATCH  /users/:id(.:format)         users#update
             PUT    /users/:id(.:format)         users#update
             DELETE /users/:id(.:format)         users#destroy
