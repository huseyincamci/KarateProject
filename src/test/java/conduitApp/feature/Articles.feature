Feature: Articles Post Requests


Background: Define URL
    Given url "https://conduit-api.bondaracademy.com/api/"


    Scenario: Create new article
        * def email = email
        * def password = password
        * karate.log("deneme " + email)

        Given path "users/login"
        And request { "user": { "email": "#(email)", "password": "#(password)" } }
        When method Post
        Then status 200
        * def token = response.user.token

        Given header Authorization = 'Token ' + token
        Given path 'articles'
        * def randomTitle = "Post Random Title " + Math.floor(Math.random() * 10000)
        
        And request {"article":{"title": "#(randomTitle)","description":"fadsf adfs f","body":"tetset est e","tagList":["tatat"]}}
        When method Post
        Then status 201
        And match response.article.title == randomTitle