
      it "can see specialties on the trainer's profile" do
        visit trainer_profile_path(profile)

        expect(page).to have_content(specialty.title)
        expect(page).to have_content(specialty_2.title)
      end
