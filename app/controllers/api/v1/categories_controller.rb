module Api::V1
  class CategoriesController < ApiController
    def index
      @categories = Category.with_counts
      @categories = @categories.limit(params[:limit]) if params[:limit].present?
    end
  end
end
