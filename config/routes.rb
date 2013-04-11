WordForWord::Application.routes.draw do

	get "home/index"
	
	match "words/" => "words#index"
	match "users/login" => "users#login"
	match "users/register" => "users#register"
	match "words/search" => "words#search"
	match "words/index" => "words#index"
	
	root :to => "home#index"
end
