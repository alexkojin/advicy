json.id @question.id
json.slug @question.slug
json.title @question.title
json.description @question.description
json.tag_list @question.tags.map(&:name)
json.category_slug @question.category.try(:slug)

