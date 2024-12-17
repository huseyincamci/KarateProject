function fn() {
  var env = karate.env; // get system property 'karate.env'
  //karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    myVarName: 'someValue',
    email: Java.type('java.lang.System').getenv('EMAIL'),
    password: Java.type('java.lang.System').getenv('PASSWORD')
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}