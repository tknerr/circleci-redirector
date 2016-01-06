Basic Usage

 * redirect to build details ([example](/api/v1/tknerr/linus-kitchen/tree/master/latest)):
  * `GET /api/v1/<user>/<project>/tree/<branch>/latest`
 * redirect to list of artifacts ([example](/api/v1/tknerr/linus-kitchen/tree/master/latest/artifacts)):
  * `GET /api/v1/<user>/<project>/tree/<branch>/latest/artifacts`
 * redirect to build artifact download ([example](/api/v1/tknerr/linus-kitchen/tree/master/latest/artifacts/test-report.html)):
  * `GET /api/v1/<user>/<project>/tree/<branch>/latest/artifacts/<artifact>`

For more details see [tknerr/circleci-redirector](https://github.com/tknerr/circleci-redirector)
