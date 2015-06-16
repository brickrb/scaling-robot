class Package < ActiveRecord::Base
  has_many :users, through: :ownerships
  has_many :ownerships
  has_many :versions

  validates :name, presence: true
  validates :name, uniqueness: true

  def description
    if self.versions.any?
      self.versions.last.description
    else
      "null"
    end
  end

  def latest_version
    if self.versions.any?
      self.versions.last
    end
  end

  def latest_version_number
    if self.versions.any?
      self.versions.last.number
    else
      "null"
    end
  end
end
