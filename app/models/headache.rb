class Headache < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(headache_date: :desc, created_at: :desc) }
  validates :user_id, presence: true
  validates :headache_date, presence: true
end
