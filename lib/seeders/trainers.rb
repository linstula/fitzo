module Seeders
  module Trainers
    class << self
      def seed
        User.find_all_by_username("SeededTrainer").each { |trainer| trainer.destroy }
        User.find_all_by_username("FitzoMember").each { |trainer| trainer.destroy }
        members = []

        (1..6).each do |n|
          member = User.create(
            email: "member#{n}@example.com",
            password: "12345678",
            username: "FitzoMember",
            first_name: "Fitzo",
            last_name: "Member#{n}",
            role: "member"
            )
          members << member
        end

        (1..24).each do |n|
          u_name = names[(rand(names.length))]

          trainer = {
            email: "trainer#{n}@example.com",
            password: "12345678",
            username: "SeededTrainer",
            first_name: "#{u_name[0]}",
            last_name: "#{u_name[1]} #{n}",
            role: "trainer"
          }

          # create trainer
          u = User.new(trainer)
          u.save!

          # add trainer avatar
          u.avatar.store!(File.open(File.join(Rails.root, "/public/images/celebrities/#{u_name.join("_").downcase}.jpeg")))
          u.save!
          u.create_profile_for_trainer
          
          # add a location
          loc = u.trainer_profile.locations.build(street_address: locs[n-1][0], city: locs[n-1][1], state: locs[n-1][2], zip_code: locs[n-1][3])
          loc.definitive_result?
          loc.save
          
          # add profile info
          u.trainer_profile.phone_number = prof_info[0]
          u.trainer_profile.website = prof_info[1]
          u.trainer_profile.about = prof_info[2]
          u.trainer_profile.save!

          # add services
          (1..3).each do |i|
            u.trainer_profile.services.create(
              title: services[i-1][0],
              description: services[i-1][1],
              price: services[i-1][2],
              duration: services[i-1][3]
            )
          end

          # add recommendations
          recs = (rand(6) + 1)
          recs.times do |i|
            u.trainer_profile.recommendations.create(
              title: "This trainer is seriously awesome!",
              content: "Pork belly flank pastrami, salami shoulder capicola turducken strip steak ham t-bone boudin. Shankle brisket jerky pork loin.",
              user_id: members[i - 1].id
              )
          end

          # add specialties
          specs = Specialty.all.shuffle
          spec_count = (rand(specs.count/2) + 1)
          spec_count.times do |i|
            u.trainer_profile.trainer_specialties.create(specialty_id: specs[i].id)
          end
        end
      end

      def names
        [ 
          ["Richard", "Simmons"], ["Tony", "Little"], ["Jake", "Steinfeld"], 
          ["Billy", "Blanks"], ["Arnold", "Schwarzenegger"],["Jeanette", "Jenkins"],
          ["Tracy", "Anderson"]
        ]
      end

      def locs
        @locs ||= [
          ["1 Kendall Square",        "Cambridge",      "MA", "02139"],
          ["17 Station St",           "Brookline",      "MA", "02445"],
          ["10 Presidential Way",     "Woburn",         "MA", "01801"], 
          ["486 Green St",            "Cambridge",      "MA", "02139"],
          ["100 CambridgePark Drive", "Cambridge",      "MA", "02140"], 
          ["175 Crossing Boulevard",  "Framingham",     "MA", "01701"],
          ["81 Wareham St",           "Boston",         "MA", "02118"], 
          ["1 Kendall Sq",            "Cambridge",      "MA", "02139"],
          ["1601 Trapelo Rd",         "Waltham",        "MA", "02451"], 
          ["290 Congress Street",     "Boston",         "MA", "02210"], 
          ["31 St. James Ave",        "Boston",         "MA", "02116"], 
          ["25 First Street",         "Cambridge",      "MA", "02141"], 
          ["10 Presidential Way",     "Woburn",         "MA", "01801"], 
          ["86 Shrewsbury Street",    "Worcester",      "MA", "01604"], 
          ["1 Appleton Street",       "Boston",         "MA", "02116"], 
          ["4 South Market Place",    "Boston",         "MA", "02109"], 
          ["50S Peen St",             "Framingham",     "MA", "01701"], 
          ["896 Beacon St",           "Boston",         "MA", "02115"], 
          ["10 Milk St",              "Boston",         "MA", "02108"], 
          ["210 Broadway",            "Cambridge",      "MA", "02139"], 
          ["41 Winter Street",        "Boston",         "MA", "02108"], 
          ["36 Bromfield St",         "Boston",         "MA", "02108"], 
          ["500 Boylston Street",     "Boston",         "MA", "02116"], 
          ["201 South Street",        "Boston",         "MA", "02110"]
        ].shuffle
      end

      def prof_info
        [
          "123-456-7890", "example.com", 
          %{
            Bacon ipsum dolor sit amet cow leberkas doner rump shoulder pancetta capicola. 
            Pork belly pork chop drumstick, frankfurter tail turkey brisket tri-tip pork loin pancetta shankle. 
            Pork belly flank pastrami, salami shoulder capicola turducken strip steak ham t-bone boudin. 
            Shankle brisket jerky pork loin. Tongue ground round salami pork andouille filet mignon. 
            Shank sirloin ball tip, boudin ham meatball pig beef ground round strip steak rump drumstick pork belly.
            }
        ]
      end

      def services
        [
          ["Ultimate fitness service",
          "Bacon ipsum dolor sit amet cow leberkas doner rump shoulder pancetta capicola. Pork belly pork chop drumstick, frankfurter tail turkey brisket tri-tip pork loin pancetta shankle.",
          "100",
          "2 hours"],
          ["Another ultra premium service",
          "Bacon ipsum dolor sit amet cow leberkas doner rump shoulder pancetta capicola. Pork belly pork chop drumstick, frankfurter tail turkey brisket tri-tip pork loin pancetta shankle.",
          "75",
          "1 hour"],
          ["The killer 2 minute service",
          "Bacon ipsum dolor sit amet cow leberkas doner rump shoulder pancetta capicola. Pork belly pork chop drumstick, frankfurter tail turkey brisket tri-tip pork loin pancetta shankle.",
          "40",
          "2 minutes"],
        ]
      end

    end
  end
end

