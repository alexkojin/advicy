json.tag @tag
json.page_number params[:page]

json.questions do
  json.page_number params[:page]
  json.total_pages @questions.total_pages
  json.array! @questions do |question|
    json.partial! 'api/v1/questions/question', question: question
  end
end
