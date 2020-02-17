require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Filling the form with a random word, and get a message that the word is not in the grid." do
    visit new_url
    letters = find('.letters').text.gsub("\n", " ")
    word = ('a'..'z').to_a.sample(10).join.upcase
    fill_in "word", with: word
    click_on "Submit"

    within('.result') do
      assert_text "Sorry but #{word} can't be built out of #{letters}"
    end
  end

  test "Filling the form with a one-letter consonant word, and get a message that the word is not a valid English word." do
    visit new_url
    letters = find('.letters').text.gsub("\n", " ")
    word = letters[0]
    fill_in "word", with: word
    click_on "Submit"

    within('.result') do
      assert_text "Sorry but #{word} does not seem to be a valid English word..."
    end
  end
end
