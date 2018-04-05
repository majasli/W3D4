class Question < ApplicationRecord
  validates :question, :poll_id, presence: true

  has_many :answer_choices,
  class_name: "AnswerChoice",
  foreign_key: :question_id,
  primary_key: :id

  belongs_to :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id

  has_many :responses,
    through: :answer_choices,
    source: :response

  def results
    answers = self.answer_choices.includes(:responses)

    choices = Hash.new(0)
    answers.each do |ac|
      choices[ac.answer] = ac.responses.length
    end

    choices
  end

  def results_sql
    results = {}
    questions = Question.find_by_sql([<<-SQL, id])
      SELECT
        answer_choices.answer, COUNT(responses.user_id) as response_count
      FROM
        answer_choices
      LEFT OUTER JOIN
        responses ON answer_choices.id = responses.answer_id
      WHERE
        answer_choices.question_id = ?
      GROUP BY
        answer_choices.id
    SQL
    questions.each do |el|
      results[el.answer] = el.response_count
    end

    results
  end

  def results_ar
    results = {}
    arr = self.answer_choices
      .select('answer_choices.answer, COUNT(responses.id) as response_count')
      .joins('LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_id')
      .group('answer_choices.id')

    arr.each do |el|
      results[el.answer] = el.response_count
    end

    results
  end




end
