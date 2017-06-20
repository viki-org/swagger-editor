'use strict';

var _ = require('lodash');

SwaggerEditor.controller('OpenReposApiCtrl', function OpenReposApiCtrl($scope,
  $uibModalInstance, $rootScope, $state, $http, FileLoader, Builder, Storage,
  Analytics, defaults) {

  $http({
    method: 'GET',
    url: '/repo-yaml/',
    cache: true
  }).then(function(response) {
    $scope.files = response.data;
    $scope.status = response.status;
  }, function(response) {
    $scope.files = response.data || 'Request failed';
    $scope.status = response.status;
  });
  $scope.selectedFile = defaults.repoyamlFiles[0];

  $scope.open = function(file) {
    // removes trailing slash from pathname because examplesFolder always have a
    // leading slash
    var pathname = _.endsWith(location.pathname, '/') ?
      location.pathname.substring(1) :
      location.pathname;

    var url = '/' + pathname + defaults.repoyamlFolder + file;
    console.log(url);

    FileLoader.loadFromUrl(url).then(function(value) {
      Storage.save('yaml', value);
      $rootScope.editorValue = value;
      $state.go('home', {tags: null});
      $uibModalInstance.close();
    }, $uibModalInstance.close);

    Analytics.sendEvent('open-repos-api', 'open-repos-api:' + file);
  };

  $scope.cancel = $uibModalInstance.close;
});
