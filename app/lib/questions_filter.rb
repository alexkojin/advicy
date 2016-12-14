class QuestionsFilter

  attr_accessor :params

  def initialize(params)
    self.params = params
  end

  def call
    scope = Question.includes(:votes, :asker, :tags, :category)
    scope = if params[:tag]
      scope.tagged_with(params[:tag])
    elsif params[:owner]
      scope.where('asker_id = ?', params[:owner])
    elsif params[:category]
      scope.where(categories: { slug: params[:category] })
    elsif params[:query]
      scope.where('LOWER(title) LIKE (?)', "%#{params[:query].downcase}%")
    else
      scope
    end

    apply_second_filter(scope)
  end

  private

    def apply_second_filter(scope)
      case params[:filter]
      when 'unanswered'
        scope.unanswered.order('questions.created_at desc')
      when 'hot'
        scope.popular
      when 'week'
        scope.popular.last_week
      when 'month'
        scope.popular.last_month
      else
        scope.order('questions.created_at desc')
      end
    end
end
