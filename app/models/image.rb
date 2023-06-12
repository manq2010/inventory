class Image < ApplicationRecord
  belongs_to :item

  validates :url, presence: true, allow_blank: false
end
