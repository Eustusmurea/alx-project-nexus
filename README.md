# Project Nexus – Movie API

A Django-based backend service that integrates with the **TMDb API** to fetch and cache movies into a PostgreSQL database.  
The API provides endpoints for user authentication, user management, and movie access.

---

## Features
- **Authentication** – Custom auth system (`authz` app).
- **Users** – CRUD operations for managing users.
- **Movies** – Fetch movies from TMDb, cache in Postgres, and serve via API.
- **Versioned API** – Current version is `v1` for movies.
- **Admin Dashboard** – Manage data through Django Admin.
- **Dockerized Deployment** – Run with `docker-compose`.

---

## Tech Stack
- **Backend:** Django, Django REST Framework
- **Database:** PostgreSQL
- **External API:** [TMDb API](https://developers.themoviedb.org/3)
- **Containerization:** Docker + docker-compose
- **Task Queue (optional):** Celery + Redis (future support)

---

## ⚙️ Setup & Installation

### 1️⃣ Clone Repository
```bash
git clone https://github.com/your-username/project_nexus.git
cd project_nexus
2️⃣ Environment Variables
Create a .env file in the root directory with the following:

env
Copy code
DEBUG=1
SECRET_KEY=your_secret_key
DJANGO_ALLOWED_HOSTS=localhost 127.0.0.1 [::1]

DATABASE_NAME=project_nexus
DATABASE_USER=postgres
DATABASE_PASSWORD=postgres
DATABASE_HOST=db
DATABASE_PORT=5432

TMDB_API_KEY=your_tmdb_api_key
3️⃣ Run with Docker
bash
Copy code
docker-compose up --build
Access app:

API root: http://localhost:8000/

Admin: http://localhost:8000/admin/

4️⃣ Apply Migrations
bash
Copy code
docker-compose exec web python manage.py migrate
5️⃣ Create Superuser
bash
Copy code
docker-compose exec web python manage.py createsuperuser
📂 Project Structure
bash
Copy code
project_nexus/
│── movies/          # Movies app
│── users/           # Users app
│── authz/           # Authentication app
│── movie_backend/   # Main Django config
│── docker-compose.yml
│── requirements.txt
│── README.md

Base URLs:

Development: http://localhost:8000/

Production: https://yourdomain.com/

🔑 Authentication

Project Nexus uses JWT tokens for authentication.
Include in headers:

Authorization: Bearer <access_token>

Register

POST /auth/register/

Request:

{
  "username": "johndoe",
  "email": "john@example.com",
  "password": "secret123"
}


Response:

{
  "refresh": "<refresh_token>",
  "access": "<access_token>",
  "user": {
    "id": 1,
    "username": "johndoe",
    "email": "john@example.com"
  }
}

Login

POST /auth/login/

Request:

{
  "email": "john@example.com",
  "password": "secret123"
}


Response:

{
  "refresh": "<refresh_token>",
  "access": "<access_token>",
  "user": {
    "id": 1,
    "username": "johndoe",
    "email": "john@example.com"
  }
}

Logout

POST /auth/logout/

Request:

{
  "refresh": "<refresh_token>"
}


Response:

{"detail": "Successfully logged out"}

👤 Users
Get Current User

GET /users/me/

Response:

{
  "id": 1,
  "username": "johndoe",
  "email": "john@example.com"
}

Update Current User

PUT /users/me/

Request:

{
  "username": "newname",
  "first_name": "John",
  "last_name": "Doe"
}


Response:

{
  "id": 1,
  "username": "newname",
  "email": "john@example.com",
  "first_name": "John",
  "last_name": "Doe"
}

Delete Current User

DELETE /users/me/

Response:

{"detail": "User deleted"}

🎬 Movies API
Trending Movies

GET /api/v1/movies/trending_movies/

Response:

[
  {"id": 1, "title": "Interstellar", "poster_path": "/gEU2QniE6.jpg"},
  {"id": 2, "title": "Superman", "poster_path": "/abc123.jpg"}
]

Top Rated Movies

GET /api/v1/movies/top_rated_movies/

Search Movies

GET /api/v1/movies/search_movies/?q=batman

Retrieve Movie

GET /api/v1/movies/{id}/retrieve_movie/

Movie Recommendations

GET /api/v1/movies/{id}/movie_recommendations/

📺 TV Shows API
Trending TV

GET /api/v1/movies/trending_tv/

Search TV

GET /api/v1/movies/search_tv/?q=breaking+bad

Retrieve TV

GET /api/v1/movies/{id}/retrieve_tv/

TV Recommendations

GET /api/v1/movies/{id}/tv_recommendations/

⭐ Favorites
Add Favorite

POST /api/v1/movies/{id}/add_favorite/?type=movie

Remove Favorite

DELETE /api/v1/movies/{id}/remove_favorite/

My Favorites

GET /api/v1/movies/my_favorites/

📌 Watchlist
Add to Watchlist

POST /api/v1/movies/{id}/add_watchlist/?type=movie

Remove from Watchlist

DELETE /api/v1/movies/{id}/remove_watchlist/

My Watchlist

GET /api/v1/movies/my_watchlist/

📝 Reviews
Add Review

POST /api/v1/movies/{id}/add_review/?type=movie

Request:

{
  "review_text": "Amazing movie!",
  "rating": 5
}

Get Reviews

GET /api/v1/movies/{id}/reviews/?type=movie

⚠️ Error Handling

All errors follow this format:

{"detail": "Error message here"}


Examples:

Missing q parameter → 400 Bad Request

Invalid token → 401 Unauthorized

Not found → 404 Not Found

🛠️ Developer Notes

Framework: Django + DRF

Auth: JWT via djangorestframework-simplejwt

DB: PostgreSQL

Async tasks: Celery + Redis (for scheduled caching, background jobs)

Caching: Movies and TV shows cached in DB (cache_ttl field)

Pagination: Custom paginator in movies/services/pagination.py

API Versioning: Current prefix → /api/v1/

📅 Roadmap

 Expose genres endpoint

 User profile pictures

 Like/Dislike reviews

 Full-text search with PostgreSQL

 OpenAPI/Swagger docs