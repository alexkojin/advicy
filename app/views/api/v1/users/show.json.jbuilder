json.extract! @user, :id, :username
json.slug @user.slug

json.image_url @user.image_url
if signed_in? && @user.id == current_user.id
  json.owned true
else
  json.owned false
end

json.points @user.points
json.question_points @user.question_points_total
json.answer_points @user.answer_points_total
