class Project < ApplicationRecord
  validates :title, presence: true
  validates :status, presence: true
end
