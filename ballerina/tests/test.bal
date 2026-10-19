// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.


import ballerina/http;
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.themoviedb.org/3" : string `http://localhost:${mockPort}`;
function getToken() returns string|error {
    if !isLiveServer {
        return "test_token";
    }
    string value = os:getEnv("TMDB_API_TOKEN");
    if value == "" {
        return error("TMDB_API_TOKEN must be set when IS_LIVE_SERVER=true");
    }
    return value;
}

final string token = check getToken();

final Client tmdb = check new ({auth: {token}, httpVersion: http:HTTP_1_1}, serviceUrl);

const int ACCOUNT_ID = 548;
const int MOVIE_ID = 550;
const int PERSON_ID = 287;
const int SERIES_ID = 1399;
const string SESSION_ID = "2629f70fb498edc263a0adb99118ac41f0053e8c";

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetAccountDetails() returns error? {
    GetAccountDetailsResponse response = check tmdb->getAccountDetails(ACCOUNT_ID, sessionId = SESSION_ID);
    test:assertTrue(response.id > 0);
    test:assertTrue(response.username is string);
}

@test:Config {groups: ["mock_tests"]}
function testAddFavorite() returns error? {
    if isLiveServer {
        return;
    }
    StatusResponse response = check tmdb->addFavorite(ACCOUNT_ID, {mediaType: "movie", mediaId: MOVIE_ID, favorite: true}, sessionId = SESSION_ID);
    test:assertTrue(response.statusCode > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListFavoriteMovies() returns error? {
    ListFavoriteMoviesResponse response = check tmdb->listFavoriteMovies(ACCOUNT_ID, sessionId = SESSION_ID);
    test:assertTrue(response.page >= 1);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testCreateRequestToken() returns error? {
    CreateRequestTokenResponse response = check tmdb->createRequestToken();
    test:assertTrue(response.success);
    test:assertTrue(response.requestToken is string);
}

@test:Config {groups: ["mock_tests"]}
function testCreateSession() returns error? {
    if isLiveServer {
        return;
    }
    CreateSessionResponse response = check tmdb->createSession({requestToken: "6bc047b88f669d1fb86574f06381005d93d3517a"});
    test:assertTrue(response.success);
    test:assertTrue(response.sessionId is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetConfiguration() returns error? {
    GetConfigurationResponse response = check tmdb->getConfiguration();
    test:assertTrue(response.images is GetConfigurationImages);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testDiscoverMovies() returns error? {
    DiscoverMoviesResponse response = check tmdb->discoverMovies();
    test:assertTrue(response.page >= 1);
    test:assertTrue((response.results ?: []).length() > 0);
}

@test:Config {groups: ["mock_tests"]}
function testAddMovieToList() returns error? {
    if isLiveServer {
        return;
    }
    ListStatusResponse response = check tmdb->addMovieToList(8228, {mediaId: MOVIE_ID}, sessionId = SESSION_ID);
    test:assertTrue(response.statusCode > 0);
}

@test:Config {groups: ["mock_tests"]}
function testCreateList() returns error? {
    if isLiveServer {
        return;
    }
    CreateListResponse response = check tmdb->createList({name: "My Favorite Films", description: "Films worth rewatching.", language: "en"}, sessionId = SESSION_ID);
    test:assertTrue(response.success);
    test:assertTrue(response.listId > 0);
}

@test:Config {groups: ["mock_tests"]}
function testGetListDetails() returns error? {
    GetListDetailsResponse response = check tmdb->getListDetails(8228);
    test:assertTrue(response.name is string);
}

@test:Config {groups: ["mock_tests"]}
function testDeleteList() returns error? {
    if isLiveServer {
        return;
    }
    CreateListResponse created = check tmdb->createList({name: "Temporary list", language: "en"}, sessionId = SESSION_ID);
    ListStatusResponse response = check tmdb->deleteList(created.listId, sessionId = SESSION_ID);
    test:assertTrue(response.statusCode > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListPopularMovies() returns error? {
    ListPopularMoviesResponse response = check tmdb->listPopularMovies();
    test:assertTrue((response.results ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListTopRatedMovies() returns error? {
    ListTopRatedMoviesResponse response = check tmdb->listTopRatedMovies();
    test:assertTrue((response.results ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetMovieDetails() returns error? {
    GetMovieDetailsResponse response = check tmdb->getMovieDetails(MOVIE_ID);
    test:assertEquals(response.id, MOVIE_ID);
    test:assertTrue(response.title is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetMovieCredits() returns error? {
    GetMovieCreditsResponse response = check tmdb->getMovieCredits(MOVIE_ID);
    test:assertTrue((response.cast ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetMovieWatchProviders() returns error? {
    GetMovieWatchProvidersResponse response = check tmdb->getMovieWatchProviders(MOVIE_ID);
    test:assertEquals(response.id, MOVIE_ID);
    test:assertTrue(response.results is map<WatchProviderCountry>);
}

@test:Config {groups: ["mock_tests"]}
function testAddMovieRating() returns error? {
    if isLiveServer {
        return;
    }
    StatusResponse response = check tmdb->addMovieRating(MOVIE_ID, {value: 8.5}, sessionId = SESSION_ID);
    test:assertTrue(response.statusCode > 0);
}

@test:Config {groups: ["mock_tests"]}
function testDeleteMovieRating() returns error? {
    if isLiveServer {
        return;
    }
    StatusResponse _ = check tmdb->addMovieRating(MOVIE_ID, {value: 7.0}, sessionId = SESSION_ID);
    DeleteStatusResponse response = check tmdb->deleteMovieRating(MOVIE_ID, sessionId = SESSION_ID);
    test:assertTrue(response.statusCode > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetPersonDetails() returns error? {
    GetPersonDetailsResponse response = check tmdb->getPersonDetails(PERSON_ID);
    test:assertEquals(response.id, PERSON_ID);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testSearchMovies() returns error? {
    string query = "fight club";
    SearchMoviesResponse response = check tmdb->searchMovies(query = query);
    SearchMoviesResults[] results = response.results ?: [];
    test:assertTrue(results.length() > 0);
    if !isLiveServer {
        test:assertEquals(results[0].title, query);
    }
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testSearchTvSeries() returns error? {
    SearchTvSeriesResponse response = check tmdb->searchTvSeries(query = "game of thrones");
    test:assertTrue((response.results ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListTrendingMovies() returns error? {
    TrendingResponse response = check tmdb->listTrendingMovies("week");
    test:assertTrue((response.results ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetTvSeriesDetails() returns error? {
    GetTvSeriesDetailsResponse response = check tmdb->getTvSeriesDetails(SERIES_ID);
    test:assertEquals(response.id, SERIES_ID);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetTvSeasonDetails() returns error? {
    GetTvSeasonDetailsResponse response = check tmdb->getTvSeasonDetails(SERIES_ID, 1);
    test:assertEquals(response.seasonNumber, 1);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetTvEpisodeDetails() returns error? {
    GetTvEpisodeDetailsResponse response = check tmdb->getTvEpisodeDetails(SERIES_ID, 1, 1);
    test:assertEquals(response.episodeNumber, 1);
}
