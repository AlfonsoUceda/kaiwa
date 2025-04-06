class Project < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :status, presence: true
end
