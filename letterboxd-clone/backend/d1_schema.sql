-- SQL Schema for Cloudflare D1
-- This is the complete database schema for all apps

-- Users Table (Custom User Model)
CREATE TABLE IF NOT EXISTS users_user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    password VARCHAR(128) NOT NULL,
    last_login DATETIME,
    is_superuser BOOLEAN NOT NULL DEFAULT 0,
    username VARCHAR(150) NOT NULL UNIQUE,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
    email VARCHAR(254),
    is_staff BOOLEAN NOT NULL DEFAULT 0,
    is_active BOOLEAN NOT NULL DEFAULT 1,
    date_joined DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    bio TEXT,
    profile_image VARCHAR(200)
);

-- User Groups (Django auth system)
CREATE TABLE IF NOT EXISTS auth_group (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(150) NOT NULL UNIQUE
);

-- User Permissions
CREATE TABLE IF NOT EXISTS auth_permission (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    content_type_id INTEGER NOT NULL,
    codename VARCHAR(100) NOT NULL
);

-- User-Group relationship
CREATE TABLE IF NOT EXISTS users_user_groups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    group_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users_user(id) ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES auth_group(id) ON DELETE CASCADE,
    UNIQUE(user_id, group_id)
);

-- User-Permission relationship
CREATE TABLE IF NOT EXISTS users_user_user_permissions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    permission_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users_user(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES auth_permission(id) ON DELETE CASCADE,
    UNIQUE(user_id, permission_id)
);

-- Movie Cache Table
CREATE TABLE IF NOT EXISTS movies_moviecache (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    movie_id INTEGER NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    poster_path VARCHAR(255),
    overview TEXT,
    release_date VARCHAR(50),
    vote_average REAL DEFAULT 0,
    data TEXT,  -- JSON data stored as text
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Reviews Table
CREATE TABLE IF NOT EXISTS reviews_review (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    movie_id INTEGER NOT NULL,
    rating INTEGER NOT NULL CHECK(rating >= 1 AND rating <= 5),
    review_text TEXT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users_user(id) ON DELETE CASCADE,
    UNIQUE(user_id, movie_id)
);

-- Watched Movies Table
CREATE TABLE IF NOT EXISTS reviews_watched (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    movie_id INTEGER NOT NULL,
    watched_date DATE NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users_user(id) ON DELETE CASCADE,
    UNIQUE(user_id, movie_id)
);

-- Review Likes Table
CREATE TABLE IF NOT EXISTS reviews_reviewlike (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    review_id INTEGER NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users_user(id) ON DELETE CASCADE,
    FOREIGN KEY (review_id) REFERENCES reviews_review(id) ON DELETE CASCADE,
    UNIQUE(user_id, review_id)
);

-- Django Migrations Table
CREATE TABLE IF NOT EXISTS django_migrations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    app VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    applied DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Django Content Types
CREATE TABLE IF NOT EXISTS django_content_type (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    app_label VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    UNIQUE(app_label, model)
);

-- Django Sessions
CREATE TABLE IF NOT EXISTS django_session (
    session_key VARCHAR(40) PRIMARY KEY,
    session_data TEXT NOT NULL,
    expire_date DATETIME NOT NULL
);

-- Indexes for better performance
CREATE INDEX IF NOT EXISTS idx_users_username ON users_user(username);
CREATE INDEX IF NOT EXISTS idx_users_email ON users_user(email);
CREATE INDEX IF NOT EXISTS idx_movies_movie_id ON movies_moviecache(movie_id);
CREATE INDEX IF NOT EXISTS idx_reviews_user_id ON reviews_review(user_id);
CREATE INDEX IF NOT EXISTS idx_reviews_movie_id ON reviews_review(movie_id);
CREATE INDEX IF NOT EXISTS idx_watched_user_id ON reviews_watched(user_id);
CREATE INDEX IF NOT EXISTS idx_watched_movie_id ON reviews_watched(movie_id);
CREATE INDEX IF NOT EXISTS idx_reviewlike_review_id ON reviews_reviewlike(review_id);
CREATE INDEX IF NOT EXISTS idx_session_expire_date ON django_session(expire_date);

-- Insert initial migration records
INSERT INTO django_migrations (app, name, applied) VALUES
('contenttypes', '0001_initial', CURRENT_TIMESTAMP),
('auth', '0001_initial', CURRENT_TIMESTAMP),
('users', '0001_initial', CURRENT_TIMESTAMP),
('movies', '0001_initial', CURRENT_TIMESTAMP),
('reviews', '0001_initial', CURRENT_TIMESTAMP);
