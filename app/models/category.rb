class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }, uniqueness: {scope: :user_id}
end
