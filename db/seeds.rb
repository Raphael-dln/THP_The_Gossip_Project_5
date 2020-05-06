require 'faker'

User.destroy_all
City.destroy_all
Gossip.destroy_all
GossipTag.destroy_all

10.times do
  city = City.create(
    name: Faker::Nation.capital_city,
    zip_code: Faker::Address.zip_code
  )
end
puts "Les villes ont été créées"

10.times do
  user = User.create(
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name, 
    description: Faker::Hipster.sentence, 
    email: Faker::Internet.email,
    age: rand(16..88),
    image: Faker::Avatar.image,
    city: City.all.sample
    )
end
puts "Les users ont été créées"

20.times do
  gossip = Gossip.create(
    title: Faker::Hipster.sentence(word_count: 2, supplemental: true, random_words_to_add: 3),
    content: Faker::Movies::HarryPotter.quote,
    user: User.all.sample
    )
end
puts "Les potins ont été créées"

10.times do
    tag = Tag.create(
        title: Faker::App.name
    )
end 
puts "Les tags ont été créées"

30.times do
    gossip_tag = GossipTag.create(
        gossip: Gossip.all.sample,
        tag: Tag.all.sample
    )
end


10.times do
    private = PrivateMessage.new
    private.sender = User.all.sample
    private.recipient = User.all.sample
    private.content = Faker::ChuckNorris.fact
    private.save
end

puts "T'es ready pal"