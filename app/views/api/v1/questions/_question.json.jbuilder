json.id question.id
json.slug question.slug
json.title question.title
json.score question.score
json.views question.views_count
json.answers_count question.answers_count
json.created_at time_ago_in_words(question.created_at)
json.tags question.tags

json.category do
  json.name question.category.try(:name)
  json.slug question.category.try(:slug)
end

json.user do
  json.extract! question.asker, :id, :username, :image_url, :slug
end

# json.merge! question.attributes.except("category_id")
# json.category_slug question.category_slug
# json.score question.score
# json.asked_at time_ago_in_words(question.created_at)

# json.has_best question.answers.any? { |answer| answer.best }

# json.tag_list question.tags
# json.asker do
#   json.extract! User.find(question.asker_id), :id, :username, :image_url
# end

# if signed_in? && current_user.id == question.asker_id
#   json.owned do
#     json.extract! current_user, :id, :username
#   end
# end

# if @vote
#   json.vote do
#     json.merge! @vote.attributes
#   end
# end

# json.comments do
#   json.array!(question.comments) do |comment|
#     json.partial! 'api/comments/comment', comment: comment
#   end
# end

# json.answers do
#   json.array!(question.answers) do |answer|
#     json.partial! 'api/answers/answer', answer: answer
#     if signed_in?
#       vote = answer.votes.find_by(voter_id: current_user.id)
#       if vote
#         json.vote do
#           json.merge! vote.attributes
#         end
#       end
#     end

#     json.comments do
#       json.array!(answer.comments) do |comment|
#         json.partial! 'api/comments/comment', comment: comment
#       end
#     end
#   end
# end

# if question.category.present?
#   json.category do
#     json.partial! 'api/categories/category', category: question.category
#   end
# end
