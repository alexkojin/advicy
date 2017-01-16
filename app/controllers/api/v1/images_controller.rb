module Api::V1
  class ImagesController < ApiController
    before_action :require_login

    def create
      @image = Image.new(file: params[:file])
      if @image.save
        render json: { url: @image.file.url }
      else
        render json: @image.errors.full_messages, status: :unprocessable_entity
      end
    end

  end
end
