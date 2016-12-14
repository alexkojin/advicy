module Api::V1
  class VotesController < ApiController
    before_action :require_login

    def create
      votable = find_votable

      # owner can't vote for own votable
      unless votable.owner?(current_user)
        vote = votable.votes.find_by(voter_id: current_user.id)
        if vote
          if vote.value == params[:value]
            # cancel voice
            vote.destroy
          else
            # change meaning from negative to positive as ex.
            vote.update_attribute(:value, params[:value])
          end
        else
          votable.votes.create!(voter_id: current_user.id, value: params[:value])
        end

        votable.reload
      end

      render json: { score: votable.score }
    end

    private

    def find_votable
      case params['votable_type']
      when 'question'
        Question.find(params['votable_id'])
      when 'answer'
        Answer.find(params['votable_id'])
      else
        raise ActiveRecord::RecordNotFound
      end
    end
  end
end
