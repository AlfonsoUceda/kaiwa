class Comment < ApplicationRecord
  belongs_to :project

  validates :body, presence: true

  def project_status_change?
    comment_type == "status_changed"
  end
end
