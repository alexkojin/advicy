module Api::V1
  class TagsController < ApiController
    def index
      @tags = ActsAsTaggableOn::Tag.page(params[:page])
    end
  end
end
