json.name category.name
json.slug category.slug
if category.respond_to? :questions_count
  json.questions_count category.questions_count
end
