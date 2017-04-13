class Review < ApplicationRecord
    validates :reviewer, :presence => true
    validates :body, :presence => true
    belongs_to :album
    belongs_to :user
end
