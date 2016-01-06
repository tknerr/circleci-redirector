
# CircleCI Redirector

Extends the [CircleCI REST API](https://circleci.com/docs/api) with deterministic / bookmarkable URLs for:

 * latest build on a specific branch
 * build artifact download links

The circleci-redirector acts as a drop-in replacement for all GET requests to the CircleCI REST API. It adds a few new URL patterns (see below), but still supports the old ones.

Note that every request is responded with a HTTP 302 redirect to a specific build on CircleCI, so whenever you use this API ensure that your HTTP client follows redirects.

## Public Instance

A public instance of circleci-redirector is running here:

 * [https://circleciredirector-tkn.rhcloud.com/](https://circleciredirector-tkn.rhcloud.com/)

It is being auto-deployed whenever something is committed to `master`. Feel free to use it as-is, or fork this repo and deploy it on your own if you want more control.

## URL Patterns

### New API Endpoints

Get redirected to the latest build on a specific branch:

 * `GET /api/v1/project/<user>/<project>/tree/<branch>/latest`

Get redirected to the test results for the latest build on a specific branch:

 * `GET /api/v1/project/<user>/<project>/tree/<branch>/latest/tests`

Get redirected to the list of build artifacts for the latest build on a specific branch:

 * `GET /api/v1/project/<user>/<project>/tree/<branch>/latest/artifacts`

Get redirected to the download link of a specific build artifact:

 * `GET /api/v1/project/<user>/<project>/tree/<branch>/latest/artifacts/<artifact>`

### Existing API Endpoints

Every other GET request to `/api/v1/*` which does not match the above patterns is being HTTP 302 redirected to the [CircleCI REST API](https://circleci.com/docs/api) as-is, which means you can use it as a drop-in replacement if you want.

POST and DELETE requests are currently not forwarded or redirected.

## Request Parameters / Authentication Tokens

All request parameters are preserved when redirecting to the CircleCI API, which also includes the authentication tokens (`circle-token=1234...`) which the [CircleCI REST API](https://circleci.com/docs/api) uses.


Whenever you need to transmit sensitive data such as authentication tokens, please:

 * use https only
 * consider using per-project auth tokens with limited access
 * consider running your own circleci-redirector

## Development

Install the gem dependencies:

    $ bundle install

Bring up the sinatra webapp in development mode (with automatic reloading):

    $ rackup

Access the webapp in your browser, hack and reload:

 * [http://localhost:9292](http://localhost:9292)


## Contributing

 1. Fork it
 1. Create your feature branch (git checkout -b my-new-feature)
 1. Commit your changes (git commit -am 'Add some feature')
 1. Make sure specs are passing (rake spec)
 1. Push to the branch (git push origin my-new-feature)
 1. Create new Pull Request
