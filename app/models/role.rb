class Role < ApplicationRecord
  has_many :user, dependent: :restrict_with_error
end
