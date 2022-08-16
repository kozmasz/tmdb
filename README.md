# Diligent Coding Challange
The task is to create a UI (be it either a pure rails view rendered from the backend, or any frontend rendered page) which has an input box and a search button.

Upon pressing the button, it queries movies using the value of the input, using the backend you build.

The backend may forward the query to an external api (if it doesn't have the answer) and displays the results in a list.

Our subscription limits how many requests we are allowed to send to the 3rd party API. If that limit exceeded, we will be overcharged, so we build a server which only forward users request if the,
query is not in its cache.

Some backend code stub already prepared in [lib/movies_client.rb](./lib/movies_client.rb) for the project.
While building the application, integrate this file in your solution and implement the core logic in it.

## Requirements
- The backend is implemented in ruby
- Any ruby based framework can be used, if needed
- Any datastore can be used (flat file, SQL, No-SQL, etc)
- Access to the ["The Movie Database - registration required"](https://developers.themoviedb.org/3/search/search-movies)

When you have finished your work, upload the code to any code hosting site (Bitbucket, Github, Gitlab, etc) and provide us with link.

## High level workflow:

### Sending Requests:
The UI (from the browser) sends request to the backend.

![Request Architecture](architecture.png)

### Processing the request:
The query consist the search term and optionally the current page.

The backend checks if the same query has received within 2 mins and the results are already saved in its data store?

  1. If not, it forwards the request to 3rd party API:
    - Fetch movies matching the query: The API is ["The Movie Database - registration required"](https://developers.themoviedb.org/3/search/search-movies).
    - Save the search and its results in a datastore:
      - Results returned by The Movie Database API
      - Set view count to 0

  2. If yes:
    If the same keyword(s) are looked up within 2 mins:
    - Serve directly by the backend, no API request should be sent to the 3rd party API.
    - Record view count should be incremented by 1

Display results

Indicate whether results are fetched from our server or from the 3rd party API (display a small notice somewhere on the screen)

### Pagination
The results should be paginated if more than 20 items returned by the query, otherwise pagination elements should not displayed.

## Bonus
- Nice UI
- Give user feedback what's happening (progress indicators)
- Handle errors between our and the remote API service (eg: the server cannot access the 3rd party API, because of network issues)
- Write tests
- Deploy the application
- Think about future improvements

# Database structure

### media table

|      Column      |              Type              | Collation | Nullable |              Default              |
|------------------|--------------------------------|-----------|----------|-----------------------------------|
|id                | bigint                         |           | not null | nextval('media_id_seq'::regclass) |
|tmdb_id           | integer                        |           | not null |                                   |
|media_type        | character varying              |           | not null |                                   |
|adult             | boolean                        |           | not null | false                             |
|release_date      | date                           |           |          |                                   |
|title             | character varying              |           |          |                                   |
|original_title    | character varying              |           |          |                                   |
|original_language | character varying              |           |          |                                   |
|overview          | text                           |           |          |                                   |
|poster_path       | character varying              |           |          |                                   |
|vote_average      | double precision               |           |          |                                   |
|vote_count        | integer                        |           |          |                                   |
|popularity        | double precision               |           |          |                                   |
|backdrop_path     | character varying              |           |          |                                   |
|created_at        | timestamp(6) without time zone |           | not null |                                   |
|updated_at        | timestamp(6) without time zone |           | not null |                                   |

Indexes:
Indexes:
* "media_pkey" PRIMARY KEY, btree (id)
* "custom_uniq_index_2" UNIQUE, btree (tmdb_id, media_type)
* "index_media_on_tmdb_id" btree (tmdb_id)

### genres table

|Column     |              Type              | Collation | Nullable |              Default               |
|-----------|--------------------------------|-----------|----------|------------------------------------|
|id         | bigint                         |           | not null | nextval('genres_id_seq'::regclass) |
|tmdb_id    | integer                        |           | not null |                                    |
|name       | character varying              |           | not null |                                    |
|created_at | timestamp(6) without time zone |           | not null |                                    |
|updated_at | timestamp(6) without time zone |           | not null |                                    |

Indexes:
 * "genres_pkey" PRIMARY KEY, btree (id)
 * "index_genres_on_tmdb_id" btree (tmdb_id)

### media_genres table

|    Column     |              Type              | Collation | Nullable |                 Default                  |
|---------------|--------------------------------|-----------|----------|------------------------------------------|
|id             | bigint                         |           | not null | nextval('media_genres_id_seq'::regclass) |
|tmdb_medium_id | integer                        |           | not null |                                          |
|tmdb_genre_id  | integer                        |           | not null |                                          |
|created_at     | timestamp(6) without time zone |           | not null |                                          |
|updated_at     | timestamp(6) without time zone |           | not null |                                          |

Indexes:
* "media_genres_pkey" PRIMARY KEY, btree (id)
* "custom_uniq_index_1" UNIQUE, btree (tmdb_medium_id, tmdb_genre_id)

# Getting started

## TODO

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
