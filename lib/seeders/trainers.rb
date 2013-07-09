module Seeders
  module Trainers
    class << self
      def seed
        User.find_all_by_role("trainer").each { |trainer| trainer.destroy }
        
        names = [["Richard", "Simmons"], ["Tony", "Little"], ["Jake", "Steinfeld"], 
          ["Billy", "Blanks"],["Arnold", "Schwarzenegger"], ["Jeanette", "Jenkins"],
          ["Tracy", "Anderson"]]

        (1..10).each do |n|
          u_name = names[(rand(names.length))]

          trainer = {
            email: "trainer#{n}@example.com",
            password: "12345678",
            username: "#{u_name.join("")}#{n}",
            first_name: "#{u_name[0]}",
            last_name: "#{u_name[1]}",
            role: "trainer"
          }

          u = User.new(trainer)
          u.save!
          u.avatar.store!(File.open(File.join(Rails.root, "/public/images/celebrities/#{u_name.join("_").downcase}.jpeg")))
          u.save!
          u.create_profile_for_trainer
        end
      end

      def trainers
        
      end

      def names
        
      end
    end
  end
end



# create_table "users", :force => true do |t|
#     t.string   "email",                  :default => "",       :null => false
#     t.string   "encrypted_password",     :default => "",       :null => false
#     t.string   "reset_password_token"
#     t.datetime "reset_password_sent_at"
#     t.datetime "remember_created_at"
#     t.integer  "sign_in_count",          :default => 0
#     t.datetime "current_sign_in_at"
#     t.datetime "last_sign_in_at"
#     t.string   "current_sign_in_ip"
#     t.string   "last_sign_in_ip"
#     t.datetime "created_at",                                   :null => false
#     t.datetime "updated_at",                                   :null => false
#     t.string   "username",               :default => "",       :null => false
#     t.string   "first_name",             :default => "",       :null => false
#     t.string   "last_name",              :default => "",       :null => false
#     t.string   "role",                   :default => "member", :null => false
#     t.string   "avatar"
#   end
