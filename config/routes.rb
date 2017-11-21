Rails.application.routes.draw do
  resources :spots

  root :to => 'pages#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",:registrations => 'registrations' }

  resources :users, only: [:show]
  get "users/:id/want" => "users#want"
  get "users/:id/done" => "users#done"


  post "likes/:spot_id/create1" => "likes#create1"
  post "likes/:spot_id/create2" => "likes#create2"
  post "likes/:spot_id/update1" => "likes#update1"
  post "likes/:spot_id/update2" => "likes#update2"
  post "likes/:spot_id/destroy1" => "likes#destroy1"
  post "likes/:spot_id/destroy2" => "likes#destroy2"

  get "search/prefecture" => "pages#prefecture"

  get "search/hokkaido" => "pages#hokkaido"
  get "search/aomori" => "pages#aomori"
  get "search/iwate" => "pages#iwate"
  get "search/miyagi" => "pages#miyagi"
  get "search/akita" => "pages#akita"
  get "search/yamagata" => "pages#yamagata"
  get "search/fukushima" => "pages#fukushima"
  get "search/ibaraki" => "pages#ibaraki"
  get "search/tochigi" => "pages#tochigi"
  get "search/gunma" => "pages#gunma"
  get "search/saitama" => "pages#saitama"
  get "search/chiba" => "pages#chiba"
  get "search/tokyo" => "pages#tokyo"
  get "search/kanagawa" => "pages#kanagawa"
  get "search/niigata" => "pages#niigata"
  get "search/toyama" => "pages#toyama"
  get "search/ishikawa" => "pages#ishikawa"
  get "search/fukui" => "pages#fukui"
  get "search/yamanashi" => "pages#yamanashi"
  get "search/nagano" => "pages#nagoya"
  get "search/gifu" => "pages#gifu"
  get "search/shizuoka" => "pages#shizuoka"
  get "search/aichi" => "pages#aichi"
  get "search/mie" => "pages#mie"
  get "search/shiga" => "pages#shiga"
  get "search/kyoto" => "pages#kyoto"
  get "search/osaka" => "pages#osaka"
  get "search/hyogo" => "pages#hyogo"
  get "search/nara" => "pages#nara"
  get "search/wakayama" => "pages#wakayama"
  get "search/tottori" => "pages#tottori"
  get "search/shimane" => "pages#shimane"
  get "search/okayama" => "pages#okayama"
  get "search/hiroshima" => "pages#hirohsima"
  get "search/yamaguchi" => "pages#yamaguchi"
  get "search/tokushima" => "pages#tokushima"
  get "search/kagawa" => "pages#kagawa"
  get "search/ehime" => "pages#ehime"
  get "search/kouchi" => "pages#kouchi"
  get "search/fukuoka" => "pages#fukuoka"
  get "search/saga" => "pages#saga"
  get "search/nagasaki" => "pages#nagasaki"
  get "search/kumamoto" => "pages#kumamoto"
  get "search/oita" => "pages#oita"
  get "search/miyazaki" => "pages#miyazaki"
  get "search/kagoshima" => "pages#kagoshima"
  get "search/okinawa" => "pages#okinawa"
  get "search/oversea" => "pages#oversea"

  get "search/hokkaido1" => "pages#hokkaido1"
 
 
 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
