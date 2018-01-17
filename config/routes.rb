Rails.application.routes.draw do
  
  root :to => 'articles#search'

  get "/homes" => "homes#index"

  get "spots/result" => "spots#result"
  get "spots/rank" => "spots#rank"
  get 'spots/:id/pictures' => 'spots#pictures'
  get 'spots/:id/pictures/add' => 'spots#addpictures'
  get 'spots/:id/tags' => 'spots#tags'
  post "spots/:id/destroy" => "spots#destroy"
  resources :spots
  

  resources :pictures, only: [:create, :destroy]

  resources :snaps, only: [:create, :destroy]
  
  get "articles/result" => "articles#result"
  get 'articles/:id/snaps' => 'articles#snaps'
  get 'articles/:id/snaps/add' => 'articles#addsnaps'
  resources :articles, only: [:index, :new, :create, :edit, :update]
  get "articles/show" => "articles#show"
  get "articles/1" => "articles#show1"
  get "articles/2" => "articles#show2"
  get "articles/3" => "articles#show3"
  get "articles/4" => "articles#show4"
  get "articles/5" => "articles#show5"
  get "articles/6" => "articles#show6"
  get "articles/7" => "articles#show7"
  get "articles/8" => "articles#show8"


  get "questions/men" => "questions#men"
  get "questions/women" => "questions#women"
  resources :questions
  

  

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",:registrations => 'registrations' }

  resources :users, only: [:show]
  get "users/:id/want" => "users#want"
  get "users/:id/done" => "users#done"
  get "users/:id/spot" => "users#spot"
  get "users/:id/clip" => "users#clip"
  get "users/:id/article" => "users#article"


  post "likes/:spot_id/create1" => "likes#create1"
  post "likes/:spot_id/create2" => "likes#create2"
  post "likes/:spot_id/update1" => "likes#update1"
  post "likes/:spot_id/update2" => "likes#update2"
  post "likes/:spot_id/destroy1" => "likes#destroy1"
  post "likes/:spot_id/destroy2" => "likes#destroy2"

  post "clips/:article_id/create" => "clips#create"
  post "clips/:article_id/destroy" => "clips#destroy"

  post "answers/:question_id/create1" => "answers#create1"
  post "answers/:question_id/create2" => "answers#create2"
  post "answers/:question_id/update1" => "answers#update1"
  post "answers/:question_id/update2" => "answers#update2"
  post "answers/:question_id/destroy1" => "answers#destroy1"
  post "answers/:question_id/destroy2" => "answers#destroy2"



  resources :comments, only: [:create, :destroy]

  get "search/tags" => "tags#search"
  get "search/tags/index" => "tags#index"

  get "search/articles/tags" => "taggings#search"
  get "search/articles/tags/index" => "taggings#index"


  get "search/scenes" => "scenes#search"
  get "search/scenes/index" => "scenes#index"

  get "search/articles/scenes" => "scenegings#search"
  get "search/articles/scenes/index" => "scenegings#index"


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
  get "search/tokyo2" => "pages#tokyo2"
  get "search/tokyo3" => "pages#tokyo3"
  get "search/tokyo4" => "pages#tokyo4"
  get "search/tokyo5" => "pages#tokyo5"
  get "search/tokyo6" => "pages#tokyo6"
  get "search/tokyo7" => "pages#tokyo7"
  get "search/tokyo8" => "pages#tokyo8"
  get "search/tokyo9" => "pages#tokyo9"
  get "search/tokyo10" => "pages#tokyo10"
  get "search/tokyo11" => "pages#tokyo11"
  get "search/tokyo12" => "pages#tokyo12"
  get "search/tokyo13" => "pages#tokyo13"
  get "search/tokyo14" => "pages#tokyo14"
  get "search/tokyo15" => "pages#tokyo15"
  get "search/tokyo16" => "pages#tokyo16"
  get "search/tokyo17" => "pages#tokyo17"
  get "search/tokyo18" => "pages#tokyo18"
  get "search/tokyo19" => "pages#tokyo19"
  get "search/tokyo20" => "pages#tokyo20"
  get "search/tokyo21" => "pages#tokyo21"
  get "search/tokyo22" => "pages#tokyo22"
  get "search/tokyo23" => "pages#tokyo23"
  get "search/tokyo24" => "pages#tokyo24"
  get "search/tokyo25" => "pages#tokyo25"
  get "search/tokyo26" => "pages#tokyo26"
  get "search/tokyo27" => "pages#tokyo27"
  get "search/tokyo28" => "pages#tokyo28"
  get "search/tokyo29" => "pages#tokyo29"
  get "search/tokyo30" => "pages#tokyo30"
  get "search/tokyo31" => "pages#tokyo31"
  get "search/tokyo32" => "pages#tokyo32"
  get "search/tokyo33" => "pages#tokyo33"
  get "search/tokyo34" => "pages#tokyo34"
  get "search/tokyo35" => "pages#tokyo35"
  get "search/tokyo36" => "pages#tokyo36"
  get "search/tokyo37" => "pages#tokyo37"
  get "search/tokyo38" => "pages#tokyo38"
  get "search/tokyo98" => "pages#tokyo98"
  get "search/tokyo99" => "pages#tokyo99"
  

  get "search/tokyo2e" => "pages#tokyo2e"
  get "search/tokyo3e" => "pages#tokyo3e"
  get "search/tokyo4e" => "pages#tokyo4e"
  get "search/tokyo5e" => "pages#tokyo5e"
  get "search/tokyo6e" => "pages#tokyo6e"
  get "search/tokyo7e" => "pages#tokyo7e"
  get "search/tokyo8e" => "pages#tokyo8e"
  get "search/tokyo9e" => "pages#tokyo9e"
  get "search/tokyo10e" => "pages#tokyo10e"
  get "search/tokyo11e" => "pages#tokyo11e"
  get "search/tokyo12e" => "pages#tokyo12e"
  get "search/tokyo13e" => "pages#tokyo13e"
  get "search/tokyo14e" => "pages#tokyo14e"
  get "search/tokyo15e" => "pages#tokyo15e"
  get "search/tokyo16e" => "pages#tokyo16e"
  get "search/tokyo17e" => "pages#tokyo17e"
  get "search/tokyo18e" => "pages#tokyo18e"
  get "search/tokyo19e" => "pages#tokyo19e"
  get "search/tokyo20e" => "pages#tokyo20e"
  get "search/tokyo21e" => "pages#tokyo21e"
  get "search/tokyo22e" => "pages#tokyo22e"
  get "search/tokyo23e" => "pages#tokyo23e"
  get "search/tokyo24e" => "pages#tokyo24e"
  get "search/tokyo25e" => "pages#tokyo25e"
  get "search/tokyo26e" => "pages#tokyo26e"
  get "search/tokyo27e" => "pages#tokyo27e"
  get "search/tokyo28e" => "pages#tokyo28e"
  get "search/tokyo29e" => "pages#tokyo29e"
  get "search/tokyo30e" => "pages#tokyo30e"
  get "search/tokyo31e" => "pages#tokyo31e"
  get "search/tokyo32e" => "pages#tokyo32e"
  get "search/tokyo33e" => "pages#tokyo33e"
  get "search/tokyo34e" => "pages#tokyo34e"
  get "search/tokyo35e" => "pages#tokyo35e"
  get "search/tokyo36e" => "pages#tokyo36e"
  get "search/tokyo37e" => "pages#tokyo37e"
  get "search/tokyo38e" => "pages#tokyo38e"
  get "search/tokyo99e" => "pages#tokyo99e"

  

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
