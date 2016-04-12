Rails.application.routes.draw do
  root 'home#show'
  get 'ticket/teacher_index'
  get 'ticket/teacher_show'
  post 'ticket/student'
  get 'ticket/student'
  get 'ticket/show'
  post 'ticket/index'
  get 'ticket/index'
  get 'ticket/new'
  post 'ticket/new'
  post 'ticket/update'
  mount LtiProvider::Engine => "/"
  mount CanvasOauth::Engine => "/canvas_oauth"
end