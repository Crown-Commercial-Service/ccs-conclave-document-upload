Rails.application.routes.draw do
  post '/document-upload', to: 'document_upload#create'
end
