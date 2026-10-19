// Searches The Movie Database for a movie by title, then retrieves its details,
// top-billed cast and the streaming providers available in a region.

import ballerina/io;
import ballerinax/themoviedb;

configurable string token = ?;
configurable string movieQuery = "Fight Club";
configurable string region = "US";

public function main() returns error? {
    themoviedb:Client tmdb = check new ({auth: {token}});

    // Step 1: Search for the movie by title.
    themoviedb:SearchMoviesResponse searchResult = check tmdb->searchMovies(query = movieQuery);
    themoviedb:SearchMoviesResults[] matches = searchResult.results ?: [];
    if matches.length() == 0 {
        return error("No movie found for the query: " + movieQuery);
    }
    int movieId = matches[0].id;
    io:println("Found ", matches.length(), " match(es) on page ", searchResult.page);

    // Step 2: Retrieve the details of the best match.
    themoviedb:GetMovieDetailsResponse movie = check tmdb->getMovieDetails(movieId);
    string title = movie.title ?: "Untitled";
    string releaseDate = movie.releaseDate ?: "unknown";
    io:println(title, " (released ", releaseDate, "), runtime ", movie.runtime, " minutes");

    // Step 3: List the top-billed cast.
    themoviedb:GetMovieCreditsResponse credits = check tmdb->getMovieCredits(movieId);
    themoviedb:GetMovieCreditsCast[] cast = credits.cast ?: [];
    foreach themoviedb:GetMovieCreditsCast member in cast.slice(0, int:min(5, cast.length())) {
        string actor = member.name ?: "unknown";
        string role = member.character ?: "unknown";
        io:println("  ", actor, " as ", role);
    }

    // Step 4: Find where the movie can be streamed in the configured region.
    themoviedb:GetMovieWatchProvidersResponse providers = check tmdb->getMovieWatchProviders(movieId);
    map<themoviedb:WatchProviderCountry> byCountry = providers.results ?: {};
    themoviedb:WatchProviderCountry? local = byCountry[region];
    if local is () {
        io:println("No watch providers listed for region ", region);
        return;
    }
    themoviedb:WatchProvider[] streaming = local.flatrate ?: [];
    foreach themoviedb:WatchProvider provider in streaming {
        io:println("  Streaming on ", provider.providerName ?: "unknown");
    }
}
