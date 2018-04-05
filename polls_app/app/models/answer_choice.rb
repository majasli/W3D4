class AnswerChoice < ApplicationRecord
  validates :answer, :question_id, presence: true

  belongs_to :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id

  has_one :response,
    class_name: "Response",
    foreign_key: :answer_id,
    primary_key: :id


  has_many :responses,
    through: :response,
    source: :respondent
end
