# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.new(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #flunk "Unimplemented"
#  index1 = page.body.index(e1)
#  index2 = page.body.index(e2)
#  if index1 == nil || index2 == nil
#    false.should == true
#  else
#    index1.should < index2
#  end
  page.text.should =~ /.*#{e1}.*#{e2}/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split.each do |rating|
    step %Q{I #{ uncheck ? "uncheck" : "check" } "ratings_#{rating}"}
    #step %Q{the "ratings_#{rating}" checkbox should#{ uncheck ? " not" : "" } be checked}
    #uncheck ? uncheck("ratings[#{rating}]") : check("ratings[#{rating}]")
    #puts page.text
  end
end

When /I (un)?check all the ratings/ do |uncheck|
  Movie.all_ratings.each do |rating|
    step %{I #{ uncheck ? "uncheck" : "check" } "ratings_#{rating}"}
    #uncheck ? uncheck("ratings[#{rating}]") : check("ratings[#{rating}]")
  end
end

Then /I should see (all|none) of the movies/ do |see|
  Movie.select(:title).map(&:title).each do |movie|
    step %Q{I should #{see == "none" ? "not" : ""} see "#{movie}"}
  end
  #puts page.text
end