# Evenbrite
bundle install
rails db:create
rails db:migration
rails db:seed
---
rails console > créer un nouvel utilisateur ex: user = User.create(email:"mail@yopmail.com", description:"description", first_name:"prenom", last_name:"nomZ")
Rend toi sur : http://www.yopmail.com (mail@yopmail.com)
Toujours dans la console > attendance = Attendance.create(stripe_customer_id:47, event_id:1, user_id:3)
------
