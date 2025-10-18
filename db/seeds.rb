QuoteCategory.destroy_all
Quote.destroy_all
Category.destroy_all
Philosopher.destroy_all
User.destroy_all

admin = User.create!(
  first_name: "John",
  last_name: "Jones",
  email: "admin@myquotes.com",
  password: "admin123",
  password_confirmation: "admin123",
  role: :admin,
  status: :active
)

standard = User.create!(
  first_name: "Vincent",
  last_name: "Brown",
  email: "vinceb@myemail.com",
  password: "vince123",
  password_confirmation: "vince123",
  role: :standard,
  status: :active
)

plato = Philosopher.create!(first_name: "Plato", last_name: "", birth_year: -428, death_year: -348, biography: "A classical Greek philosopher.")
aristotle = Philosopher.create!(first_name: "Aristotle", birth_year: -384, death_year: -322, biography: "Student of Plato and teacher of Alexander the Great.")
marcus = Philosopher.create!(first_name: "Marcus", last_name: "Aurelius", birth_year: 121, death_year: 180, biography: "Roman emperor and Stoic philosopher.")

ethics = Category.create!(name: "Ethics")
logic = Category.create!(name: "Logic")
stoicism = Category.create!(name: "Stoicism")

Quote.create!(
  text: "The unexamined life is not worth living.",
  publication_year: -399,
  user_comment: "A reminder to reflect daily.",
  is_public: true,
  user: standard,
  philosopher: plato,
  categories: [ethics]
)

Quote.create!(
  text: "It is the mark of an educated mind to be able to entertain a thought without accepting it.",
  publication_year: -350,
  is_public: true,
  user_comment: "Keep an open mind.",
  user: standard,
  philosopher: aristotle,
  categories: [logic]
)

Quote.create!(
  text: "You have power over your mind - not outside events.",
  publication_year: 170,
  user_comment: "Guides my daily stoic practice.",
  is_public: false,
  user: standard,
  philosopher: marcus,
  categories: [stoicism, ethics]
)

puts "Seeded admin: #{admin.email} / admin123"
puts "Seeded standard user: #{standard.email} / vince123"
