class Image < ApplicationRecord
  extend FriendlyId
  belongs_to :item

  validates :url, presence: true, allow_blank: false
end
