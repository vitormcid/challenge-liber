class Report
    require 'date'
    def self.location_cost
        Location.sum(:value)
    end

    def self.people_in_delay
        Location.where("return_date > end_date").
                 map{|l| ["#{l.person.name} #{l.person.last_name}", seconds_to_units(l.end_date - l.return_date)]}
    end

    def self.can_rent_trucks
        people_names = []
        Person.all.each do |person|
            next unless person.birth_date.present?          
            if (person.birth_date + 40.years < Date.current) &&
               person.drivers_license.validiy < Date.current
                    people_names << "#{person.name} #{person.last_name}" 
            end         
        end 
        people_names
    end

    def self.people_with_active_locations
        Location.where("withdrawal_date is not ? and return_date is ?",nil,nil).
               map{|l| "#{l.person.name} #{l.person.last_name}"}    
    end

    def self.can_make_large_locations
        Person.joins(:drivers_license).where("validiy > ?", Date.current).
               map{|p| "#{p.name} #{p.last_name}" if p.reliable_customer}.compact         
    end 

    def self.cars_banned_on_wednesdays
        Automobile.all.map{|a| "#{a.license_plate}" if a.license_plate_termination == "4"}.compact
    end 

    def self.price_motorcycle_3_days
        Automobile.where(kind: "motorcycle").first.daily_cost * 3    
    end

    def self.location_cost_per_person
        people_locations_value = Person.all.map{|p| [name: "#{p.name} #{p.last_name}", value: p.locations.sum(:value)]}     
        people_locations_value.sort_by{|e| -e.first[:value]}.map{|p| p.first[:name]}    
    end

    def self.people_1_month_to_expire_license
        DriversLicense.where("validiy < ? and validiy > ?", Date.current + 1.month, Date.current).
                       map{|d| "#{d.person.name} #{d.person.last_name}"} 
    end    

    
    # helper methods -------------------------------------------------------------------    

    def self.seconds_to_units(seconds)
        '%d dias, %d horas, %d minutos' %
        # the .reverse lets us put the larger units first for readability
        [24,60,60].reverse.inject([seconds]) {|result, unitsize|
            result[0,0] = result.shift.divmod(unitsize)
            result
        }
    end



end
