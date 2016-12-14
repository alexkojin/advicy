require 'active_support/concern'

module Activities
  extend ActiveSupport::Concern

  included do
    has_many :activities, as: :trackable, dependent: :delete_all
  end

  def create_activity(key:, actor:, recipient:, parameters: nil)
    Activity.create(trackable: self, actor: actor, recipient: recipient,
      key: "#{self.class.name.underscore}.#{key}", parameters: parameters)
  end
end
