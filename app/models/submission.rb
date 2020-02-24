class Submission < ApplicationRecord
  belongs_to :respondent
  has_many :responses
  validates :respondent_id, uniqueness: true
end
