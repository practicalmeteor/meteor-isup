Package.describe({
  name: 'isup',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: '',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.1');
  api.use('ecmascript');
  api.addFiles('isup.js');
});

Package.onTest(function(api) {
  api.use("coffeescript");
  api.use("http");

  api.use(['practicalmeteor:mocha',
          'practicalmeteor:sinon',
          'practicalmeteor:chai',
          'practicalmeteor:loglevel']);

  api.use('practicalmeteor:isup');

  api.addFiles('src/tests/IsUpTest.coffee', "server");
});
