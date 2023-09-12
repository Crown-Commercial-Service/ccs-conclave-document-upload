Rails.application.routes.draw do
  post '/documents', to: 'document_upload#create'
  get '/health_check', to: 'health_check#index'
end
