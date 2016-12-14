json.array!(@questions) do |question|
  json.id question.id
  json.slug question.slug
  json.title question.title
  json.score question.score
end
