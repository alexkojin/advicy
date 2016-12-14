module Api::V1
  class ViewsController < ApiController
    def create
      viewable = find_viewable

      if current_user
        unless viewable.views.exists?(user_id: current_user.id)
          viewable.views.create(user_id: current_user.id)
        end
      elsif !viewable.views.exists?(ip: get_ip)
        viewable.views.create(ip: get_ip)
      end

      render json: { score: find_viewable.views_count }
    end

    private

    def find_viewable
      case params['viewable_type']
      when 'question'
        Question.find(params['viewable_id'])
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def get_ip
      if env['HTTP_X_FORWARDED_FOR']
        env['HTTP_X_FORWARDED_FOR'].strip.split(/[,\s]+/)[0]
      else
        env['HTTP_X_REAL_IP'] || env['REMOTE_ADDR']
      end
    end
  end
end
