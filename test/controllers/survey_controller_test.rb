require 'test_helper'

class SurveyControllerTest < ActionDispatch::IntegrationTest
  test "GET: /question_average success" do
    get survey_question_average_url
    assert_response :success
    expected_response = {
      "questionAverages": [
        {
          "questionId": questions(:one).id,
          "averageScore": 1.0
        }
      ]
    }.to_json
    assert_equal expected_response, response.body
  end
end
