json.id   comment.id
json.body comment.body
json.is_owner comment.owner?(current_user)
json.created_at time_ago_in_words(comment.created_at)

json.user do
  json.extract! comment.commenter, :id, :slug, :username
end
