class Salary < ApplicationRecord
  belongs_to :user
  has_one :tax
  
  validates :amount, presence: true
end
