Feature: Sign up new user

Background: Preconditions
    Given url apiUrl


    @debug
    Scenario: New user sign up         
        * def ramdomInt = Math.floor(Math.random() * 100000)
        Given def userData = {"email": "#('karateuser' + ramdomInt + '@test.com')", "username": "#('karateuser' + ramdomInt)"}
        Given path 'users'
        And request 
        """
            {
                "user": 
                {
                    "email": "#(userData.email)",
                    "password": "#(password)",
                    "username": "#(userData.username)"
                }
            }
        """
        When method Post
        Then status 201