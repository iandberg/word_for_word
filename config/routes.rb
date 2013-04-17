WordForWord::Application.routes.draw do

	get "home/index"
	
	match "users/login" => "users#login"
	match "users/login_go" => "users#login_go"
	match "users/logout" => "users#logout"
	
	resources :users
	
	match "words/" => "words#index"
	match "words/search" => "words#search"
	match "words/index" => "words#index"
	match "words/new" => "words#new"
	match "words/autocomplete" => "words#autocomplete"
	match "words/avail_lists" => "words#avail_lists"
	match "words/get_a_list" => "words#get_a_list"
	match "words/add_word" => "words#add_word"
	
	root :to => "home#index"
end
