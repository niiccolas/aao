# users
# table schema:

# id        :integer    not null, primarykey
# email     :string     not null, unique

class User < ApplicationRecord
  # Add uniqueness and presence validations. Without these, people might go about creating user accounts without emails. We cannot tolerate such misbehavior.
  validates :email, presence: true, uniqueness: true

  has_many :submitted_urls,
    class_name: 'ShortenedUrl',
    primary_key: :id,
    foreign_key: :submitter_id
end
