Rails.application.routes.draw do
  
  resources :spots

  get "questions/men" => "questions#men"
  get "questions/women" => "questions#women"
  resources :questions
  

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
  get "search/hokkaido1" => "pages#hokkaido1"

  get "search/aomori" => "pages#aomori"
  get "search/aomori1" => "pages#aomori1"

  get "search/iwate" => "pages#iwate"
  get "search/iwate1" => "pages#iwate1"

  get "search/miyagi" => "pages#miyagi"
  get "search/miyagi1" => "pages#miyagi1"

  get "search/akita" => "pages#akita"
  get "search/akita1" => "pages#akita1"

  get "search/yamagata" => "pages#yamagata"
  get "search/yamagata1" => "pages#yamagata1"

  get "search/fukushima" => "pages#fukushima"
  get "search/fukushima1" => "pages#fukushima1"

  get "search/ibaraki" => "pages#ibaraki"
  get "search/ibaraki1" => "pages#ibaraki1"

  get "search/tochigi" => "pages#tochigi"
  get "search/tochigi1" => "pages#tochigi1"

  get "search/gunma" => "pages#gunma"
  get "search/gunma1" => "pages#gunma1"

  get "search/saitama" => "pages#saitama"
  get "search/saitama1" => "pages#saitama1"

  get "search/chiba" => "pages#chiba"
  get "search/chiba1" => "pages#chiba1"

  get "search/tokyo" => "pages#tokyo"
  get "search/tokyo1" => "pages#tokyo1"

  get "search/kanagawa" => "pages#kanagawa"
  get "search/kanagawa1" => "pages#kanagawa1"

  get "search/niigata" => "pages#niigata"
  get "search/niigata1" => "pages#niigata1"

  get "search/toyama" => "pages#toyama"
  get "search/toyama1" => "pages#toyama1"

  get "search/ishikawa" => "pages#ishikawa"
  get "search/ishikawa1" => "pages#ishikawa1"

  get "search/fukui" => "pages#fukui"
  get "search/fukui1" => "pages#fukui1"

  get "search/yamanashi" => "pages#yamanashi"
  get "search/yamanashi1" => "pages#yamanashi1"

  get "search/nagano" => "pages#nagano"
  get "search/nagano1" => "pages#nagano1"

  get "search/gifu" => "pages#gifu"
  get "search/gifu1" => "pages#gifu1"

  get "search/shizuoka" => "pages#shizuoka"
  get "search/shizuoka1" => "pages#shizuoka1"

  get "search/aichi" => "pages#aichi"
  get "search/aichi1" => "pages#aichi1"

  get "search/mie" => "pages#mie"
  get "search/mie1" => "pages#mie1"

  get "search/shiga" => "pages#shiga"
  get "search/shiga1" => "pages#shiga1"

  get "search/kyoto" => "pages#kyoto"
  get "search/kyoto1" => "pages#kyoto1"

  get "search/osaka" => "pages#osaka"
  get "search/osaka1" => "pages#osaka1"

  get "search/hyogo" => "pages#hyogo"
  get "search/hyogo1" => "pages#hyogo1"

  get "search/nara" => "pages#nara"
  get "search/nara1" => "pages#nara1"

  get "search/wakayama" => "pages#wakayama"
  get "search/wakayama1" => "pages#wakayama1"

  get "search/tottori" => "pages#tottori"
  get "search/tottori1" => "pages#tottori1"

  get "search/shimane" => "pages#shimane"
  get "search/shimane1" => "pages#shimane1"

  get "search/okayama" => "pages#okayama"
  get "search/okayama1" => "pages#okayama1"

  get "search/hiroshima" => "pages#hirohsima"
  get "search/hiroshima1" => "pages#hirohsima1"

  get "search/yamaguchi" => "pages#yamaguchi"
  get "search/yamaguchi1" => "pages#yamaguchi1"

  get "search/tokushima" => "pages#tokushima"
  get "search/tokushima1" => "pages#tokushima1"

  get "search/kagawa" => "pages#kagawa"
  get "search/kagawa1" => "pages#kagawa1"

  get "search/ehime" => "pages#ehime"
  get "search/ehime1" => "pages#ehime1"

  get "search/kouchi" => "pages#kouchi"
  get "search/kouchi1" => "pages#kouchi1"

  get "search/fukuoka" => "pages#fukuoka"
  get "search/fukuoka1" => "pages#fukuoka1"

  get "search/saga" => "pages#saga"
  get "search/saga1" => "pages#saga1"

  get "search/nagasaki" => "pages#nagasaki"
  get "search/nagasaki1" => "pages#nagasaki1"

  get "search/kumamoto" => "pages#kumamoto"
  get "search/kumamoto1" => "pages#kumamoto1"

  get "search/oita" => "pages#oita"
  get "search/oita1" => "pages#oita1"

  get "search/miyazaki" => "pages#miyazaki"
  get "search/miyazaki1" => "pages#miyazaki1"

  get "search/kagoshima" => "pages#kagoshima"
  get "search/kagoshima1" => "pages#kagoshima1"

  get "search/okinawa" => "pages#okinawa"
  get "search/okinawa1" => "pages#okinawa1"

  get "search/oversea" => "pages#oversea"
  get "search/oversea1" => "pages#oversea1"

  
 
 
 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
