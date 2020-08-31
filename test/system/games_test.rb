# test/system/games_test.rb
require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "div.letter", count: 10
  end

  test "You can fill the form with a random word, click the play button, and get a message that the word is not in the grid" do
    visit new_url
    fill_in "word", with: "random"
    click_on "Play"
    take_screenshot

    assert_text "Sorry but random can't be built out of"
  end

  test "You can fill the form with a one-letter consonant word, click play, and get a message it’s not a valid English word" do
    visit new_url
    fill_in "word", with: "d"
    click_on "Play"
    take_screenshot

    assert_text "Sorry but d does not seem to be a valid English word..."
  end
end

