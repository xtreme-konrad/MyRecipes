class Review < ActiveRecord::Base
  belongs_to :chef
  belongs_to :recipe
  
  validates_uniqueness_of :chef, scope: :recipe
  
  validates :content, presence: true, 
                      length: { minimum: 5, maximum: 500 }
  validates :rating,  presence: true,
                      :inclusion => {:in => [0,1,2,3,4,5]}
  validates :chef_id, presence: true
  validates :recipe_id, presence: true
  
  default_scope -> { order(created_at: :desc) }
end