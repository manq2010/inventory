class Image < ApplicationRecord
  belongs_to :items

  validates :url, presence: true, allow_blank: false
end
