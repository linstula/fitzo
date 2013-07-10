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
        [
          ["133 Endicott Street",     "Boston",         "MA", "02113"], 
          ["8 S Market St",           "Boston",         "MA", "02109"],
          ["90 Canal St",             "Boston",         "MA", "02114"], 
          ["1 Washington Mall",       "Boston",         "MA", "02203"],
          ["145 Hanover Street",      "Boston",         "MA", "02108"], 
          ["143 Hampshire Street",    "Cambridge",      "MA", "02139"],
          ["46 Cross St",             "Boston",         "MA", "02113"], 
          ["225 Franklin Street",     "Boston",         "MA", "02110"],
          ["4 Avery Street",          "Boston",         "MA", "02111"], 
          ["9 Newbury Street",        "Boston",         "MA", "02116"], 
          ["364 Boylston Street",     "Boston",         "MA", "02116"], 
          ["36 Newbury Street",       "Boston",         "MA", "02116"], 
          ["173 Marlborough St",      "Chelsea",        "MA", "02150"], 
          ["561 Boylston Street",     "Boston",         "MA", "02116"], 
          ["249 Newbury Street",      "Boston",         "MA", "02116"], 
          ["540 Tremont Street",      "Boston",         "MA", "02116"], 
          ["323 Dorchester Avenue",   "Boston",         "MA", "02127"], 
          ["131 West 8th Street",     "Boston",         "MA", "02127"], 
          ["301 3rd Street",          "Cambridge",      "MA", "02142"], 
          ["22 Lincoln Street",       "Boston",         "MA", "02111"], 
          ["154 Magazine St #21",     "Cambridge",      "MA", "02139"], 
          ["7 Temple Street",         "Boston",         "MA", "02114"], 
          ["1379 Beacon Street",      "Brookline",      "MA", "02446"], 
          ["920 Commonwealth Avenue", "Boston",         "MA", "02215"], 
          ["183 Green Street",        "Cambridge",      "MA", "02139"]
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

