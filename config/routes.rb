Rails.application.routes.draw do
	
	root 'jobs#index'

	resources :feeds do
		member do
			resources :jobs, only: [:index, :show]
		end
	end

	resources :jobs

	get 'about', to: 'pages#about'
end
