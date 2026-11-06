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

configurable int mockPort = 9090;

listener http:Listener ep0 = new (9090);

@http:ServiceConfig {treatNilableAsOptional: true}
service / on ep0 {
    # Delete
    #
    # + return - Successful response
    resource function delete list/[int listId](@http:Query {name: "session_id"} string sessionId) returns ListStatusResponse {
        return {statusCode: 13, statusMessage: "The item/record was deleted successfully."};
    }

    # Delete Rating
    #
    # + return - Successful response
    resource function delete movie/[int movieId]/rating(@http:Query {name: "guest_session_id"} string? guestSessionId, @http:Query {name: "session_id"} string? sessionId, @http:Header {name: "Content-Type"} string? contentType = "application/json;charset=utf-8") returns DeleteStatusResponse {
        return {statusCode: 13, statusMessage: "The item/record was deleted successfully."};
    }

    # Details
    #
    # + return - Successful response
    resource function get account/[int accountId](@http:Query {name: "session_id"} string? sessionId) returns GetAccountDetailsResponse {
        return {id: 548, name: "Jane Doe", username: "janedoe", includeAdult: false, iso6391: "en", iso31661: "US", avatar: {gravatar: {hash: "c9e9fc152ee756a900db85757c29815d"}, tmdb: {avatarPath: "/xy44UvpbTgzs9kWmp4C3fEaCl5h.png"}}};
    }

    # Favorite Movies
    #
    # + return - Successful response
    resource function get account/[int accountId]/favorite/movies(@http:Query {name: "session_id"} string? sessionId, string language = "en-US", int page = 1, @http:Query {name: "sort_by"} "created_at.asc"|"created_at.desc" sortBy = "created_at.asc") returns ListFavoriteMoviesResponse {
        return {page: 1, totalPages: 1, totalResults: 2, results: [
            {id: 550, title: "Fight Club", originalTitle: "Fight Club", originalLanguage: "en", overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy.", posterPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg", backdropPath: "/hZkgoQYus5vegHoetLkCJzb17zJ.jpg", releaseDate: "1999-10-15", genreIds: [18, 53], popularity: 61.4, voteAverage: 8.4, voteCount: 27000, video: false, adult: false},
            {id: 680, title: "Pulp Fiction", originalTitle: "Pulp Fiction", originalLanguage: "en", overview: "A burger-loving hit man, his philosophical partner and a washed-up boxer converge in this sprawling crime caper.", posterPath: "/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg", backdropPath: "/suaEOtk1N1sgg2MTM7oZd2cfVp3.jpg", releaseDate: "1994-09-10", genreIds: [53, 80], popularity: 55.2, voteAverage: 8.5, voteCount: 26000, video: false, adult: false}
        ]};
    }

    resource function get authentication/token/'new() returns CreateRequestTokenResponse {
        return {success: true, expiresAt: "2026-10-19 15:30:00 UTC", requestToken: "6bc047b88f669d1fb86574f06381005d93d3517a"};
    }

    # Details
    #
    # + return - Successful response
    resource function get configuration() returns GetConfigurationResponse {
        return {images: {baseUrl: "http://image.tmdb.org/t/p/", secureBaseUrl: "https://image.tmdb.org/t/p/", backdropSizes: ["w300", "w780", "w1280", "original"], logoSizes: ["w45", "w92", "w154", "w185", "w300", "w500", "original"], posterSizes: ["w92", "w154", "w185", "w342", "w500", "w780", "original"], profileSizes: ["w45", "w185", "h632", "original"], stillSizes: ["w92", "w185", "w300", "original"]}, changeKeys: ["adult", "air_date", "also_known_as", "biography", "budget"]};
    }

    # Movie
    #
    # + certification - use in conjunction with `region`
    # + certificationGte - use in conjunction with `region`
    # + certificationLte - use in conjunction with `region`
    # + certificationCountry - use in conjunction with the `certification`, `certification.gte` and `certification.lte` filters
    # + watchRegion - use in conjunction with `with_watch_monetization_types` or `with_watch_providers`
    # + withCast - can be a comma (`AND`) or pipe (`OR`) separated query
    # + withCompanies - can be a comma (`AND`) or pipe (`OR`) separated query
    # + withCrew - can be a comma (`AND`) or pipe (`OR`) separated query
    # + withGenres - can be a comma (`AND`) or pipe (`OR`) separated query
    # + withKeywords - can be a comma (`AND`) or pipe (`OR`) separated query
    # + withPeople - can be a comma (`AND`) or pipe (`OR`) separated query
    # + withReleaseType - possible values are: [1, 2, 3, 4, 5, 6] can be a comma (`AND`) or pipe (`OR`) separated query, can be used in conjunction with `region`
    # + withWatchMonetizationTypes - possible values are: [flatrate, free, ads, rent, buy] use in conjunction with `watch_region`, can be a comma (`AND`) or pipe (`OR`) separated query
    # + withWatchProviders - use in conjunction with `watch_region`, can be a comma (`AND`) or pipe (`OR`) separated query
    # + return - Successful response
    resource function get discover/movie(string? certification, @http:Query {name: "certification.gte"} string? certificationGte, @http:Query {name: "certification.lte"} string? certificationLte, @http:Query {name: "certification_country"} string? certificationCountry, @http:Query {name: "primary_release_year"} int? primaryReleaseYear, @http:Query {name: "primary_release_date.gte"} string? primaryReleaseDateGte, @http:Query {name: "primary_release_date.lte"} string? primaryReleaseDateLte, string? region, @http:Query {name: "release_date.gte"} string? releaseDateGte, @http:Query {name: "release_date.lte"} string? releaseDateLte, @http:Query {name: "vote_average.gte"} float? voteAverageGte, @http:Query {name: "vote_average.lte"} float? voteAverageLte, @http:Query {name: "vote_count.gte"} float? voteCountGte, @http:Query {name: "vote_count.lte"} float? voteCountLte, @http:Query {name: "watch_region"} string? watchRegion, @http:Query {name: "with_cast"} string? withCast, @http:Query {name: "with_companies"} string? withCompanies, @http:Query {name: "with_crew"} string? withCrew, @http:Query {name: "with_genres"} string? withGenres, @http:Query {name: "with_keywords"} string? withKeywords, @http:Query {name: "with_origin_country"} string? withOriginCountry, @http:Query {name: "with_original_language"} string? withOriginalLanguage, @http:Query {name: "with_people"} string? withPeople, @http:Query {name: "with_release_type"} int? withReleaseType, @http:Query {name: "with_runtime.gte"} int? withRuntimeGte, @http:Query {name: "with_runtime.lte"} int? withRuntimeLte, @http:Query {name: "with_watch_monetization_types"} string? withWatchMonetizationTypes, @http:Query {name: "with_watch_providers"} string? withWatchProviders, @http:Query {name: "without_companies"} string? withoutCompanies, @http:Query {name: "without_genres"} string? withoutGenres, @http:Query {name: "without_keywords"} string? withoutKeywords, @http:Query {name: "without_watch_providers"} string? withoutWatchProviders, int? year, @http:Query {name: "include_adult"} boolean includeAdult = false, @http:Query {name: "include_video"} boolean includeVideo = false, string language = "en-US", int page = 1, @http:Query {name: "sort_by"} "original_title.asc"|"original_title.desc"|"popularity.asc"|"popularity.desc"|"revenue.asc"|"revenue.desc"|"primary_release_date.asc"|"title.asc"|"title.desc"|"primary_release_date.desc"|"vote_average.asc"|"vote_average.desc"|"vote_count.asc"|"vote_count.desc" sortBy = "popularity.desc") returns DiscoverMoviesResponse {
        return {page: 1, totalPages: 1, totalResults: 1, results: [
            {id: 603, title: "The Matrix", originalTitle: "The Matrix", originalLanguage: "en", overview: "A computer hacker learns about the true nature of reality and his role in the war against its controllers.", posterPath: "/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg", backdropPath: "/fNG7i7RqMErkcqhohV2a6cV1Ehy.jpg", releaseDate: "1999-03-30", genreIds: [28, 878], popularity: 75.8, voteAverage: 8.2, voteCount: 25000, video: false, adult: false}
        ]};
    }

    # Details
    #
    # + return - Successful response
    resource function get list/[int listId](string language = "en-US", int page = 1) returns GetListDetailsResponse {
        return {id: "8228", name: "My Favorite Films", description: "A list of films worth rewatching.", createdBy: "janedoe", favoriteCount: 3, itemCount: 1, iso6391: "en", posterPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg", items: [
            {id: 550, title: "Fight Club", originalTitle: "Fight Club", originalLanguage: "en", overview: "An insomniac office worker and a devil-may-care soap maker form an underground fight club.", posterPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg", backdropPath: "/hZkgoQYus5vegHoetLkCJzb17zJ.jpg", mediaType: "movie", releaseDate: "1999-10-15", genreIds: [18], popularity: 61.4, voteAverage: 8, voteCount: 27000, video: false, adult: false}
        ]};
    }

    # Details
    #
    # + appendToResponse - comma separated list of endpoints within this namespace, 20 items max
    # + return - Successful response
    resource function get movie/[int movieId](@http:Query {name: "append_to_response"} string? appendToResponse, string language = "en-US") returns GetMovieDetailsResponse {
        return {id: 550, title: "Fight Club", originalTitle: "Fight Club", originalLanguage: "en", imdbId: "tt0137523", overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy.", tagline: "Mischief. Mayhem. Soap.", status: "Released", releaseDate: "1999-10-15", runtime: 139, budget: 63000000, revenue: 100853753, popularity: 61.4, voteAverage: 8.4, voteCount: 27000, video: false, adult: false, homepage: "http://www.foxmovies.com/movies/fight-club", posterPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg", backdropPath: "/hZkgoQYus5vegHoetLkCJzb17zJ.jpg", originCountry: ["US"], genres: [{id: 18, name: "Drama"}, {id: 53, name: "Thriller"}], productionCompanies: [{id: 508, name: "Regency Enterprises", logoPath: "/7cxRWzi4LsVm4Utfpr1hfARNurT.png", originCountry: "US"}], productionCountries: [{iso31661: "US", name: "United States of America"}], spokenLanguages: [{iso6391: "en", name: "English", englishName: "English"}]};
    }

    # Credits
    #
    # + return - Successful response
    resource function get movie/[int movieId]/credits(string language = "en-US") returns GetMovieCreditsResponse {
        return {id: 550, cast: [
            {id: 819, castId: 4, character: "The Narrator", creditId: "52fe4250c3a36847f80149f3", gender: 2, knownForDepartment: "Acting", name: "Edward Norton", originalName: "Edward Norton", popularity: 26.9, profilePath: "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg", adult: false, 'order: 0},
            {id: 287, castId: 5, character: "Tyler Durden", creditId: "52fe4250c3a36847f80149f7", gender: 2, knownForDepartment: "Acting", name: "Brad Pitt", originalName: "Brad Pitt", popularity: 40.1, profilePath: "/cckcYc2v0yh1tc9QjRelptcOBko.jpg", adult: false, 'order: 1}
        ], crew: [
            {id: 7467, creditId: "55731b8192514111610027d7", gender: 2, knownForDepartment: "Directing", name: "David Fincher", originalName: "David Fincher", popularity: 20.3, profilePath: "/tpEczFclQZeKAiCeKZZ0adRvtfz.jpg", adult: false, department: "Directing", job: "Director"}
        ]};
    }

    # Watch Providers
    #
    # + return - Successful response
    resource function get movie/[int movieId]/watch/providers() returns GetMovieWatchProvidersResponse {
        return {id: 550, results: {"US": {link: "https://www.themoviedb.org/movie/550-fight-club/watch?locale=US", flatrate: [{providerId: 8, providerName: "Netflix", logoPath: "/pbpMk2JmcoNnQwx5JGpXngfoWtp.jpg", displayPriority: 5}], rent: [{providerId: 2, providerName: "Apple TV", logoPath: "/peURlLlr8jggOwK53fJ5wdQl05y.jpg", displayPriority: 3}]}}};
    }

    # Popular
    #
    # + region - ISO-3166-1 code
    # + return - Successful response
    resource function get movie/popular(string? region, string language = "en-US", int page = 1) returns ListPopularMoviesResponse {
        return {page: 1, totalPages: 1, totalResults: 1, results: [
            {id: 1061474, title: "Superman", originalTitle: "Superman", originalLanguage: "en", overview: "Superman, a journalist in Metropolis, embarks on a journey to reconcile his Kryptonian heritage with his human upbringing.", posterPath: "/ombsmhYUqR4qqOLOxAyr5V8hbyv.jpg", backdropPath: "/wrFpXMNBRj2PBiN4Z5kix51XaIZ.jpg", releaseDate: "2025-07-09", genreIds: [878, 12, 28], popularity: 320.5, voteAverage: 7.6, voteCount: 4200, video: false, adult: false}
        ]};
    }

    # Top Rated
    #
    # + region - ISO-3166-1 code
    # + return - Successful response
    resource function get movie/top_rated(string? region, string language = "en-US", int page = 1) returns ListTopRatedMoviesResponse {
        return {page: 1, totalPages: 1, totalResults: 1, results: [
            {id: 278, title: "The Shawshank Redemption", originalTitle: "The Shawshank Redemption", originalLanguage: "en", overview: "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison.", posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", backdropPath: "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg", releaseDate: "1994-09-23", genreIds: [18, 80], popularity: 90.3, voteAverage: 8.7, voteCount: 28000, video: false, adult: false}
        ]};
    }

    # Details
    #
    # + appendToResponse - comma separated list of endpoints within this namespace, 20 items max
    # + return - Successful response
    resource function get person/[int personId](@http:Query {name: "append_to_response"} string? appendToResponse, string language = "en-US") returns GetPersonDetailsResponse {
        return {id: 287, name: "Brad Pitt", gender: 2, birthday: "1963-12-18", placeOfBirth: "Shawnee, Oklahoma, USA", knownForDepartment: "Acting", biography: "William Bradley Pitt is an American actor and film producer.", popularity: 40.1, profilePath: "/cckcYc2v0yh1tc9QjRelptcOBko.jpg", imdbId: "nm0000093", alsoKnownAs: ["William Bradley Pitt"], adult: false};
    }

    # Movie
    #
    # + return - Successful response
    resource function get search/movie(string query, @http:Query {name: "primary_release_year"} string? primaryReleaseYear, string? region, string? year, @http:Query {name: "include_adult"} boolean includeAdult = false, string language = "en-US", int page = 1) returns SearchMoviesResponse {
        return {page: 1, totalPages: 1, totalResults: 1, results: [
            {id: 155, title: query, originalTitle: query, originalLanguage: "en", overview: "Batman raises the stakes in his war on crime with the help of Lt. Jim Gordon and District Attorney Harvey Dent.", posterPath: "/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: "/nMKdUUepR0i5zn0y1T4CsSB5chy.jpg", releaseDate: "2008-07-16", genreIds: [18, 28, 80], popularity: 70.2, voteAverage: 8.5, voteCount: 32000, video: false, adult: false}
        ]};
    }

    # TV
    #
    # + firstAirDateYear - Search only the first air date. Valid values are: 1000..9999
    # + year - Search the first air date and all episode air dates. Valid values are: 1000..9999
    # + return - Successful response
    resource function get search/tv(string query, @http:Query {name: "first_air_date_year"} int? firstAirDateYear, int? year, @http:Query {name: "include_adult"} boolean includeAdult = false, string language = "en-US", int page = 1) returns SearchTvSeriesResponse {
        return {page: 1, totalPages: 1, totalResults: 1, results: [
            {id: 1399, name: "Game of Thrones", originalName: "Game of Thrones", originalLanguage: "en", overview: "Seven noble families fight for control of the mythical land of Westeros.", posterPath: "/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg", backdropPath: "/2OMB0ynKlyIenMJWI2Dy9IWT4c.jpg", firstAirDate: "2011-04-17", genreIds: [10765, 18], originCountry: ["US"], popularity: 150.7, voteAverage: 8.4, voteCount: 25000, adult: false}
        ]};
    }

    # Movies
    #
    # + language - `ISO-639-1`-`ISO-3166-1` code
    # + return - Successful response
    resource function get trending/movie/["day"|"week" timeWindow](string language = "en-US") returns TrendingResponse {
        return {page: 1, totalPages: 1, totalResults: 1, results: [
            {id: 550, title: "Fight Club", originalTitle: "Fight Club", originalLanguage: "en", overview: "An insomniac office worker and a devil-may-care soap maker form an underground fight club.", posterPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg", backdropPath: "/hZkgoQYus5vegHoetLkCJzb17zJ.jpg", mediaType: "movie", releaseDate: "1999-10-15", genreIds: [18, 53], popularity: 61.4, voteAverage: 8.4, voteCount: 27000, video: false, adult: false}
        ]};
    }

    # Details
    #
    # + appendToResponse - comma separated list of endpoints within this namespace, 20 items max
    # + return - Successful response
    resource function get tv/[int seriesId](@http:Query {name: "append_to_response"} string? appendToResponse, string language = "en-US") returns GetTvSeriesDetailsResponse {
        return {id: 1399, name: "Game of Thrones", originalName: "Game of Thrones", originalLanguage: "en", overview: "Seven noble families fight for control of the mythical land of Westeros.", tagline: "Winter is coming.", 'type: "Scripted", firstAirDate: "2011-04-17", numberOfEpisodes: 73, numberOfSeasons: 8, inProduction: false, popularity: 150.7, voteAverage: 8.4, voteCount: 25000, adult: false, posterPath: "/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg", backdropPath: "/2OMB0ynKlyIenMJWI2Dy9IWT4c.jpg", originCountry: ["US"], languages: ["en"], episodeRunTime: [60], genres: [{id: 10765, name: "Sci-Fi & Fantasy"}, {id: 18, name: "Drama"}], networks: [{id: 49, name: "HBO", logoPath: "/tuomPhY2UtuPTqqFnKMVHvSb724.png", originCountry: "US"}], createdBy: [{id: 9813, creditId: "5256c8c219c2956ff604858a", name: "David Benioff", gender: 2, profilePath: "/xvNN5huL0X8yJ7h3IZfGG4O2zBD.jpg"}], seasons: [{id: 3624, name: "Season 1", seasonNumber: 1, episodeCount: 10, airDate: "2011-04-17", overview: "The first season of Game of Thrones.", posterPath: "/wgfKiqzuMrFIkU1M68DDDY8kGC1.jpg", voteAverage: 8}], lastEpisodeToAir: {id: 1551830, name: "The Iron Throne", seasonNumber: 8, episodeNumber: 6, showId: 1399, airDate: "2019-05-19", runtime: 80, voteAverage: 4.8, voteCount: 300, overview: "In the aftermath of the devastating attack on King's Landing, Daenerys must face the survivors.", productionCode: "806", stillPath: "/3x2lKCBc9WHU3WuYPFQ0lZfCTaF.jpg"}};
    }

    # Details
    #
    # + appendToResponse - comma separated list of endpoints within this namespace, 20 items max
    # + return - Successful response
    resource function get tv/[int seriesId]/season/[int seasonNumber](@http:Query {name: "append_to_response"} string? appendToResponse, string language = "en-US") returns GetTvSeasonDetailsResponse {
        return {id: 3624, internalId: "5256c89f19c2956ff6046d47", name: "Season 1", seasonNumber: 1, airDate: "2011-04-17", overview: "Trouble is brewing in the Seven Kingdoms of Westeros.", voteAverage: 8.3, posterPath: "/wgfKiqzuMrFIkU1M68DDDY8kGC1.jpg", episodes: [
            {id: 63056, name: "Winter Is Coming", seasonNumber: 1, episodeNumber: 1, showId: 1399, airDate: "2011-04-17", runtime: 62, voteAverage: 8.1, voteCount: 450, overview: "Lord Ned Stark is asked to serve as Hand of the King.", productionCode: "101", episodeType: "standard", stillPath: "/9hGF3WUkBf7cSjMg0cdMDHJkByd.jpg"}
        ]};
    }

    # Details
    #
    # + appendToResponse - comma separated list of endpoints within this namespace, 20 items max
    # + return - Successful response
    resource function get tv/[int seriesId]/season/[int seasonNumber]/episode/[int episodeNumber](@http:Query {name: "append_to_response"} string? appendToResponse, string language = "en-US") returns GetTvEpisodeDetailsResponse {
        return {id: 63056, name: "Winter Is Coming", seasonNumber: 1, episodeNumber: 1, airDate: "2011-04-17", runtime: 62, voteAverage: 8.1, voteCount: 450, overview: "Lord Ned Stark is asked to serve as Hand of the King.", productionCode: "101", stillPath: "/9hGF3WUkBf7cSjMg0cdMDHJkByd.jpg", crew: [{id: 44797, name: "Tim Van Patten", creditId: "5256c8b919c2956ff604840c", gender: 2, department: "Directing", job: "Director", knownForDepartment: "Directing", originalName: "Tim Van Patten", popularity: 3.4, adult: false}], guestStars: [{id: 22970, name: "Peter Dinklage", creditId: "5256c8b919c2956ff6048422", gender: 2, character: "Tyrion Lannister", knownForDepartment: "Acting", originalName: "Peter Dinklage", popularity: 25.1, 'order: 0, adult: false}]};
    }

    # Add Favorite
    #
    # + payload - Media item to mark or unmark as a favorite 
    # + return - Successful response
    resource function post account/[int accountId]/favorite(@http:Query {name: "session_id"} string? sessionId, @http:Payload FavoriteRequest payload) returns StatusResponse {
        return {statusCode: 1, statusMessage: "Success."};
    }

    resource function post authentication/session/'new(@http:Payload CreateSessionRequest payload) returns CreateSessionResponse {
        return {success: true, sessionId: "2629f70fb498edc263a0adb99118ac41f0053e8c"};
    }

    # Create
    #
    # + payload - Name, description and language of the new list 
    # + return - Successful response
    resource function post list(@http:Query {name: "session_id"} string sessionId, @http:Payload CreateListRequest payload) returns CreateListResponse {
        return {success: true, statusCode: 1, statusMessage: "The item/record was created successfully.", listId: 8228};
    }

    # Add Movie
    #
    # + payload - Movie to add to the list 
    # + return - Successful response
    resource function post list/[int listId]/add_item(@http:Query {name: "session_id"} string sessionId, @http:Payload ListItemRequest payload) returns ListStatusResponse {
        return {statusCode: 12, statusMessage: "The item/record was updated successfully."};
    }

    # Add Rating
    #
    # + payload - Rating value to submit for the movie 
    # + return - Successful response
    resource function post movie/[int movieId]/rating(@http:Query {name: "guest_session_id"} string? guestSessionId, @http:Query {name: "session_id"} string? sessionId, @http:Payload RatingRequest payload, @http:Header {name: "Content-Type"} string contentType = "application/json;charset=utf-8") returns StatusResponse {
        return {statusCode: 1, statusMessage: "Success."};
    }
}
