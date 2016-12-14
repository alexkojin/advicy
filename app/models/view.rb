class View < ActiveRecord::Base
  belongs_to :user
  belongs_to :viewable, polymorphic: true

  after_create :increment_counter

  private
  def increment_counter
    self.viewable.increment!(:views_count)
  end
end

# == Schema Information
#
# Table name: views
#
#  id            :integer          not null, primary key
#  viewable_id   :integer          indexed => [viewable_type, ip], indexed => [viewable_type, user_id]
#  viewable_type :string           indexed => [viewable_id, ip], indexed => [viewable_id, user_id]
#  user_id       :integer          indexed => [viewable_id, viewable_type]
#  ip            :string           indexed => [viewable_id, viewable_type]
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
