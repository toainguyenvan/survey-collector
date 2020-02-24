class Respondent < ApplicationRecord
  has_one :submission

  def self.group_by_gender(gender = nil)
    respondent_group_by_gender = Respondent.all.group_by { |r| r[:gender] }
    gender ? respondent_group_by_gender[gender] : respondent_group_by_gender
  end
end
