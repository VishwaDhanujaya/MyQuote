require "test_helper"

class PublicControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      first_name: "Ada",
      last_name: "Lovelace",
      email: "ada@example.com",
      password: "password123",
      status: :active,
      role: :standard
    )

    @philosopher = Philosopher.create!(first_name: "Immanuel", last_name: "Kant")

    @ethics = Category.create!(name: "Ethics")
    @metaphysics = Category.create!(name: "Metaphysics")

    @ethics_quote = Quote.create!(
      text: "Act only according to that maxim which you can at the same time will that it should become a universal law.",
      user: @user,
      philosopher: @philosopher,
      categories: [@ethics],
      is_public: true
    )

    @metaphysics_quote = Quote.create!(
      text: "Space is not something objective and real, but a subjective and ideal construct of the human mind.",
      user: @user,
      philosopher: @philosopher,
      categories: [@metaphysics],
      user_comment: "A cornerstone of transcendental idealism.",
      is_public: true
    )

    Quote.create!(
      text: "This quote should stay hidden.",
      user: @user,
      philosopher: @philosopher,
      categories: [@ethics],
      is_public: false
    )
  end

  test "search matches quote text" do
    get public_quotes_path(q: "universal law")

    assert_response :success
    assert_select ".quote-grid__item", count: 1
    assert_select ".quote-card__text", text: /universal law/i
  end

  test "search matches category names and user comments" do
    get public_quotes_path(q: "transcendental")

    assert_response :success
    assert_select ".quote-grid__item", count: 1
    assert_select ".quote-card__text", text: /Space is not something objective and real/i

    get public_quotes_path(q: "metaphysics")

    assert_response :success
    assert_select ".quote-grid__item", count: 1
    assert_select ".quote-card__text", text: /Space is not something objective and real/i
  end
end
