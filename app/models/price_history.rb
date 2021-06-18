class PriceHistory < ApplicationRecord
  belongs_to :client_product

  validates :price, presence: true
end
