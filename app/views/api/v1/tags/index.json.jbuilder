json.page_number params[:page]
json.total_pages @tags.total_pages

json.models do
  json.array! @tags do |tag|
    json.merge! tag.attributes
  end
end
