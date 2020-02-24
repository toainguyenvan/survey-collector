Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :survey, only: [:create] do
  end
  get 'survey/question_average', :to => 'survey#question_average'
  get 'survey/score_distribution', :to => 'survey#score_distribution'
  get 'survey/profile_segment_scores', :to => 'survey#profile_segment_scores'
end
