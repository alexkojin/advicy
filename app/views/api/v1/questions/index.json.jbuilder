json.current_page @questions.current_page
json.total_items @questions.total_count
json.per_page    @questions.limit_value

json.items do
  json.array!(@questions) do |question|
    json.partial! 'api/v1/questions/question', question: question
  end
end
