class Attachment < ApplicationRecord
  belongs_to :question, optional: true
end
