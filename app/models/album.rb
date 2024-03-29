class Album < ApplicationRecord
    validates :title, :presence => true
    validates :artist, :presence => true
    validates :description, :presence => true
    
    has_many :reviews
    belongs_to :user
    
    def self.search(search)
        where("title ILIKE ? OR artist ILIKE ?", "%#{search}%", "%#{search}%") 
    end
end

