Feature: Sign up new user

Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    Given url apiUrl


    @debug
    Scenario: New user sign up         
        * def ramdomInt = Math.floor(Math.random() * 100000)
        Given def userData = {"email": "#('karateuser' + ramdomInt + '@test.com')", "username": "#('karateuser' + ramdomInt)"}
        
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()

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