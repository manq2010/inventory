class Item < ApplicationRecord
  extend FriendlyId
  has_many :images, dependent: :destroy
  has_and_belongs_to_many :sales, through: :items_sales

  validates :title, presence: true, 
  length: { minimum: 3, message: 'Name must have 3 or more characters' }
  validates :price, presence: true, 
  numericality: { greater_than: 0, message: 'Price must be greater than 0' }
  validates :quantity, :category, :sku, :tag, :weight, :size, :color,
  presence: true

  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :title,
      [:title, :tag],
      [:title, :tag, :sku]
    ]
  end

  def to_param
    slug
  end
end
