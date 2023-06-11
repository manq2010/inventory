class User < ApplicationRecord
  extend FriendlyId
  validates :email, presence: true, 
  format: {with: URI::MailTo::EMAIL_REGEXP},
  length: {maximum: 105},
  uniqueness: { message: 'Must be unique', case_sensitive: false}
  validates :phone, presence: true, length: { in: 3..250, message: 'Must be a number of at least 3 digits' }
  validates :first_name, :last_name, presence: true,
  length: { in: 3..250, message: 'Must be a string of at least 3 characters' }
  # validates :password, presence: true, length: { minimum: 6 }, confirmation: true
  # validates :password_confirmation, presence: true
  # validates :username, presence: true, uniqueness: { message: 'Must be unique' },
  #  length: { in: 3..250, message: 'Must be a string of at least 3 characters' }
  
  # has_many :sales, foreign_key: 'user_id', dependent: :destroy, inverse_of: :user
  # has_many :orders, foreign_key: 'user_id', dependent: :destroy, inverse_of: :user

  has_many :sales, foreign_key: 'user_id', dependent: :destroy, inverse_of: :user
  has_many :orders, foreign_key: 'user_id', dependent: :destroy, inverse_of: :user

  # friendly_id :first_name, :use => :slugged

  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :first_name,
      [:first_name, :last_name],
      [:first_name, :last_name, :email]
    ]
  end

  def to_param
    slug
  end
end
