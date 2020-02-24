require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "Two types of question" do
    scored_question = Question.find(1)
    open_ended_question = Question.find(2)
    assert_equal 'QuestionType::Scored', scored_question.type
    assert_equal 'QuestionType::OpenEnded', open_ended_question.type
  end
end
