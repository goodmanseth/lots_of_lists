class Album < ApplicationRecord
    validates :title, :presence => true
    validates :artist, :presence => true
    validates :description, :presence => true
    
    has_many :reviews
end
