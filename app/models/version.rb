class Version < ActiveRecord::Base
  belongs_to :package

  validates :license, presence: true
  validates :number, presence: true
end
