Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  constraints :subdomain => 'api' do
	  namespace :api, path: nil, defaults: {format: 'json'} do
	    namespace :v1 do
	    	resources :users
	    end
	  end
	end
end
