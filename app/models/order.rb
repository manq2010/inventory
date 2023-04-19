class Order < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :items

  validates :pic, :total_price, :status, :user_id, presence: true

  validates :status, length: { minimum: 3, maximum: 70 }
  validates :pic, length: { minimum: 3, maximum: 5_000 }
  validates :pic, format: { with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https data])}\z/,
                            message: 'must be a valid URL' }
end
