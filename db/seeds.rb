# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

puts "Cleaning databases..."

User.destroy_all
Category.destroy_all
Theme.destroy_all
Description.destroy_all
Discussion.destroy_all
Action.destroy_all
ActionParticipation.destroy_all
Conversation.destroy_all
Message.destroy_all

puts "Creating users..."

CSV.foreach('db/csvs/users.csv', { col_sep: ',', quote_char: '"', headers: :first_row }) do |row|
  user = User.new(first_name: row['first_name'], last_name: row['last_name'], email: row['email'], password: row['password'], location: row['location'], admin: row['admin'])
  # row['admin'] == 'TRUE' ? user.admin = true : user.admin = false
  user.remote_photo_url = row['photo']
  user.save!
end

# charles = User.new(email: "charles-breton@hotmail.fr", password: "charles", first_name: "Charles", last_name:"Breton", location: "Paris, France")
# # charles.remote_photo_url = "https://res.cloudinary.com/cbretn/image/upload/v1550217962/mnjhz9aerxvtgsr3c3tp.png"
# charles.save!

# lorenzo = User.new(email: "lorenzo@hotmail.fr", password: "lorenzo", first_name: "Lorenzo", last_name: "Xavier", location: "London, England")
# # lorenzo.remote_photo_url = "https://res.cloudinary.com/cbretn/image/upload/v1550220466/o5idwsp16eh3pqk8zpcm.jpg"
# lorenzo.save!

# george = User.new(email: "george.s.ballard@outlook.com", password: "george", first_name: "George", last_name: "Ballard", location: "Singapore")
# # george.remote_photo_url = "https://res.cloudinary.com/cbretn/image/upload/v1550218136/d82xmivgrtpqwj7k17a7.jpg"
# george.save!

puts "Creating categories..."

CSV.foreach('db/csvs/categories.csv', { col_sep: ',', quote_char: '"', headers: :first_row }) do |row|
  cat = Category.new(name: row['name'])
  cat.remote_photo_url = row['photo']
  cat.save!
end

# sante = Category.new(name: "Santé")
# sante.save!
# environnement = Category.new(name: "Environnement")
# environnement.save!
# cohesion = Category.new(name:"Cohésion Sociale")
# cohesion.save!
# epanouissement = Category.new(name:"Épanouissement Individuel")
# epanouissement.save!
# jes = Category.new(name:"Justice Économique & Sociale")
# jes.save!
# education = Category.new(name:"Éducation & Information")
# education.save!
# securite = Category.new(name:"Sécurité")
# securite.save!
# patrimoine = Category.new(name:"Patrimoine Culturel")
# patrimoine.save!
# systeme = Category.new(name:"Système National")
# systeme.save!

puts "Creating themes..."

CSV.foreach('db/csvs/themes.csv', { col_sep: ',', quote_char: '"', headers: :first_row }) do |row|
  theme = Theme.new(name: row['name'], content: row['content'])
  theme.category = Category.find_by(name: row['category'])
  theme.remote_photo_url = row['photo']
  theme.save!
end

# tabagisme = Theme.new(name: "Tabagisme", content: "content not yet created", category: sante)
# tabagisme.save!
# antisemitisme = Theme.new(name: "Antisémitisme", content: "content not yet created", category: cohesion)
# antisemitisme.save!
# violence = Theme.new(name: "Violence et Délinquance", content: "content not yet created", category: securite)
# violence.save!
# chomage = Theme.new(name: "Chômage", content: "content not yet created", category: jes)
# chomage.save!
# pollution = Theme.new(name: "Pollution", content: "content not yet created", category: environnement)
# pollution.save!
# burnout = Theme.new(name: "Burn-out", content: "content not yet created", category: epanouissement)
# burnout.save!
# fakenews = Theme.new(name: "Esprit critique et fake news", content: "content not yet created", category: education)
# fakenews.save!
# cuisine = Theme.new(name: "Cuisine et Gastronomie", content: "content not yet created", category: patrimoine)
# cuisine.save!
# culture = Theme.new(name: "Culture", content: "content not yet created", category: systeme)
# culture.save!

puts "Adding description to themes"

CSV.foreach('db/csvs/descriptions.csv', { col_sep: ',', quote_char: '"', headers: :first_row }) do |row|
  description = Description.new(content: row['content'])
  description.theme = Theme.find_by(name: row['theme'])
  description.save!
end

# tabagisme_desc = Description.new(content: "Tabagisme description Lorem Ipsum Exemple", theme: tabagisme)
# tabagisme_desc.save!
# antisemitisme_desc = Description.new(content: "Antisémitisme description Lorem Ipsum Exemple", theme: antisemitisme)
# antisemitisme_desc.save!
# violence_desc = Description.new(content: "Violence et Délinquance description Lorem Ipsum Exemple", theme: violence)
# violence_desc.save!
# chomage_desc = Description.new(content: "Chômage description Lorem Ipsum Exemple", theme: chomage)
# chomage_desc.save!
# pollution_desc = Description.new(content: "Pollution description Lorem Ipsum Exemple", theme: pollution)
# pollution_desc.save!
# burnout_desc = Description.new(content: "Burn-out description Lorem Ipsum Exemple", theme: burnout)
# burnout_desc.save!
# fakenews_desc = Description.new(content: "Esprit critique et fake news description Lorem Ipsum Exemple", theme: fakenews)
# fakenews_desc.save!
# cuisine_desc = Description.new(content: "Cuisine et Gastronomie description Lorem Ipsum Exemple", theme: cuisine)
# cuisine_desc.save!
# culture_desc = Description.new(content: "Culture description Lorem Ipsum Exemple", theme: culture)
# culture_desc.save!

puts "Adding discussions to themes"

CSV.foreach('db/csvs/discussions.csv', { col_sep: ',', quote_char: '"', headers: :first_row }) do |row|
  discussion = Discussion.new(title: row['title'], content: row['content'])
  discussion.user = User.find_by(email: row['user'])
  discussion.theme = Theme.find_by(name: row['theme'])
  discussion.save!
end

# # First discussion
# tabagisme_disc1 = Discussion.new(content: "Tabagisme description Lorem Ipsum Exemple", theme: tabagisme, user: charles, title: "tabagisme matters")
# tabagisme_disc1.save!
# antisemitisme_disc1 = Discussion.new(content: "Antisémitisme description Lorem Ipsum Exemple", theme: antisemitisme, user: charles, title: "antisemitisme matters")
# antisemitisme_disc1.save!
# violence_disc1 = Discussion.new(content: "Violence et Délinquance description Lorem Ipsum Exemple", theme: violence, user: charles, title: "violence matters")
# violence_disc1.save!
# chomage_disc1 = Discussion.new(content: "Chômage description Lorem Ipsum Exemple", theme: chomage, user: charles, title: "chomage matters")
# chomage_disc1.save!
# pollution_disc1 = Discussion.new(content: "Pollution description Lorem Ipsum Exemple", theme: pollution, user: charles, title: "pollution matters")
# pollution_disc1.save!
# burnout_disc1 = Discussion.new(content: "Burn-out description Lorem Ipsum Exemple", theme: burnout, user: charles, title: "burnout matters")
# burnout_disc1.save!
# fakenews_disc1 = Discussion.new(content: "Esprit critique et fake news description Lorem Ipsum Exemple", theme: fakenews, user: charles, title: "fakenews matters")
# fakenews_disc1.save!
# cuisine_disc1 = Discussion.new(content: "Cuisine et Gastronomie description Lorem Ipsum Exemple", theme: cuisine, user: charles, title: "cuisine matters")
# cuisine_disc1.save!
# culture_disc1 = Discussion.new(content: "Culture description Lorem Ipsum Exemple", theme: culture, user: charles, title: "culture matters")
# culture_disc1.save!

# # Second discussion
# tabagisme_disc2 = Discussion.new(content: "Tabagisme description Lorem Ipsum Exemple", theme: tabagisme, user: george, title: "tabagisme doesn't really matter")
# tabagisme_disc2.save!
# antisemitisme_disc2 = Discussion.new(content: "Antisémitisme description Lorem Ipsum Exemple", theme: antisemitisme, user: george, title: "antisemitisme doesn't really matter")
# antisemitisme_disc2.save!
# violence_disc2 = Discussion.new(content: "Violence et Délinquance description Lorem Ipsum Exemple", theme: violence, user: george, title: "violence doesn't really matter")
# violence_disc2.save!
# chomage_disc2 = Discussion.new(content: "Chômage description Lorem Ipsum Exemple", theme: chomage, user: george, title: "chomage doesn't really matter")
# chomage_disc2
# pollution_disc2 = Discussion.new(content: "Pollution description Lorem Ipsum Exemple", theme: pollution, user: george, title: "pollution doesn't really matter")
# pollution_disc2
# burnout_disc2 = Discussion.new(content: "Burn-out description Lorem Ipsum Exemple", theme: burnout, user: george, title: "burnout doesn't really matter")
# burnout_disc2
# fakenews_disc2 = Discussion.new(content: "Esprit critique et fake news description Lorem Ipsum Exemple", theme: fakenews, user: george, title: "fakenews doesn't really matter")
# fakenews_disc2
# cuisine_disc2 = Discussion.new(content: "Cuisine et Gastronomie description Lorem Ipsum Exemple", theme: cuisine, user: george, title: "cuisine doesn't really matter")
# cuisine_disc2
# culture_disc2 = Discussion.new(content: "Culture description Lorem Ipsum Exemple", theme: culture, user: george, title: "culture doesn't really matter")
# culture_disc2

# # Third discussion
# tabagisme_disc3 = Discussion.new(content: "Tabagisme description Lorem Ipsum Exemple", theme: tabagisme, user: george, title: "tabagisme doesn't really matter?")
# tabagisme_disc3.save!
# antisemitisme_disc3 = Discussion.new(content: "Antisémitisme description Lorem Ipsum Exemple", theme: antisemitisme, user: george, title: "antisemitisme doesn't really matter?")
# antisemitisme_disc3.save!
# violence_disc3 = Discussion.new(content: "Violence et Délinquance description Lorem Ipsum Exemple", theme: violence, user: george, title: "violence doesn't really matter?")
# violence_disc3.save!
# chomage_disc3 = Discussion.new(content: "Chômage description Lorem Ipsum Exemple", theme: chomage, user: george, title: "chomage doesn't really matter?")
# chomage_disc3
# pollution_disc3 = Discussion.new(content: "Pollution description Lorem Ipsum Exemple", theme: pollution, user: george, title: "pollution doesn't really matter?")
# pollution_disc3
# burnout_disc3 = Discussion.new(content: "Burn-out description Lorem Ipsum Exemple", theme: burnout, user: george, title: "burnout doesn't really matter?")
# burnout_disc3
# fakenews_disc3 = Discussion.new(content: "Esprit critique et fake news description Lorem Ipsum Exemple", theme: fakenews, user: george, title: "fakenews doesn't really matter?")
# fakenews_disc3
# cuisine_disc3 = Discussion.new(content: "Cuisine et Gastronomie description Lorem Ipsum Exemple", theme: cuisine, user: george, title: "cuisine doesn't really matter?")
# cuisine_disc3
# culture_disc3 = Discussion.new(content: "Culture description Lorem Ipsum Exemple", theme: culture, user: george, title: "culture doesn't really matter?")
# culture_disc3

puts "Adding actions to themes"

CSV.foreach('db/csvs/actions.csv', { col_sep: ',', quote_char: '"', headers: :first_row }) do |row|
  action = Action.new(title: row['title'], description: row['description'], location: row['location'], start_date: row['start_date'], end_date: row['end_date'])
  action.user = User.find_by(email: row['user'])
  action.theme = Theme.find_by(name: row['theme'])
  action.save!
end

# # First action
# tabagisme_act1 = Action.new(theme: tabagisme, user: charles, title: "tabagisme matters", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# tabagisme_act1.save!
# antisemitisme_act1 = Action.new(theme: antisemitisme, user: charles, title: "antisemitisme matters", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# antisemitisme_act1.save!
# violence_act1 = Action.new(theme: violence, user: charles, title: "violence matters", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# violence_act1.save!
# chomage_act1 = Action.new(theme: chomage, user: charles, title: "chomage matters", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# chomage_act1.save!
# pollution_act1 = Action.new(theme: pollution, user: charles, title: "pollution matters", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# pollution_act1.save!
# burnout_act1 = Action.new(theme: burnout, user: charles, title: "burnout matters", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# burnout_act1.save!
# fakenews_act1 = Action.new(theme: fakenews, user: charles, title: "fakenews matters", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# fakenews_act1.save!
# cuisine_act1 = Action.new(theme: cuisine, user: charles, title: "cuisine matters", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# cuisine_act1.save!
# culture_act1 = Action.new(theme: culture, user: charles, title: "culture matters", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# culture_act1.save!

# # Second action
# tabagisme_act2 = Action.new(theme: tabagisme, user: george, title: "tabagisme doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# tabagisme_act2.save!
# antisemitisme_act2 = Action.new(theme: antisemitisme, user: george, title: "antisemitisme doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# antisemitisme_act2.save!
# violence_act2 = Action.new(theme: violence, user: george, title: "violence doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# violence_act2.save!
# chomage_act2 = Action.new(theme: chomage, user: george, title: "chomage doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# chomage_act2.save!
# pollution_act2 = Action.new(theme: pollution, user: george, title: "pollution doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# pollution_act2.save!
# burnout_act2 = Action.new(theme: burnout, user: george, title: "burnout doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# burnout_act2.save!
# fakenews_act2 = Action.new(theme: fakenews, user: george, title: "fakenews doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# fakenews_act2.save!
# cuisine_act2 = Action.new(theme: cuisine, user: george, title: "cuisine doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# cuisine_act2.save!
# culture_act2 = Action.new(theme: culture, user: george, title: "culture doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# culture_act2.save!

# # Third action
# tabagisme_act3 = Action.new(theme: tabagisme, user: george, title: "tabagisme doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# tabagisme_act3.save!
# antisemitisme_act3 = Action.new(theme: antisemitisme, user: george, title: "antisemitisme doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# antisemitisme_act3.save!
# violence_act3 = Action.new(theme: violence, user: george, title: "violence doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# violence_act3.save!
# chomage_act3 = Action.new(theme: chomage, user: george, title: "chomage doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# chomage_act3.save!
# pollution_act3 = Action.new(theme: pollution, user: george, title: "pollution doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# pollution_act3.save!
# burnout_act3 = Action.new(theme: burnout, user: george, title: "burnout doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# burnout_act3.save!
# fakenews_act3 = Action.new(theme: fakenews, user: george, title: "fakenews doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# fakenews_act3.save!
# cuisine_act3 = Action.new(theme: cuisine, user: george, title: "cuisine doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# cuisine_act3.save!
# culture_act3 = Action.new(theme: culture, user: george, title: "culture doesn't really matter", description: "coming soon, stay tuned", location: "Paris, France", start_date: "03-03-2019", end_date: "03-11-2019")
# culture_act3.save!

puts "Adding participations to actions"

CSV.foreach('db/csvs/action_participations.csv', { col_sep: ',', quote_char: '"', headers: :first_row }) do |row|
  participation = ActionParticipation.new
  participation.user = User.find_by(email: row['user'])
  participation.action = Action.find_by(title: row['action'])
  participation.save!
end

# ActionParticipation.new(action: tabagisme_act3, user: charles)
# ActionParticipation.new(action: tabagisme_act3, user: george)
# ActionParticipation.new(action: tabagisme_act3, user: lorenzo)

# ActionParticipation.new(action: antisemitisme_act2, user: charles)
# ActionParticipation.new(action: antisemitisme_act2, user: george)
# ActionParticipation.new(action: antisemitisme_act2, user: lorenzo)

# ActionParticipation.new(action: violence_act1, user: charles)
# ActionParticipation.new(action: violence_act1, user: george)
# ActionParticipation.new(action: violence_act1, user: lorenzo)

# ActionParticipation.new(action: chomage_act3, user: charles)
# ActionParticipation.new(action: chomage_act3, user: george)
# ActionParticipation.new(action: chomage_act3, user: lorenzo)

# ActionParticipation.new(action: pollution_act2, user: charles)
# ActionParticipation.new(action: pollution_act2, user: george)
# ActionParticipation.new(action: pollution_act2, user: lorenzo)

# ActionParticipation.new(action: burnout_act1, user: charles)
# ActionParticipation.new(action: burnout_act1, user: george)
# ActionParticipation.new(action: burnout_act1, user: lorenzo)

# ActionParticipation.new(action: fakenews_act3, user: charles)
# ActionParticipation.new(action: fakenews_act3, user: george)
# ActionParticipation.new(action: fakenews_act3, user: lorenzo)

# ActionParticipation.new(action: cuisine_act2, user: charles)
# ActionParticipation.new(action: cuisine_act2, user: george)
# ActionParticipation.new(action: cuisine_act2, user: lorenzo)

# ActionParticipation.new(action: culture_act1, user: charles)
# ActionParticipation.new(action: culture_act1, user: george)
# ActionParticipation.new(action: culture_act1, user: lorenzo)


puts "Initiating conversations"

CSV.foreach('db/csvs/conversations.csv', { col_sep: ',', quote_char: '"', headers: :first_row }) do |row|
  conversation = Conversation.new
  conversation.user1 = User.find_by(email: row['user1'])
  conversation.user2 = User.find_by(email: row['user2'])
  conversation.save!
end

# charge = Conversation.new(user1: charles, user2: george)
# geozo = Conversation.new(user1: george, user2: lorenzo)
# chazo = Conversation.new(user1: charles, user2: lorenzo)

puts "Populating conversations with messages"


CSV.foreach('db/csvs/messages.csv', { col_sep: ',', quote_char: '"', headers: :first_row }) do |row|
  message = Message.new(body: row['body'])
  message.conversation = Conversation.find(row['conversation_id'])
  message.user = User.find_by(email: row['user'])
  message.save!
end

# Message.new(user: charles, conversation: charge, body: "Hello")
# Message.new(user: charles, conversation: charge, body: "How are you?")
# Message.new(user: charles, conversation: charge, body: "Welcome to france forward")
# Message.new(user: george, conversation: charge, body: "Thanks")

