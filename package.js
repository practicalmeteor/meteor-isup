Package.describe({
  name: 'practicalmeteor:isup',
  version: '0.1.0',
  // Brief, one-line summary of the package.
  summary: 'Adds a /isup route to verify your app is up and can fetch docs from mongodb.',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/practicalmeteor/meteor-isup.git',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {

  // Meteor core packages
  api.use('coffeescript', "server");
  api.use('mongo', "server");
  api.use('webapp', 'server');

  // practicalmeteor packages
  api.use("practicalmeteor:core", "server");

  api.addFiles('src/isup.coffee', "server");
  api.addFiles('src/router.coffee', "server");
});

Package.onTest(function(api) {
  api.use("coffeescript");
  api.use("http");

  api.use(['practicalmeteor:mocha',
          'practicalmeteor:sinon',
          'practicalmeteor:chai',
          'practicalmeteor:loglevel']);

  api.use('practicalmeteor:isup');

  api.addFiles('tests/isupTest.coffee');
});
