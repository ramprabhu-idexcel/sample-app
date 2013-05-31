Feature: Contact me
In order to get in touch
A visitor
Should send me a message by contact form

Scenario: Sends a contact message
Given I am on the contact page
And I fill in "contact visitor name" with "John"
And I fill in "contact visitor email" with "john@mail.me"
And I fill in "contact subject" with "Hello"
And I fill in "contact message" with "Great post!"
When I press "Send message"
Then page should have notice message "Your message was successfully delivered."