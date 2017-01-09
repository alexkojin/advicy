module Api::V1
  class ImagesController < ApiController
    before_action :require_login

    def create
      uploader = ImageUploader.new
      uploader.store!(params[:file])
      # if @comment.save
      #   render :create
      # else
      #   render json: @comment.errors.full_messages, status: :unprocessable_entity
      # end

      render json: { url: uploader.url }
    end

  end
end
