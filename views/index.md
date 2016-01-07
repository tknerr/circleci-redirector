## Basic Usage

### New API Endpoints

Newly added API endpoints allowing you to access the latest build on a specific branch:

 * redirect to build details ([example](/api/v1/project/tknerr/linus-kitchen/tree/master/latest)):
  * `GET /api/v1/project/<user>/<project>/tree/<branch>/latest`
 * redirect to test results ([example](/api/v1/project/tknerr/linus-kitchen/tree/master/latest/tests)):
  * `GET /api/v1/project/<user>/<project>/tree/<branch>/latest/tests`
 * redirect to list of artifacts ([example](/api/v1/project/tknerr/linus-kitchen/tree/master/latest/artifacts)):
  * `GET /api/v1/project/<user>/<project>/tree/<branch>/latest/artifacts`

Also, we provide deterministic URLs for build artifacts:

 * redirect to build artifact download ([example](/api/v1/project/tknerr/linus-kitchen/tree/master/latest/artifacts/test-report.html)):
  * `GET /api/v1/project/<user>/<project>/tree/<branch>/latest/artifacts/<artifact>`

### Existing API Endpoints

All existing API endpoints for GET requests which do not match the above URL patterns are redirected as-is:

 * `GET /api/v1/*`

## Documentation

For more details see [tknerr/circleci-redirector](https://github.com/tknerr/circleci-redirector)
