Feature: Tests for the home page1

Background: Define URL
    Given url "https://conduit-api.bondaracademy.com/api/"

    Scenario: Get all tags
        Given path "tags"
        When method Get
        Then status 200
        And match response.tags contains any ['fish', 'dog', 'GitHub']

    Scenario: Get all tags and validate response data
        Given path "tags"
        When method Get
        Then status 200
        And match response.tags contains "GitHub"

    Scenario: Get all tags and validate response 
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['GitHub', 'Coding']
        And match response.tags !contains "truck"
        And match response.tags == "#array"
        And match each response.tags == "#string"

    Scenario: Get 10 articles from the page by object param
        Given params {limit: 10, offset: 0}
        Given path "articles"
        When method Get
        Then status 200
        And match response.articles == "#[10]"
        And match response.articlesCount != 42



    # To run tests by tag name: mvn clean test -D'karate.options="--tags @debug"'
    @debug
    Scenario: Get 10 articles from the page by object param and run by tags
        Given params {limit: 10, offset: 0}
        Given path "articles"
        When method Get
        Then status 200
        And match response.articles == "#[10]"
        And match response.articles[0].createdAt contains '2024'
        And match response.articles[*].favoritesCount contains 0
        And match response..bio contains null
        And match each response..following == false
        And match each response..following == '#boolean'
        And match each response..favoritesCount == '#number'
        And match each response..bio == '##string'
       # And match response.articlesCount == 42