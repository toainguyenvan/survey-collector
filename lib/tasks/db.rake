namespace :db do
  desc "TODO"
  task import_data: :environment do
    question = YAML.load_file("#{Rails.root.to_s}/questions.yml")
    question.each do |q|
      if q["type"] == 'scored'
        QuestionType::Scored.create(prompt: q["prompt"], optional: q["optional"])
      else
        QuestionType::OpenEnded.create(prompt: q["prompt"], optional: q["optional"])
      end
    end

    respondents = YAML.load_file("#{Rails.root.to_s}/respondents.yml")
    respondents.each do |r|
      Respondent.create(identifier: r["identifier"], gender: r["profile"]["gender"], department: r["profile"]["department"])
    end
  end
end
