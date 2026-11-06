# Ballerina The Movie Database connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-themoviedb/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-themoviedb/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-themoviedb.svg)](https://github.com/ballerina-platform/module-ballerinax-themoviedb/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/themoviedb.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fthemoviedb)

## Overview

[The Movie Database (TMDB)](https://www.themoviedb.org/) is a community-built database of movies, TV series, people and images. The TMDB API gives programmatic access to this catalogue, along with account features such as favorites, watchlists, ratings and custom lists.

The connector supports version 3 of the TMDB API and exposes its full operation surface as Ballerina remote methods, so you can search and browse the catalogue and manage account data directly from your integrations.

## Setup guide

To use the connector you need a TMDB API read access token. The token is enough for general use. Managing favorites, watchlists, ratings and lists also needs a user-authorised `session_id`, which you obtain by creating a request token, having the user approve it, and then calling `createSession`.

1. Create a free account at [The Movie Database](https://www.themoviedb.org/signup) and sign in.

2. Open the API section of your account settings and request an API key by accepting the terms of use.

3. Copy the **API Read Access Token** shown in the API settings page.

## Quickstart

To use the connector in your Ballerina application, update the `.bal` file as follows.

**Step 1: Import the module**

```ballerina
import ballerinax/themoviedb;
```

**Step 2: Create a new connector instance**

Create a `Config.toml` file with your token:

```toml
token = "<API Read Access Token>"
```

Then declare the configurable in your `.bal` file:

```ballerina
configurable string token = ?;
```

**Step 3: Invoke the connector operation**

Initialize the client and call an operation:

```ballerina
public function main() returns error? {
    themoviedb:Client tmdb = check new ({auth: {token}});
    themoviedb:ListPopularMoviesResponse _ = check tmdb->listPopularMovies();
}
```

**Step 4: Run the Ballerina application**

```bash
bal run
```

## Examples

The `The Movie Database` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-themoviedb/tree/main/examples/), covering the following use cases:

1. [Movie search and details](examples/movie_search_details/movie_search_details.md) - Search for a movie by title, then fetch its details, cast and streaming providers.
2. [TV series episode guide](examples/tv_series_episode_guide/tv_series_episode_guide.md) - Search for a TV series and list the episodes of a season.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`themoviedb` package](https://central.ballerina.io/ballerinax/themoviedb/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
