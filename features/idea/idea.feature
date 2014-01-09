Feature: Creating Ideas
In order to get in touch
A visitor
Should send me a message by Idea form

Scenario: Creating a new idea	
    When user logs on through the logon page credential with "nramprabu@gmail.com" and "ramprabu38"
	Given I am on the new_idea page
	And I fill in "idea_name" with "john"
	And I fill in "idea_description" with "test test test test test test test"
	And I select "ramprabu" from "idea_user_id"
	When I press "idea_new_submit"
	Then I should see "Idea was successfully created."
	When I follow "Logout"

Scenario: Invalid credential
    When user logs on through the logon page credential with "nramprabu@gmail.com" and "ramprabu39"
    Then I should see "Invalid email or password."

Scenario: Editing idea
    When user logs on through the logon page credential with "nramprabu@gmail.com" and "ramprabu38"
    Given I am on the ideas page
    When I follow "edit_idea7"
    And I fill in "idea_name" with "ram"
	And I fill in "idea_description" with "cucumber cucumber cucumber cucumber cucumber cucumber"
	When I press "idea_new_submit"
	Then I should see "Idea was successfully updated."
	When I follow "Logout"    