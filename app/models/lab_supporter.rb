class LabSupporter < ActiveRecord::Base
  belongs_to :user
  belongs_to :lab

  validates :lab, presence: true
  validates :user, presence: true
  validates :user, uniqueness: { scope: :lab, message: 'You can only support a lab once.' }
end
