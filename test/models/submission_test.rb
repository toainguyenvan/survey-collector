require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  test "Can not submit twice per Respondent" do
    submission1 = Submission.create(respondent_id: 1)
    submission2 = Submission.create(respondent_id: 1)
    assert_not submission2.save, "One respondent can not submit once!"
  end

  test "Create Submission" do
    submission = Submission.find(1)
    response = submission.responses
    assert_equal 1, response[0].question_id
    assert_equal 2, response[1].question_id
  end
end
