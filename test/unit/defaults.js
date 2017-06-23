/*
 * Test defaults
*/

'use strict';

SwaggerEditor.config(function($provide) {
  $provide.constant('defaults', {
    disableCodeGen: true,
    examplesFolder: 'spec-files/',
    repoyamlFolder: 'repo-yaml/',
    editorOptions: {},
    exampleFiles: [
      'default.yaml',
      'heroku-pets.yaml',
      'minimal.yaml',
      'echo.yaml',
      'petstore_simple.yaml',
      'petstore_full.yaml',
      'basic-auth.yaml',
      'security.yaml'
    ],
    repoyamlFiles: [
      'combined.yaml',
    ],
    autocompleteExtension: {},
    useBackendForStorage: false,
    backendEndpoint: '/editor/spec',
    useYamlBackend: false,
    disableFileMenu: false,
    headerBranding: false,
    enableTryIt: true,
    brandingCssClass: '',
    importProxyUrl: 'https://cors-it.herokuapp.com/?url='
  });
});
