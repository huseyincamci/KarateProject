Feature: Tests for the home page

    Scenario: Get all tags
        Given url "https://conduit-api.bondaracademy.com/api/tags"
        When method Get
        Then status 200

    Scenario: Get 10 articles from the page
        Given url "https://conduit-api.bondaracademy.com/api/articles?limit=10&offset=0"
        When method Get
        Then status 200

    Scenario: Get 10 articles from the page by param
        Given param limit = 10
        Given param offset = 0
        Given url "https://conduit-api.bondaracademy.com/api/articles"
        When method Get
        Then status 200

    Scenario: Get 10 articles from the page by object param
        Given params {limit: 10, offset: 0}
        Given url "https://conduit-api.bondaracademy.com/api/articles"
        When method Get
        Then status 200

    Scenario: Get 10 articles from the page by object param
        Given params {limit: 10, offset: 0}
        Given url "https://conduit-api.bondaracademy.com/api/"
        Given path "articles"
        When method Get
        Then status 200