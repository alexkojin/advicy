json.merge! answer.attributes
json.question_slug answer.question.slug
json.created_at time_ago_in_words(answer.created_at)
json.is_owner answer.owner?(current_user)

json.user do
  json.extract! answer.answerer, :id, :username, :slug
  json.image_url answer.answerer.image_url(:thumb)
end

json.comments do
  json.array!(answer.comments) do |comment|
    json.partial! 'api/v1/comments/comment', comment: comment
  end
end





