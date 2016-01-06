
# CircleCI Redirector

Provides deterministic / bookmarkable URLs which the [CircleCI REST API](https://circleci.com/docs/api) currently does not offer:

 * link to latest build on a specific branch
 * deterministic URLs for build artifacts

# URL Patterns

Accessing the latest build:

 * `GET /<user>/<repo>/tree/<branch>/latest`

Accessing build artifacts of the latest build:

 * `GET /<user>/<repo>/tree/<branch>/latest/artifacts/<artifact>`

Note that the above URLs will respond with a HTTP 302 redirect with the correct URL on circleci, so whenever you use this API ensure that your HTTP client follows redirects.


# Development

Install the gem dependencies:

    $ bundle install

Bring up the sinatra webapp in development mode (with automatic reloading):

    $ rackup

Access the webapp in your browser, hack and reload:

 * http://localhost:9292/


# Contributing

 1. Fork it
 1. Create your feature branch (git checkout -b my-new-feature)
 1. Commit your changes (git commit -am 'Add some feature')
 1. Make sure specs are passing (rake spec)
 1. Push to the branch (git push origin my-new-feature)
 1. Create new Pull Request
