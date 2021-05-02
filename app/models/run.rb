class Run < ActiveRecord::Base
    belongs_to :user
    validates :date, presence: true
    validates :distance, presence: true
    validates :duration, presence: true
end
