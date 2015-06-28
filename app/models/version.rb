class Version < ActiveRecord::Base
  # Assocations
    belongs_to :package
  
  # Validations
    validates :license, presence: true
    validates :number, presence: true
end
