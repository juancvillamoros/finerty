class User < ApplicationRecord
    has_one :salary
    has_many :taxes
    has_many :salary_histories
    
    validates :name, :email, presence: true
    validates :email, uniqueness: true
end
  
