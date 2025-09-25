# Project Nexus — ERD Documentation (Updated)

This ERD reflects the actual Django models defined in your repository.

## Entities

- **User**: Custom user model using email as login, with username, timestamps, and favourites (M2M → Movie).
- **UserProfile**: One-to-one relation with User, includes bio, avatar, phone number, welcome flag.
- **Genre**: TMDB genre data, related to Movie and TVShow.
- **Movie**: TMDB movies cached with overview, poster, TTL, genres relation, and linked to user actions.
- **TVShow**: Similar to Movie but with `first_air_date`, linked to genres.
- **UserFavorite**: Explicit relation (user ↔ movie) with unique constraint.
- **UserWatchlist**: Explicit relation (user ↔ movie) with unique constraint.
- **UserReview**: User reviews of movies, includes rating, timestamps, unique per user+movie.

## Relationships

- A User has exactly one UserProfile.
- A User can have many favorites, watchlist items, and reviews.
- A Movie can belong to many genres, and genres can be shared across Movies and TVShows.
- Movies are linked with Users via explicit relations (favorites, watchlist, reviews) and implicit M2M (favourites).

