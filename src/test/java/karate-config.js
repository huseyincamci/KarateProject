function fn() {
  var env = karate.env; // get system property 'karate.env'
  //karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit-api.bondaracademy.com/api/',
    email: Java.type('java.lang.System').getenv('EMAIL'),
    password: Java.type('java.lang.System').getenv('PASSWORD')
  }

  // If we want to run tests from the command prompt based on the environment type, we use -Dkarate.env='dev' or whatever the name of the environment is.
  // mvn test -Dkarate.env='dev'
  if (env == 'dev') {
    config.articlesPath = 'articles'
  } else if (env == 'qa') {
    //env variables for qa
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})

  return config;
}