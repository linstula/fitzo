#Description

Fitzo is an app that helps connect personal trainers and people
looking to find a personal trainer.

You can see a live version at: https://fitzo.herokuapp.com

Trainers can create a professional looking web presence and position 
themselves to be found by creating a profile on Fitzo. Trainers can 
add locations, services and specialties to their profile. 

Non-trainer members of Fitzo can search for trainers based on location,
specialties or the name of the trainer. Members can also share their
experiences by recommending a trainer.


#Cloning Fitzo

$ git clone https://github.com/linstula/fitzo.git

Create a new config/database.yml file for the app. An example can
be found in config/database.example.yml

Create a .env file in the root of the app. You will need to generate
a new secret token. This can be done via:

$ rake secret

In the .env file, assign FITZO_SECRET_TOKEN=your_new_secret_token

Run:
$ rake db:create
$ rake db:migrate

Run:
$ bundle

Seed the database with some sample trainers by running:
$ rake db:seed

Check it out!
$ rails s


## A note on storing images:

Currently, while in production mode, Fitzo is set to store uploaded
images (user avatars) on S3. If run in production mode, you will need to 
create a new S3 account. The S3_BUCKET, SECRET_KEY, and S3_ACCESS_KEY_ID
can be set in the .env file. If you're only running in development mode
Fitzo stores the uploaded images in the public/images directory.

