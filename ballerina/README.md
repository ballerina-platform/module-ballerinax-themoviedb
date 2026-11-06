## Overview

[The Movie Database (TMDB)](https://www.themoviedb.org/) is a community-built database of movies, TV series, people and images. The TMDB API gives programmatic access to this catalogue, along with account features such as favorites, watchlists, ratings and custom lists.

The connector supports version 3 of the TMDB API and exposes its full operation surface as Ballerina remote methods, so you can search and browse the catalogue and manage account data directly from your integrations.

### Key features

- Search and discover movies, TV series, people, companies and keywords
- Retrieve detailed information, credits, images, videos, reviews and translations for movies, TV series, seasons and episodes
- Find streaming, rental and purchase providers for a title by region
- Manage account favorites, watchlists, ratings and custom lists
- Create and manage guest and user sessions

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

1. [Movie search and details](../examples/movie_search_details/movie_search_details.md) - Search for a movie by title, then fetch its details, cast and streaming providers.
2. [TV series episode guide](../examples/tv_series_episode_guide/tv_series_episode_guide.md) - Search for a TV series and list the episodes of a season.
