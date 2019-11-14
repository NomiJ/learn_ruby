class Task < ApplicationRecord
  validates :content, presence: true, length: { minimum: 3}

  belongs_to :project

  def completed?
    !completed_at.blank?
  end
  
end
