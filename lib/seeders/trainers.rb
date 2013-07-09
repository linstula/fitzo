module Seeders
  module Trainers
    class << self
      def seed
        # User.find_all_by_role("trainer").each { |trainer| trainer.destroy }
        User.destroy_all
        members = []

        (1..6).each do |n|
          member = User.create(
            email: "member#{n}@example.com",
            password: "12345678",
            username: "Fitzo Member#{n}",
            first_name: "Fitzo",
            last_name: "Member#{n}",
            role: "member"
            )
          members << member
        end

        (1..25).each do |n|
          u_name = names[(rand(names.length))]

          trainer = {
            email: "trainer#{n}@example.com",
            password: "12345678",
            username: "#{u_name.join("")}#{n}",
            first_name: "#{u_name[0]}",
            last_name: "#{u_name[1]}",
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
          loc = u.trainer_profile.locations.build(street_address: locs[n][0], city: locs[n][1], state: locs[n][2], zip_code: locs[n][3])
          loc.definitive_result?
          loc.save
          
          # add profile info
          u.trainer_profile.phone_number = prof_info[0]
          u.trainer_profile.website = prof_info[1]
          u.trainer_profile.about = prof_info[2]
          u.trainer_profile.save!

          # add services
          u.trainer_profile.services.create(
            title: services[0][0],
            description: services[0][1],
            price: services[0][2],
            duration: services[0][3]
          )
          u.trainer_profile.services.create(
            title: services[1][0],
            description: services[1][1],
            price: services[1][2],
            duration: services[1][3]
          )
          u.trainer_profile.services.create(
            title: services[2][0],
            description: services[2][1],
            price: services[2][2],
            duration: services[2][3]
          )

          # add recommendations
          recs = (rand(6) + 1)
          recs.times do |i|
            u.trainer_profile.recommendations.create(
              title: "This trainer is seriously awesome!",
              content: "Pork belly flank pastrami, salami shoulder capicola turducken strip steak ham t-bone boudin. Shankle brisket jerky pork loin.",
              user_id: members[i - 1].id
              )
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
          ["133 Endicott Street", "Boston", "MA", "02113"], ["8 S Market St", "Boston", "MA", "02109"],
          ["90 Canal Street", "Boston", "MA", "02114"], ["1 Washington Mall", "Boston", "MA", "02108"],
          ["145 Hanover Street", "Boston", "MA", "02108"], ["276 Washington Street", "Boston", "MA", "02108"],
          ["1 Beacon Street", "Boston", "MA", "02108"], ["225 Franklin Street", "Boston", "MA", "02110"],
          ["4 Avery Street", "Boston", "MA", "02111"], ["48 Boylston Street", "Boston", "MA", "02116"], 
          ["9 Newbury Street", "Boston", "MA", "02116"], ["364 Boylston Street", "Boston", "MA", "02116"], 
          ["36 Newbury Street", "Boston", "MA", "02116"], ["173 Marlborough St","Boston"," MA","02116"], 
          ["561 Boylston Street", "Boston", "MA", "02116"], ["249 Newbury Street", "Boston", "MA", "02116"], 
          ["540 Tremont Street", "Boston", "MA", "02116"], ["653 Summer St", "Boston", "MA", "02210"], 
          ["323 Dorchester Avenue", "South Boston", "MA", "02127"], ["131 West 8th Street", "Boston", "MA", "02127"], 
          ["301 3rd Street", "Cambridge", "MA", "02142"], ["Bunker Hill Street", "Charlestown", "MA", "02129"], 
          ["22 Lincoln Street", "Somervle", "MA", "02145"], ["154 Magazine St #21", "Cambridge", "MA", "02139"], 
          ["7 Temple Street", "Cambridge", "MA", "02139"], ["114 Western Avenue", "Boston", "MA", "02134"], 
          ["920 Commonwealth Avenue", "Brookline", "MA", "02215"], ["183 Green Street", "Jamaica Plain", "MA", "02130"], 
          ["35 White Street", "Cambridge", "MA", "02138"], ["656 Washington Street", "Brighton", "MA", "02135"] 
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

