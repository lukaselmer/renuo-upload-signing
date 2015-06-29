# Renuo Upload Signing

Renuo Upload Signing is a small Sinatra application which generates policies for 
uploading to s3. It stores all the apps and their api keys that use Renuo Upload.

## Ruby

This application requires:

- Ruby 2.2.2

## Installation

```sh
git clone git@git.renuo.ch:renuo/renuo-upload-signing.git
cd renuo-upload-signing
bundle install
```

## Configuration

Copy the database and application example-config files and fill out the missing values.

```sh
cp config/example.env config/.env
```

The string that contains the api keys and the apps they belong to must be stored in the 
env var (in config/.env) called API_KEYS. It has to be in the following format:

```sh
{"key":"some_key","app_name":"some_name","environment": "some_env"};{"key":"some_key","app_name":"some_name","environment": "some_env"};...
```

## Tests

### Run Tests

```sh
rspec
```

## Linting

### Run Linting

```sh
rubocop
```

## Run

```sh
rackup
```

Once you have the application running locally, you can simulate a POST request being made by using the
following cURL command in your terminal (replace the port if it's different for you):

```sh
curl -v --data "api_key=12345678" http://localhost:9292/generate_policy
```

## Problems?

If problems should arise, either contact Nicolas Eckhart, Cyril Kyburz or Lukas Elmer.

![Nicolas Eckhart](http://www.gravatar.com/avatar/742cec893c283daf4a3c287ef2681599)
![Cyril Kyburz](http://www.gravatar.com/avatar/4f522497d9145b89661c381d5fd7a50c)
![Lukas Elmer](https://www.gravatar.com/avatar/697b8e2d3bde4d895eca4fe2dcfe9239)

## MIT License

Coypright 2015 [Renuo GmbH](https://www.renuo.ch/). See [LICENSE](LICENSE) file.
