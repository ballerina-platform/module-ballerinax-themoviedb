# Running Tests

## Prerequisites

By default the tests run against the bundled mock server (`tests/mock_service.bal`), which starts automatically with `bal test` and needs no credentials.

To run the tests against the live TMDB API instead, set the following environment variables:

| Variable | Description |
|---|---|
| `IS_LIVE_SERVER` | Set to `true` to call `https://api.themoviedb.org/3` instead of the mock server. |
| `TMDB_API_TOKEN` | TMDB API read access token. Required when `IS_LIVE_SERVER` is `true`. |

The mock server listens on port `9090` by default. Set the `mockPort` configurable to use another port.

Operations that create, change or delete account data (favorites, sessions, lists, ratings) run against the mock server only.

## Running the tests

Execute the following command to run the mock tests:

```bash
bal test
```

To run the tests against the live API:

```bash
IS_LIVE_SERVER=true TMDB_API_TOKEN=<token> bal test --groups live_tests
```
