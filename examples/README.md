# Examples

The `ballerinax/themoviedb` connector provides practical examples illustrating usage in various scenarios.

1. [Movie search and details](https://github.com/ballerina-platform/module-ballerinax-themoviedb/tree/main/examples/movie_search_details) - Search for a movie by title, then fetch its details, cast and streaming providers.
2. [TV series episode guide](https://github.com/ballerina-platform/module-ballerinax-themoviedb/tree/main/examples/tv_series_episode_guide) - Search for a TV series and list the episodes of a season.

## Prerequisites

Create a TMDB API read access token in your TMDB account API settings and provide it through a `Config.toml` file in the example directory.

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
