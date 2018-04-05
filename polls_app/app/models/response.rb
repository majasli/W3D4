class Response < ApplicationRecord
  validates :user_id, :answer_id, presence: true
  validate :cannot_respond_more_than_once
  validate :cannot_repond_to_own_poll

  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_id,
    primary_key: :id

  belongs_to :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  has_one :question,
    through: :answer_choice,
    source: :question

  has_one :poll,
    through: :question,
    source: :poll

  def sibling_responses
    # find a question, return all responses to that question
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end

  def cannot_respond_more_than_once
    if self.respondent_already_answered?
      errors[:response] << "Whoa! Can't respond more than once dude!"
    end
  end

  def cannot_repond_to_own_poll
    if self.question.poll.author_id == self.user_id
      errors[:author] << "Hey now, You can't respond to your question - wacka, wacka"
    end
  end

end
