class Package < ActiveRecord::Base
  has_many :users, through: :ownerships
  has_many :ownerships
  has_many :versions

  validates :name, presence: true
  validates :name, uniqueness: true
end
