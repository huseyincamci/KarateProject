Feature: Sign up new user

Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def timeValidator = read('classpath:helpers/timeValidator.js')    
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()
    Given url apiUrl


    @debug
    Scenario: New user sign up         
        * def ramdomInt = Math.floor(Math.random() * 100000)
        Given def userData = {"email": "#('karateuser' + ramdomInt + '@test.com')", "username": "#('karateuser' + ramdomInt)"}

        * def jsFunction = 
        """
            function () {
                var DataGenerator = Java.type('helpers.DataGenerator')
                var generator = new DataGenerator()
                return generator.getRandomUsernameByInstance()
            }
        """

        * def randomUsername2 = call jsFunction

        Given path 'users'
        And request 
        """
            {
                "user": 
                {
                    "email": "#(randomEmail)",
                    "password": "#(password)",
                    "username": "#(randomUsername2)"
                }
            }
        """
        When method Post
        Then status 201
        And match response == 
        """
            {
                "user": {
                    "id": "#number",
                    "email": #(randomEmail),
                    "username": #(randomUsername2),
                    "bio": '##string',
                    "image": "#string",
                    "token":"#string"
                }
            }
        """


    Scenario Outline: Validate Sign Up error messages
        Given path 'users'
        And request
        """
            {
                "user": {
                    "email": "<email>",
                    "password": "<password>",
                    "username": "<username>"
                }
            }
        """
        When method Post
        Then status 422
        And match response == <errorResponse>

        Examples:
            | email             | password    |username                 | errorResponse                                       |
            | #(randomEmail)    | #(password) | olen.little             | {"errors": {"username": ["has already been taken"]}}|
            | ellis790@test.com | #(password) | #(randomUsername)       | {"errors": {"email": ["has already been taken"]}}   |
            |                   | #(password) | #(randomUsername)       | {"errors": {"email": ["can't be blank"]}}           |
            | #(randomEmail)    |             | #(randomUsername)       | {"errors": {"password": ["can't be blank"]}}        |
            | #(randomEmail)    | #(password) |                         | {"errors": {"username": ["can't be blank"]}}        |

        