class Task < ApplicationRecord
  belongs_to :category
  before_validation :set_default_due_date
  validates :description, presence: true, length: {minimum: 5}
  def set_default_due_date
    self.due_date ||= Date.today
  end
end
