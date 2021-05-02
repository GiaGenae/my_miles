class User < ActiveRecord::Base
    has_secure_password
    has_many :runs
    validates :username, uniqueness: true, length: {in: 5..10}
    validates :email, presence: true, uniqueness: true, format: {with: /\A(?<username>[^@\s]+)@((?<domain_name>[-a-z0-9]+)\.(?<domain>[a-z]{2,}))\z/i}
    validates :password, length: {in: 8..100}
end
