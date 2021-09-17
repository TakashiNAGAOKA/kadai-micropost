class Micropost < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :users ,through: :favorites,source: :user
  has_many :favorites
  has_many :favorings ,through: :favorites,source: :micropost

  validates :content, presence: true, length: { maximum: 255 }

  def favorites?(micropost)
    self.favorings.include?(micropost)
  end
end
