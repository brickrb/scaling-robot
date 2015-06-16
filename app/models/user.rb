class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :packages, through: :ownerships
  has_many :ownerships

  validates :username, presence: true
  validates :username, uniqueness: true

  if Rails.env.production?
    after_create :purge_all
    after_save :purge
    after_destroy :purge, :purge_all
  end
end
