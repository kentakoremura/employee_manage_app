class Store < ApplicationRecord
  validates :name, {presence: true, length: { maximum: 30 }}
  has_many :responsibles
  has_many :employees, through: :responsibles
end
