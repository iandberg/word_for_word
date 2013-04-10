WordForWord::Application.routes.draw do

	get "home/index"
	
	match "users/login" => "users#login"
	match "users/register" => "users#register"
	match "words/results" => "words#results"
	
	root :to => "home#index"
end
