class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :lab

  validates :user, presence: true
  validates :lab, presence: true
  validates :comment, presence: true
  validates :subject, presence: true
end
