class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,
         :registerable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

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
end
