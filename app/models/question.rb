class Question < ApplicationRecord
    has_many :quotations, dependent: :destroy
    has_many :supports, dependent: :destroy
end
