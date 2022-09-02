class Role < ActiveRecord::Base
    has_many :auditions

    def actors
        self.auditions.map do |audition|
            audition.actor
        end
    end

    def locations
        # self.auditions.pluck |audition| is a quicker method
        self.auditions.map do |audition|
            audition.location
        end
    end

    def lead
        lead = self.auditions.find_by(hired: true)
        lead ? lead : "no actor has been hired for this role"
    end

    def understudy
        hires = self.auditions.where(hired: true)
        hires.count < 2 ? 'no actor has been hired for understudy for this role' : hires[1]
    end
end