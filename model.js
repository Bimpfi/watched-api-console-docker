const generator = require('@api-components/api-model-generator');
generator('./apis.json', {
  dest: './models/',
  src: './'
})
  .then(() => console.log('Models created'))
  .catch((cause) => console.error(cause));
