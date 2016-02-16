class Recipe < ActiveRecord::Base
  belongs_to :chef
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :recipe_styles, dependent: :destroy
  has_many :styles, through: :recipe_styles
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  
  validates :name, presence: true, 
                   length: { minimum: 5, maximum: 100 }
  validates :summary, presence: true, 
                      length: { minimum: 10, maximum: 150 }
  validates :description, presence: true, 
                          length: { minimum: 20, maximum: 500 }
  validates :chef_id, presence: true
  
  mount_uploader :picture, PictureUploader
  validate :picture_size
  
  default_scope -> { order(updated_at: :desc) }
  
  def thumbs_up_total
    self.likes.where(like: true).size
  end
  
  def user_liked(current_user)
    self.likes.where(chef: current_user, like: true).any?
  end
  
  def thumbs_down_total
    self.likes.where(like: false).size
  end
  
  def user_disliked(current_user)
    self.likes.where(chef: current_user, like: false).any?
  end
  
  def user_reviewed(current_user)
    self.reviews.where(chef: current_user).any?
  end
  
  private
  
    def picture_size
      if (picture.size > 5.megabytes)
        errors.add(:picture, "should be less than 5MB")
      end
    end
    
end