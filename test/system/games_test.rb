require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "p", count: 11
  end

  test "Going to /new and fill_in random word" do
    visit new_url
    fill_in "word", with: "asdasdasda"
    click_on "Play"
    assert test: "Result"
    assert_select "p[text=?]", /.*be build out of.*/
  end

  test "Going to /new and fill_in with consonant" do
    visit new_url
    fill_in "word", with: "n"
    click_on "Play"
    assert_select "p[text=?]", /.*does not seem to be a valid English word.*/
  end

  test "Going to /new and fill_in with an" do
    visit new_url
    fill_in "word", with: "an"
    click_on "Play"
    assert_select "p[text=?]", /.*Congratulations.*/
  end
end
