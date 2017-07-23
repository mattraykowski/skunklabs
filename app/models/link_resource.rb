class LinkResource < ActiveRecord::Base
  belongs_to :lab

  validates :lab, presence: true
  validates :name, presence: true
  validates :url, presence: true
end
