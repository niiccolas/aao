class User < ApplicationRecord
  # Add uniqueness and presence validations. Without these, people might go about creating user accounts without emails. We cannot tolerate such misbehavior.

  validates :email, presence: true, uniqueness: true
end
