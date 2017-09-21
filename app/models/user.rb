class User < ActiveRecord::Base

  has_many :tweets

  def slug
    self.username.downcase.gsub(/\s+/, "-")
  end

  def self.find_by_slug(slug)
    unslug_name = slug.gsub("-", " ")
    self.find_by(username: unslug_name)
  end

  def authenticate(word)
    (self.password == word) ? self : false
  end
end
