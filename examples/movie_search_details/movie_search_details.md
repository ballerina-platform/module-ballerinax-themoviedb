# Movie search and details

This example searches The Movie Database for a movie by title, then retrieves its details, top-billed cast and the streaming providers available in a region.

## Prerequisites

1. A TMDB API read access token. Create one in your [TMDB account API settings](https://www.themoviedb.org/settings/api).

2. Create a `Config.toml` file in the example directory with the following content:

    ```toml
    token = "<TMDB API read access token>"
    movieQuery = "Fight Club"
    region = "US"
    ```

## Run the example

Execute the following command to run the example:

```bash
bal run
```
