json.id question.id
json.slug question.slug
json.title question.title
json.score question.score
json.views question.views_count
json.answers_count question.answers_count
json.created_at time_ago_in_words(question.created_at)
json.tags question.tags

json.user do
  json.extract! question.asker, :id, :username, :image_url, :slug
end
