json.id @question.id
json.slug @question.slug
json.title @question.title
json.description @question.description
json.description_html @question.description_html
json.is_owner @question.owner?(current_user)
json.score @question.score
json.views @question.views_count
json.answers_count @question.answers_count
json.created_at time_ago_in_words(@question.created_at)
json.tags @question.tags

json.user do
  json.extract! @question.asker, :id, :username, :slug
  json.image_url @question.asker.image_url(:thumb)
end

json.answers do
  json.array!(@question.answers) do |answer|
    json.partial! 'api/v1/answers/answer', answer: answer
  end
end

json.comments do
  json.array!(@question.comments) do |comment|
    json.partial! 'api/v1/comments/comment', comment: comment
  end
end

