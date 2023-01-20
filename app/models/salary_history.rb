class SalaryHistory < ApplicationRecord
  belongs_to :user
  belongs_to :salary
  validates :start_date, :end_date, :amount, presence: true
  
  def duration
    (end_date - start_date).to_i
  end
end
