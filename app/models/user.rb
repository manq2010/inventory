class User < ApplicationRecord
  has_many :sales, foreign_key: 'user_id', dependent: :destroy
  has_many :orders, foreign_key: 'user_id', dependent: :destroy

  # validates :username, presence: true, uniqueness: { message: 'Must be unique' },
  #  length: { in: 3..250, message: 'Must be a string of at least 3 characters' }
  # validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP, uniqueness: { message: 'Must be unique' }
  # validates :name, :role, presence: true
  # validates :password, presence: true, length: { minimum: 6 }, confirmation: true
  # validates :password_confirmation, presence: true
  validates :name, presence: true, uniqueness: { message: 'Must be unique' },
                   length: { in: 3..250, message: 'Must be a string of at least 3 characters' }
end
