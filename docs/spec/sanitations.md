_Author_:  @DimuthuMadushan \
_Created_: 2026/10/19 \
_Updated_: 2026/10/19 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from The Movie Database. 
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/themoviedb/3/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Change the `url` property of the servers object
- **Original**: `https://api.themoviedb.org`
- **Updated**: `https://api.themoviedb.org/3`
- **Reason**: Common prefix added to base URL to simplify endpoint paths.
<!-- auto-generated -->

2. Update the API Paths
- **Original**: Paths included common prefix `/3` in each endpoint.
- **Updated**: Common prefix removed from endpoints as it is now in the base URL.
- **Reason**: Simplifies API paths and avoids duplication.
<!-- auto-generated -->

3. Change the OpenAPI version from `3.1.0` to `3.0.3`
- **Reason**: Under `3.1.0` flatten and align drop the `type` of every parameter and property, so query and path parameters were generated as `anydata` and several operations were skipped. This change is made in the original spec `docs/spec/openapi.json`.

4. Add `items` to 20 array schemas that declared `type: array` without `items`
- **Reason**: Arrays without an item type are not valid for client generation. The affected response properties (`genres`, `production_companies`, `production_countries`, `spoken_languages`, `created_by`, `networks`, `episodes`, `person_results`, `tv_results`, `tv_episode_results`, `tv_season_results`, `descriptors`, `also_known_as`, `languages`, `episode_run_time`) now use `string`, `integer` or generic `object` items as the vendor documentation implies. This change is made in the original spec `docs/spec/openapi.json`.

5. Replace the `RAW_BODY` request bodies with named request schemas
- **Reason**: The twelve POST and DELETE request bodies were declared as `{RAW_BODY: string}` with the real payload only in the examples. They now reference `FavoriteRequest`, `WatchlistRequest`, `CreateSessionRequest`, `ConvertSessionRequest`, `LoginSessionRequest`, `DeleteSessionRequest`, `ListItemRequest`, `CreateListRequest` and `RatingRequest` in `components/schemas`, modelled on the documented example payloads. This change is made in the original spec `docs/spec/openapi.json`.

6. Model the country-keyed `results` of the three watch provider responses as a map
- **Reason**: `/movie/{movie_id}/watch/providers`, `/tv/{series_id}/watch/providers` and `/tv/{series_id}/season/{season_number}/watch/providers` listed one inline schema per country code (88 to 98 each). `results` is now an object with `additionalProperties` referencing the new `WatchProviderCountry` and `WatchProvider` schemas. This change is made in the original spec `docs/spec/openapi.json`.

7. Model the country-keyed `certifications` of the movie and TV certification lists as a map
- **Reason**: Each country code was an inline property (45 and 40). `certifications` is now an object with `additionalProperties` of an array of the new `Certification` schema. This change is made in the original spec `docs/spec/openapi.json`.

8. Rename the `_id` property of the TV season details response to `internalId`
- **Reason**: `_id` and `id` both mapped to the Ballerina field `id`, which is a redeclared symbol. This is a hand edit to the aligned spec (`x-ballerina-name` of `_id` in `GetTvSeasonDetailsResponse`) and must be re-applied after a re-align.

9. Change the security scheme `sec0` from an `apiKey` header to HTTP bearer authentication
- **Reason**: The TMDB API read access token is a bearer token. `components.securitySchemes.sec0` is now `{type: http, scheme: bearer}` with the description "TMDB API Read Access Token", so the client takes `http:BearerTokenConfig` through `ConnectionConfig.auth`. This change is made in the original spec `docs/spec/openapi.json`.

10. Remove `format: int32` from all integer schemas and parameters
- **Reason**: The 180 `format: int32` entries generated `int:Signed32` in the client and types. They were removed so every integer generates as plain `int`. This change is made in the original spec `docs/spec/openapi.json`. It was a mechanical `perl -0pi` substitution that deleted each `"format": "int32"` member with its adjoining comma, verified by comparing the data before and after (identical apart from those members).

11. Fill the response descriptions and make the operation summaries distinct
- **Reason**: Every response was described only as `200`, and only 80 of the 152 operation summaries were distinct. A response description was written for each of the 152 operations, and 103 summaries were rewritten so each operation has its own. This change is made in the original spec `docs/spec/openapi.json` using `tooling/apply_descriptions.py` with `docs/spec/description-decisions.json`.

12. Give `getMovieRecommendations` a typed response
- **Reason**: The 200 response schema of `/movie/{movie_id}/recommendations` was an empty object, so the client returned `record {}`. It now declares `page`, `results`, `total_pages` and `total_results`, with `results` items referencing the new `MovieListItem` schema, so the method returns `GetMovieRecommendationsResponse`. This change is made in the original spec `docs/spec/openapi.json`.

13. Change five path parameters from `string` to `integer`
- **Reason**: `movie_id` (`/movie/{movie_id}/keywords`), `person_id` (`/person/{person_id}/combined_credits`), `series_id` (`/tv/{series_id}/similar`), `keyword_id` (`/keyword/{keyword_id}/movies`) and `episode_number` (`/tv/{series_id}/season/{season_number}/episode/{episode_number}/external_ids`) are integer identifiers everywhere else in the API. This is an intentional usability change made in the original spec `docs/spec/openapi.json`. The string identifiers `credit_id`, `review_id`, `tv_episode_group_id`, `guest_session_id` and `external_id` are unchanged.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --client-methods remote --license docs/license.txt
```

Note: The license year is hardcoded to 2024, change if necessary.
