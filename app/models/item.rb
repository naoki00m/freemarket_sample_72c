class Item < ApplicationRecord
  validates :name, :detail, :price, :state, :condition, :shipping_cost, :shipping_date, :shipping_method, presence: true
  validates :name, length: { maximum: 40 }
  validates :detail, length: { maximum: 1000 }
  validates :price, numericality: { greater_than_or_equal_to: 300 }
  validates :price, numericality: { less_than_or_equal_to: 9999999 }
  validates :state, numericality: { greater_than_or_equal_to: 0 }
  validates :state, numericality: { less_than_or_equal_to: 3 }

  has_many :item_images
end