Feature: Articles Post Requests


Background: Define URL
    Given url apiUrl

    #@ignore
    # if you want to skip test then use @ignore tag name
    Scenario: Create new article
        # * def email = email
        # * def password = password

        # Given path "users/login"
        # And request { "user": { "email": "#(email)", "password": "#(password)" } }
        # When method Post
        # Then status 200
        # * def token = response.user.token

        # * def tokenResponse = call read('classpath:helpers/CreateToken.feature')
        # * def token = tokenResponse.authToken

        # Given header Authorization = 'Token ' + token
        Given path articlesPath
        * def randomTitle = "Post Random Title " + Math.floor(Math.random() * 10000)
        
        And request {"article":{"title": "#(randomTitle)","description":"fadsf adfs f","body":"tetset est e","tagList":["tatat"]}}
        When method Post
        Then status 201
        And match response.article.title == randomTitle


    Scenario: Create and delete article
        # * def email = email
        # * def password = password

        # Given path "users/login"
        # And request { "user": { "email": "#(email)", "password": "#(password)" } }
        # When method Post
        # Then status 200
        # * def token = response.user.token
        # * def tokenResponse = call read('classpath:helpers/CreateToken.feature')
        # * def token = tokenResponse.authToken

        # Given header Authorization = 'Token ' + token
        Given path 'articles'
        * def randomTitle = "Delete Article Random Title " + Math.floor(Math.random() * 10000)
        
        And request {"article":{"title": "#(randomTitle)","description":"fadsf adfs f","body":"tetset est e","tagList":["tatat"]}}
        When method Post
        Then status 201
        * def articleId = response.article.slug

        Given params {limit: 10, offset: 0}
        Given path "articles"
        When method Get
        Then status 200
        #And match response.articles[0].title == randomTitle

        # Given header Authorization = 'Token ' + token
        Given path "articles",articleId
        When method Delete
        Then status 204


