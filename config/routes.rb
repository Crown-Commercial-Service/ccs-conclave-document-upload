Rails.application.routes.draw do
  post '/documents', to: 'document_upload#create'
end
