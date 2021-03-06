class User < ActiveRecord::Base
    has_secure_password
    has_many :runs #, class_name: "Run", foreign_key: "user_id" 
    validates :username, uniqueness: true, length: {in: 5..10}
    validates :email, presence: true, uniqueness: true, format: {with: /\A(?<username>[^@\s]+)@((?<domain_name>[-a-z0-9]+)\.(?<domain>[a-z]{2,}))\z/i}
    validates :password, length: {in: 8..100}

    def slug
        self.username.downcase
    end
      
    def self.find_by_slug(slug)
        self.all.find {|object| object.username if object.slug == slug}
    end
end
