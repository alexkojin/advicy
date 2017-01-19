class QuestionsFilter

  attr_accessor :params

  def initialize(params)
    self.params = params
  end

  def call
    scope = Question.includes(:votes, :asker, :tags)
    scope = if params[:tag]
      scope.tagged_with(params[:tag])
    elsif params[:owner]
      scope.where('asker_id = ?', params[:owner])
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
        scope.unanswered.newest
      when 'week'
        scope.popular.last_week
      when 'month'
        scope.popular.last_month
      when 'all'
        scope.popular
      else
        scope.newest
      end
    end
end
