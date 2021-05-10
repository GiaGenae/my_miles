class Run < ActiveRecord::Base
    belongs_to :user
    validates :date, presence: true
    validates :distance, presence: true
    validates :duration, presence: true

    def self.valid_params?(params)
        return !params[:date].empty? && !params[:distance].empty? && !params[:duration].empty?
    end
end
