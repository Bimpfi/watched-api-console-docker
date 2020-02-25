# Watched API Console for Docker

MuleSoft's API Console is an enterprise grade API Documentation tool.
This is an open source version of the console used in Anypoint Platform.
This dockerized API Console for using in development environment is based on the API Console 6.0.1 from https://github.com/mulesoft/api-console.git repository. There has been made changes to create a docker image in which changes in an api definition will be watched to rebuild it and refresh the browser view.

## Prerequisites

There must be created two files to configure which APIs shall be used and where they are stored. 
#### API Paths
The API paths must be stored in an ```api.json``` in form of
```json
{
  "apis/<api_name>/<api_name>.raml": "RAML 1.0"
}
```
It is just one object in which a property key represents a api path and its value the type of api definition language like ```RAML 1.0``` or ```["OAS 2.0", "application/yaml"]``` (OAS has to be an array due to the MIME-Type).

The ```apis/``` part in the path is optional but recommended due to the project structure.

#### Used APIs
The apis to use must be stored in an ```api-map.js``` in form of
```js
export default [
  ['<api_name>', '<Title>']
  // The name must be the same as the name of the raml file
  // The title is the title shown in the api select list
];
```
It is a two dimensional array in which the arrays consists of two string. The first string is the api name which has to be the same as the api name of the related api. The second string is the title which will be shown in the list of the selectable apis

## Setup

1. Create the docker image by follow command
```
  docker build -t <name>/api-console .
```

2. Run a container with the image by follow command
```sh
docker run -d -p 8000:8000 \
-v "<path_to_api>":/usr/src/app/apis/<api_name> \
-v "<path_to_api-map.js>":/usr/src/app/api-map.js \
-v "<path_to_apis.json>":/usr/src/app/apis.json \
<name>/api-console
```

The first host path set by ```-v "<path_to_api>":/usr/src/app/apis/<api_name>``` has to contain the api file given in the apis.json file. For example if the ```my_api.raml``` is located in ```/home/user/my_api/``` then the path has to be set by ```-v "/home/user/my_api/":/usr/src/app/apis/<api_name>```.

## Example API Configuration
Assuming there is a api definition named ```my_api.raml``` located in ```/home/user/my_api``` and related ```apis.json``` as well ```api-map.js``` located in ```/home/user/my_api_config``` then the config has to be as follow

#### apis.json
```json
{
  "apis/my_api/my_api.raml": "RAML 1.0"
}
```

#### api-map.js
```js
export default [
  ['my_api', 'My Api']
];
```

#### docker run command
```sh
docker run -d -p 8000:8000 \
-v "/home/user/my_api":/usr/src/app/apis/my_api \
-v "/home/user/my_api_config/api-map.js":/usr/src/app/api-map.js \
-v "/home/user/my_api_config/apis.json":/usr/src/app/apis.json \
my_api/api-console
```

## Roadmap
- Use API Consol without demo code
- Allow switching themes

## Contributing

Please read [CONTRIBUTING.md] for details on our code of conduct, and the process for submitting pull requests to us.

## Authors
* **Markus Hülß** - *Initial work* - [Bimpfi](https://github.com/Bimpfi)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the CPAL-1.0 License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Thanks to [Mulesoft](https://github.com/mulesoft) for developing API Console
