# shortened_urls
# table schema:

# id           :integer     not null, primary key
# long_url     :string      not null
# short_url    :string      not null
# submitter_id :integer     not null
# created_at   :datetime    not null
# updated_at   :datetime    not null

class ShortenedUrl < ApplicationRecord
  validates :long_url, :short_url, :submitter, presence: true
  validates :short_url, uniqueness: true

  belongs_to :submitter,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :submitter_id

  def self.random_code
    loop do
      random_url = SecureRandom.urlsafe_base64(16)
      return random_url unless ShortenedUrl.exists?(short_url: random_url)
    end
  end

  def self.create_short_url(user, long_url)
    ShortenedUrl.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: ShortenedUrl.random_code
    )
  end
end
