
# CircleCI Redirector

Provides deterministic / bookmarkable URLs which the [CircleCI REST API](https://circleci.com/docs/api) currently does not offer:

 * link to latest build on a specific branch
 * deterministic URLs for build artifacts

The URLs below respond with a HTTP 302 redirect to a specific build on circleci, so whenever you use this API ensure that your HTTP client follows redirects.

## Public Instance

A public instance of circleci-redirector is running here:

 * [https://circleciredirector-tkn.rhcloud.com/](https://circleciredirector-tkn.rhcloud.com/)

It currently runs on [OpenShift](https://www.openshift.com/pricing/plan-comparison.html), and is auto-deployed whenever something is committed to `master`. I plan to keep it running there, as it really does not incur any costs. Feel free to use it as is, or fork this repo and deploy it on your own if you want more control.

## URL Patterns

Get redirected to the latest build on a specific branch:

 * `GET /api/v1/project/<user>/<project>/tree/<branch>/latest`

Get redirected to the list of build artifacts for the latest build:

 * `GET /api/v1/project/<user>/<project>/tree/<branch>/latest/artifacts`

Get redirected to the download link of a specific build artifact:

 * `GET /api/v1/project/<user>/<project>/tree/<branch>/latest/artifacts/<artifact>`

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
