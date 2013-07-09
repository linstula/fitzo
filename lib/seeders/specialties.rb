module Seeders
  module Specialties
    class << self
      def seed
        Specialty.destroy_all

        specialties.each do |title|
          specialty = Specialty.new
          specialty.title = title
          
          specialty.save
        end
      end

      def specialties
      	["Weight Loss", "Aerobic", "Yoga", "Pilates", "Tai Chi", "Nutrition",
      	 "Group Training", "Core", "Functional", "Rehabilitation", "CrossFit",
      	 "Plyometrics", "Flexibility", "Strength", "Conditioning"].sort
      end
    end
  end
end
