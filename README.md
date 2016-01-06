
# CircleCI Redirector

Provides deterministic / bookmarkable URLs which the [CircleCI REST API](https://circleci.com/docs/api) currently does not offer:

 * link to latest build on a specific branch
 * deterministic URLs for build artifacts

The URLs below respond with a HTTP 302 redirect to a specific build on circleci, so whenever you use this API ensure that your HTTP client follows redirects.

## URL Patterns

Get redirected to the latest build details:

 * `GET /api/v1/<user>/<project>/tree/<branch>/latest`

Get redirected to the list of build artifacts for the latest build:

 * `GET /api/v1/<user>/<project>/tree/<branch>/latest/artifacts`

Get redirected to the download link of a specific build artifact:

 * `GET /api/v1/<user>/<project>/tree/<branch>/latest/artifacts/<artifact>`

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
