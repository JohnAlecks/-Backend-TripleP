Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	constraints :subdomain => 'api' do
	  namespace :api, path: nil, defaults: {format: 'json'} do
	    namespace :v1 do
	    get   'information',	to: 'users#index'
	    get	  'pins',	to: 'pins#get_pins'
	    post  'create/pin', to: 'pins#create_pin'
    	devise_for :users, controllers: {
    		registrations: 'api/v1/registrations',
    		sessions: 'api/v1/sessions'
      	}
	    end
	  end
	end
end
