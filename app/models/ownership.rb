class Ownership < ActiveRecord::Base
  # Assocations
    belongs_to :package
    belongs_to :user
end
