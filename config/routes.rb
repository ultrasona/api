Rails.application.routes.draw do
  root to: redirect('/pros/search')

  get 'pros/search', to: 'pros#search', as: 'search_available_pro'
end
