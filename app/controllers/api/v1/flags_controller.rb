module Api::V1
  class FlagsController < ApiController
    before_action :require_login

    def create
      flag = current_user.flags.new(
               flaggable: flaggable,
               flag_type: params[:flag_type],
               reason: params[:reason])

      if flag.save
        render json: {}
      else
        render json: flag.errors.full_messages, status: :unprocessable_entity
      end
    end

    private

    def flaggable
      @flaggable ||=
        case params['flaggable_type']
        when 'question'
          Question.find(params['flaggable_id'])
        when 'answer'
          Answer.find(params['flaggable_id'])
        when 'comment'
          Comment.find(params['flaggable_id'])
        else
          raise ActiveRecord::RecordNotFound
        end
    end
  end
end
