class SurveyController < ApplicationController
  # Create Submission
  def create
    payload = JSON.parse(request.raw_post)
    
    # Parse payload
    respondent_identifier = payload["respondentIdentifier"]
    respondent = Respondent.find_by(identifier: respondent_identifier )
    response_payload = payload["responses"]

    # Create Response
    begin
      submission = Submission.create!(respondent_id: respondent.id)
      responses = []
      response_payload.each do |res|
        question = Question.find_by(id: res["questionId"])
        if question
          response = Response.create!(
            submission_id: submission.id,
            question_id: question.id, 
            body: res["body"])
          responses << response
        end
      end
      submission.responses = responses
      submission.save
      data = {
        responses: response_payload
      }

      render json: data.to_json
    rescue => exception
      render json:exception.to_json
    end
  end

  # Get Average Score for all Questions
  def question_average
    responses = Response.joins(:question).where(questions: { type: "QuestionType::Scored"}).group_by { |d| d[:question_id] }
    grouping = []
    responses.each do |question_id, res|
      score = res.inject(0.0) { |sum, el| sum + el.body.to_i } / res.size
      grouping << {
        questionId: question_id,
        averageScore: score
      }
    end
    
    render json: {
      questionAverages: grouping
    }
  end

  # Scored Question Distribution
  def score_distribution
    question = QuestionType::Scored.all
    data = []
    question.each do |q|
      frequency_1 = q.responses.where(body: "1").count
      frequency_2 = q.responses.where(body: "2").count
      frequency_3 = q.responses.where(body: "3").count
      frequency_4 = q.responses.where(body: "4").count
      frequency_5 = q.responses.where(body: "5").count
      data << {
        questionId: q["id"],
        responseFrequencies: [
          { score: 1, frequency: frequency_1 },
          { score: 2, frequency: frequency_2 },
          { score: 3, frequency: frequency_3 },
          { score: 4, frequency: frequency_4 },
          { score: 5, frequency: frequency_5 }
        ]
      }
    end

    render json: {
      scored_question_distributions: data
    }.to_json
  end

  # Profile Segment Scores
  def profile_segment_scores
    render json: calculate_average_segment
  end

  private
  def calculate_average_segment(gender = nil)
    segment_group_by_gender = Respondent.group_by_gender(gender)
    data_segments = []
    segment_group_by_gender.each do |segment, res|
      # Groupping the response
      respondent_has_submission = res.select { |r| r.submission != nil}
      responses = respondent_has_submission.map { |s| s.submission.responses }.flatten
      response_group_by_question = responses.group_by { |r| r[:question_id]}
      response_average = calculate_average(response_group_by_question)
      segment_definitions = {
        segment: { gender: segment },
        questionAverages: response_average
      }
      data_segments << segment_definitions
    end
    profile_segments = {
      profileSegmentScores: data_segments
    }
    profile_segments.to_json
  end

  def calculate_average(responses)
    grouping = []
    responses.each do |question_id, res|
      score = res.inject(0.0) { |sum, el| sum + el.body.to_i } / res.size
      grouping << {
        questionId: question_id,
        averageScore: score
      }
    end
    grouping
  end
end
