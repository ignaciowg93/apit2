Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'usuario/:id', to: 'usuarios#show'
  get 'usuario/' , to: 'usuarios#index'
  post 'usuario/:id', to:'usuarios#update'
  delete 'usuario/:id', to: 'usuarios#destroy'
  put 'usuario/', to: 'usuarios#create'

  

  #cambiar para los métodos y cambiar el nombre de la ruta. 
end
