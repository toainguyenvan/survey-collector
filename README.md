# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

2.5.7

* System dependencies

- Docker
- Docker compose
- Postgres

* Configuration

- Build
```bash
docker-compose build
```

- Start docker
```bash
docker-compose up -d
```

* Database creation

- Migration
```bash
docker-compose run web rake db:migrate
```

- Create Seed database

Import Table `Question` and `Respondent` from `questions.yml` and `respondents.yml`
```bash
docker-compose run web rake db:import_data
```

* How to run the test suite

- Test casses
```bash
docker-compose run web rspec
```

- API `Create Submission` (Create submission): 
Endpoint: `http://localhost:3000/survey`
Method: `POST`
Payload:
```json
{
  "respondentIdentifier": "00001",
  "responses": [
    {
      "questionId": 1,
      "body":       4
    },
    {
      "questionId": 2,
      "body":       "Unclear expectations"
    },
    ...
  ]
}
```

- API `Get Average Scores` (for all questions):
Endpoint: `http://localhost:3000/survey/question_average`
Method: `GET`
Payload: {}

- API `Get Scores Distribution` (for all questions):
Endpoint: `http://localhost:3000/survey/score_distribution`
Method: `GET`
Payload: {}

- API `Get Profile Segment Scores` (group by `Gender`):
Endpoint: `http://localhost:3000/survey/profile_segment_scores`
Method: `GET`
Payload: {}

