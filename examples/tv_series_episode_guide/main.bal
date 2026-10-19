// Searches The Movie Database for a TV series, then walks its first season
// to print an episode guide with the details of the opening episode.

import ballerina/io;
import ballerinax/themoviedb;

configurable string token = ?;
configurable string seriesQuery = "Game of Thrones";
configurable int seasonNumber = 1;

public function main() returns error? {
    themoviedb:Client tmdb = check new ({auth: {token}});

    // Step 1: Search for the series by name.
    themoviedb:SearchTvSeriesResponse searchResult = check tmdb->searchTvSeries(query = seriesQuery);
    themoviedb:SearchTvSeriesResults[] matches = searchResult.results ?: [];
    if matches.length() == 0 {
        return error("No TV series found for the query: " + seriesQuery);
    }
    int seriesId = matches[0].id;

    // Step 2: Retrieve the series details.
    themoviedb:GetTvSeriesDetailsResponse series = check tmdb->getTvSeriesDetails(seriesId);
    string seriesName = series.name ?: "Untitled";
    io:println(seriesName, ": ", series.numberOfSeasons, " season(s), ", series.numberOfEpisodes, " episode(s)");

    // Step 3: Retrieve the requested season and list its episodes.
    themoviedb:GetTvSeasonDetailsResponse season = check tmdb->getTvSeasonDetails(seriesId, seasonNumber);
    themoviedb:GetTvSeasonDetailsEpisodes[] episodes = season.episodes ?: [];
    if episodes.length() == 0 {
        return error("Season " + seasonNumber.toString() + " has no episodes");
    }
    foreach themoviedb:GetTvSeasonDetailsEpisodes episode in episodes {
        io:println("  Episode ", episode.episodeNumber, ": ", episode.name ?: "Untitled");
    }

    // Step 4: Retrieve the details of the first episode.
    int firstEpisode = episodes[0].episodeNumber;
    themoviedb:GetTvEpisodeDetailsResponse details = check tmdb->getTvEpisodeDetails(seriesId, seasonNumber, firstEpisode);
    io:println("Opening episode aired on ", details.airDate ?: "an unknown date", ", runtime ", details.runtime, " minutes");
}
