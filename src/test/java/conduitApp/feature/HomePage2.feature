Feature: Tests for the home page1

Background: Define URL
    Given url "https://conduit-api.bondaracademy.com/api/"

Scenario: Get all tags
    Given path "tags"
    When method Get
    Then status 200