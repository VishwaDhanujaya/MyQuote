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
wisdom = Category.create!(name: "Wisdom")
mindfulness = Category.create!(name: "Mindfulness")
leadership = Category.create!(name: "Leadership")

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

seneca = Philosopher.create!(first_name: "Seneca", last_name: "the Younger", birth_year: -4, death_year: 65, biography: "Roman Stoic philosopher, statesman, and dramatist.")
confucius = Philosopher.create!(first_name: "Confucius", birth_year: -551, death_year: -479, biography: "Chinese philosopher and politician of the Spring and Autumn period.")
epictetus = Philosopher.create!(first_name: "Epictetus", birth_year: 55, death_year: 135, biography: "Greek Stoic philosopher known for his discourses on resilience.")
laozi = Philosopher.create!(first_name: "Lao", last_name: "Tzu", birth_year: -601, death_year: -531, biography: "Ancient Chinese philosopher and writer, the reputed author of the Tao Te Ching.")
simone = Philosopher.create!(first_name: "Simone", last_name: "de Beauvoir", birth_year: 1908, death_year: 1986, biography: "French existentialist philosopher, feminist, and social theorist.")

Quote.create!(
  text: "Luck is what happens when preparation meets opportunity.",
  publication_year: 55,
  is_public: true,
  user: admin,
  philosopher: seneca,
  categories: [stoicism, leadership]
)

Quote.create!(
  text: "He who conquers himself is the mightiest warrior.",
  is_public: true,
  user: admin,
  philosopher: confucius,
  categories: [wisdom, ethics]
)

Quote.create!(
  text: "Don't explain your philosophy. Embody it.",
  is_public: false,
  user_comment: "Quiet accountability reminder.",
  user: standard,
  philosopher: epictetus,
  categories: [stoicism]
)

Quote.create!(
  text: "When I let go of what I am, I become what I might be.",
  is_public: true,
  user: standard,
  philosopher: laozi,
  categories: [mindfulness, wisdom]
)

Quote.create!(
  text: "Change your life today. Don't gamble on the future, act now, without delay.",
  publication_year: 1963,
  is_public: true,
  user_comment: "Motivates me to take immediate action.",
  user: admin,
  philosopher: simone,
  categories: [leadership, wisdom]
)

puts "Seeded admin: #{admin.email} / admin123"
puts "Seeded standard user: #{standard.email} / vince123"
