# TV series episode guide

This example searches The Movie Database for a TV series, then lists the episodes of a season and prints the details of the opening episode.

## Prerequisites

1. A TMDB API read access token. Create one in your [TMDB account API settings](https://www.themoviedb.org/settings/api).

2. Create a `Config.toml` file in the example directory with the following content:

    ```toml
    token = "<TMDB API read access token>"
    seriesQuery = "Game of Thrones"
    seasonNumber = 1
    ```

## Run the example

Execute the following command to run the example:

```bash
bal run
```
