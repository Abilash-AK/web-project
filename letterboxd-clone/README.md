# 🎬 Letterboxd Clone

A full-stack web application inspired by Letterboxd. Discover movies, write reviews, rate them, track your watch history, and get personalized recommendations.

---

## ✨ Features & Architecture

This project is divided into a **React (Vite) Frontend** and a **Django REST Framework Backend**. Below is a detailed breakdown of the features and the **critical files** where the magic happens.

### 1. Movie Discovery & TMDb Caching
Instead of only relying on live third-party API calls, the backend fetches data from The Movie Database (TMDb) and intelligently caches it locally to speed up future requests and provide local relational mapping for reviews.
*   **Feature:** Trending, popular, and search-based movie discovery.
*   **Important Code:** `backend/movies/views.py` (`_upsert_cache` function).
    *   *Why it's special:* Aggressively bulk-inserting data from TMDb into a local SQLite database causes severe concurrent write-locks (`sqlite3.OperationalError: database is locked`). This file uses Django's `transaction.atomic()` to group inserts and implements silent `try/except` fallbacks to gracefully drop duplicate writes rather than crashing the server.

### 2. Concurrency Control (SQLite Optimizations)
Because SQLite is a single file, aggressive simultaneous requests from the frontend can crash a standard deployment. We implemented safety nets on both ends.
*   **Important Code (Backend):** `backend/config/settings.py`
    *   *Why it's special:* Dynamically detects if the engine is SQLite and injects a custom `OPTIONS: {'timeout': 20}` dictionary to force Django to wait patiently during database locks instead of immediately failing.
*   **Important Code (Frontend):** `frontend/src/pages/Home.jsx`
    *   *Why it's special:* The frontend deliberately avoids `Promise.all()` when fetching the `trending` and `popular` lists simultaneously. By fetching them sequentially using standard `await`, it halves the concurrent load on the SQLite file, entirely eliminating 500 Server Errors.

### 3. Authentication & Security
Uses secure JSON Web Tokens (JWT) to maintain user sessions across the application without relying on stateful server cookies.
*   **Important Code (Frontend):** `frontend/src/context/AuthContext.jsx`
    *   *Why it's special:* Wraps the entire React application, providing global access to the current authenticated `user`. Automatically manages token storage and authorization headers via Axios interceptors.
*   **Important Code (Backend):** `backend/users/views.py` & `config/settings.py`
    *   *Why it's special:* Utilizes `rest_framework_simplejwt` for secure access/refresh token rotation.

### 4. Reviews, Ratings, and "Watched" Diary
Users can interact with movies by reviewing them, giving them a 1-5 star rating, or simply marking them as "watched".
*   **Important Code:** `backend/reviews/models.py` & `backend/reviews/views.py`
    *   *Why it's special:* Links Django's built-in `User` model to the local `MovieCache` model. Validates that ratings stay strictly within the 1-5 parameter scale. Includes custom API endpoints to filter reviews by a specific user to populate their personal diary page.

### 5. Automated Production Deployment
The backend was custom-tailored to deploy seamlessly onto Railway, utilizing proper WSGI configurations and release lifecycle hooks.
*   **Important Code:** `backend/Procfile`
    *   *Why it's special:* Contains the critical `release: python manage.py migrate --noinput` hook. This ensures that every time the app boots on Railway's ephemeral container system, it automatically recreates the database schema before it accepts web traffic. It also configures `gunicorn` as the production web server.
*   **Important Code:** `backend/requirements.txt`
    *   *Why it's special:* Explicitly pins `setuptools` to fix a major deployment bug where Python 3.13 removed `pkg_resources`, which previously broke `gunicorn` on modern cloud providers.

---

## ⚡ Quick Start (Local Development)

We created a custom PowerShell script to boot both servers simultaneously to save time.

### Automated Boot:
1. Open a terminal in the project root: `letterboxd-clone/`
2. Run the start script:
   ```powershell
   .\run_local.ps1
   ```
3. Two terminal windows will open covering both Django and Vite. Open your browser to **http://localhost:5173**.

---

### Manual Boot (If the script fails)

**Terminal 1 - Backend:**
```bash
cd letterboxd-clone/backend
# Activate your environment (e.g. .\.venv\Scripts\Activate)
python manage.py runserver
```

**Terminal 2 - Frontend:**
```bash
cd letterboxd-clone/frontend
npm run dev
```

---

## 🔑 CRITICAL: TMDb API Key

If movies are not loading, your TMDb credentials might be missing.
1. Visit: https://www.themoviedb.org/settings/api
2. Request a free API key.
3. Open `backend/.env` and add:
   ```env
   TMDB_API_KEY=your_key_here
   ```

## 🛠️ Project Structure
```text
letterboxd-clone/
├── run_local.ps1       # Custom 1-click startup script
├── backend/            # Django 4 Django REST Framework
│   ├── config/         # Routing, settings, SQLite timeout modifiers
│   ├── movies/         # TMDb integrations and cache transaction locks
│   ├── reviews/        # Relational models for user engagement
│   ├── Procfile        # Railway deployment configuration
│   └── requirements.txt# Dependencies (gunicorn, setuptools)
└── frontend/           # React + Vite (Port 5173)
    └── src/
        ├── components/ # Reusable UI pieces (MovieCards, Nav)
        ├── pages/      # Home, Profile, Movie details (Sequential fetching here)
        ├── context/    # JWT AuthContext
        └── utils/      # Axios base instance
```
