# visits
# table schema:
# id                 integer    not null, primary key
# shortened_url_id   integer    not null
# user_id            integer    not null

class Visit < ApplicationRecord
  validates :visitor, :shortened_url, presence: true

  belongs_to(
    :visitor,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  # Short hand syntax. Because Primary key, foreign key and class name follow convention, Rails can guess their values.
  belongs_to :shortened_url

  def self.record_visit!(user, shortened_url)
    Visit.create!(user_id: user.id, shortened_url_id: shortened_url.id)
  end
end
