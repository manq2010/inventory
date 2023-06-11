class Customer < ApplicationRecord
    extend FriendlyId
    has_many :orders
end
