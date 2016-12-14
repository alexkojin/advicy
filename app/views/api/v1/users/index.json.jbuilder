json.current_page @users.current_page
json.total_items  @users.total_count
json.per_page     @users.limit_value

json.items do
  json.array!(@users) do |user|
    json.partial! 'api/v1/users/user', user: user
  end
end
