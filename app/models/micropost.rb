class Micropost < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :users ,through: :favorites,source: :user
  has_many :favorites
  has_many :favorings ,through: :favorites,source: :micropost
  has_many :reverses_of_favorite ,class_name: 'Favorite',foreign_key: 'micropost_id'
  has_many :favorited_users, through: :reverses_of_favorite,source: :user
  
  validates :content, presence: true, length: { maximum: 255 }

  def favorites?(micropost)
    self.favorings.include?(micropost)
  end
end
