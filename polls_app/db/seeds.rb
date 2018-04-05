# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all
david = User.create!(username: "David")
maja = User.create!(username: "Maja")
maurice = User.create!(username: "Maurice")

Poll.destroy_all
poll1 = Poll.create!(title: "Existentialism", author_id: maja.id)
poll2 = Poll.create!(title: "App Academy", author_id: david.id)
poll3 = Poll.create!(title: "App Academy",author_id: maurice.id)

Question.destroy_all
q1 = Question.create!(question: "What is the meaning of life?", poll_id: poll1.id)
q2 = Question.create!(question: "Why are we here?", poll_id: poll2.id)
q3 = Question.create!(question: "Why the hell am I a TA and not at Silicon Valley?", poll_id: poll3.id)


AnswerChoice.destroy_all
ac1 = AnswerChoice.create!(answer: "Happiness", question_id: q1.id)
ac2 = AnswerChoice.create!(answer: "Money", question_id: q1.id)
ac3 = AnswerChoice.create!(answer: "Surfing", question_id: q1.id)

Response.destroy_all
r2 = Response.create!(user_id: david.id, answer_id: ac1.id)
r3 = Response.create!(user_id: maurice.id, answer_id: ac2.id)
