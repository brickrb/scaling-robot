class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Assocations
    has_many :packages, through: :ownerships
    has_many :ownerships

  # Validations
    validates :username, presence: true
    validates :username, uniqueness: true

  # Caching
    if Rails.env.production?
      after_create :purge_all
      after_save :purge
      after_destroy :purge, :purge_all
    end
end
