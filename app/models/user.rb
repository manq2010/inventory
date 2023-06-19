class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,
         :registerable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  validates :first_name, :last_name, :username, :email, presence: true
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 50 }

  def slug_candidates
    [
      :first_name,
      %i[first_name last_name],
      %i[first_name last_name email]
    ]
  end

  def to_param
    slug
  end

  mount_uploader :avatar, ImageUploader

  scope :search, lambda { |query|
                   query.present? ? where('username ILIKE ? OR first_name ILIKE ? OR last_name ILIKE ?', "%#{query}%", "%#{query}%", "%#{query}%") : none
                 }
end
