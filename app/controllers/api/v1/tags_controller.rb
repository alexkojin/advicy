module Api::V1
  class TagsController < ApiController
    def index
      @tags = ActsAsTaggableOn::Tag.most_used.page(params[:page]).per(50)
    end
  end
end
