class Want < ApplicationRecord
  # model association
  has_many :type, dependent: :destroy

  # validations
  validates_presence_of :email
end
