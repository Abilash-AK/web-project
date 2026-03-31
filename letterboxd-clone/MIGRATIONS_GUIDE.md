# 🗄️ DATABASE MIGRATIONS GUIDE

## ✅ Migration Files Created!

I've created all the required Django migration files:

### Created Migration Files:
- ✅ `users/migrations/0001_initial.py` - User model migration
- ✅ `movies/migrations/0001_initial.py` - MovieCache migration  
- ✅ `reviews/migrations/0001_initial.py` - Review, Watched, ReviewLike migrations
- ✅ `d1_schema.sql` - Complete SQL schema for Cloudflare D1

---

## 📋 Database Schema Overview

### Tables Created:

1. **users_user** - Custom user model with bio and profile_image
2. **movies_moviecache** - Cache for movie data from TMDb
3. **reviews_review** - User reviews with ratings (1-5)
4. **reviews_watched** - Movies marked as watched by users
5. **reviews_reviewlike** - Likes on reviews
6. **auth_group** - Django groups
7. **auth_permission** - Django permissions
8. **django_migrations** - Migration tracking
9. **django_content_type** - Content types
10. **django_session** - Session storage

---

## 🚀 How to Apply Migrations

### Option 1: Local Development (SQLite)

```bash
cd letterboxd-clone/backend

# Create virtual environment (if not done)
python -m venv venv
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Apply migrations
python manage.py migrate
```

**This will:**
- Create `db.sqlite3` file
- Create all tables automatically
- Ready to use immediately!

---

### Option 2: Cloudflare D1 (Production)

**Step 1: Create D1 Database**
```bash
wrangler d1 create letterboxd-db
```

**Step 2: Update wrangler.toml**
Copy the `database_id` from output to `wrangler.toml`

**Step 3: Apply Schema**
```bash
cd letterboxd-clone/backend
wrangler d1 execute letterboxd-db --file=d1_schema.sql
```

**Verify:**
```bash
wrangler d1 execute letterboxd-db --command="SELECT name FROM sqlite_master WHERE type='table'"
```

---

## 🔍 What Each Migration Does

### users/migrations/0001_initial.py
Creates the custom User model with:
- Standard Django auth fields (username, email, password, etc.)
- Custom fields: `bio`, `profile_image`
- Relationships: groups, permissions

### movies/migrations/0001_initial.py
Creates MovieCache model for caching TMDb data:
- `movie_id` - Unique TMDb movie ID
- `title`, `poster_path`, `overview` - Movie details
- `data` - Full JSON response from TMDb
- `created_at`, `updated_at` - Timestamps

### reviews/migrations/0001_initial.py
Creates three models:

1. **Review**
   - User's rating (1-5) and review text
   - Unique constraint: One review per user per movie
   
2. **Watched**
   - Track when user watched a movie
   - Unique constraint: One entry per user per movie
   
3. **ReviewLike**
   - Users can like reviews
   - Unique constraint: One like per user per review

---

## 🔧 Migration Commands Reference

### Check Migration Status
```bash
python manage.py showmigrations
```

### Create New Migrations (after model changes)
```bash
python manage.py makemigrations
```

### Apply Migrations
```bash
python manage.py migrate
```

### Rollback to Specific Migration
```bash
python manage.py migrate users 0001
```

### View SQL for Migration
```bash
python manage.py sqlmigrate users 0001
```

---

## 🗃️ Database Schema Diagram

```
┌──────────────┐
│  users_user  │
└──────┬───────┘
       │
       ├─────────────────────────────┐
       │                             │
       ▼                             ▼
┌──────────────┐            ┌──────────────┐
│reviews_review│            │reviews_watched│
└──────┬───────┘            └──────────────┘
       │
       ▼
┌────────────────┐
│reviews_reviewlike│
└────────────────┘

┌────────────────┐
│movies_moviecache│ (Independent - caches TMDb data)
└────────────────┘
```

---

## 📊 Sample Data Queries

### Create a User
```sql
INSERT INTO users_user (username, email, password, is_staff, is_active, date_joined)
VALUES ('testuser', 'test@example.com', 'hashed_password', 0, 1, CURRENT_TIMESTAMP);
```

### Add a Review
```sql
INSERT INTO reviews_review (user_id, movie_id, rating, review_text, created_at, updated_at)
VALUES (1, 550, 5, 'Amazing movie!', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
```

### Mark Movie as Watched
```sql
INSERT INTO reviews_watched (user_id, movie_id, watched_date, created_at)
VALUES (1, 550, '2024-01-15', CURRENT_TIMESTAMP);
```

### Cache a Movie
```sql
INSERT INTO movies_moviecache (movie_id, title, poster_path, overview, release_date, vote_average, data, created_at, updated_at)
VALUES (550, 'Fight Club', '/path.jpg', 'Description...', '1999-10-15', 8.4, '{}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
```

---

## ✅ Migration Files Are Ready!

You can now:

1. **For Local Development:**
   ```bash
   cd letterboxd-clone/backend
   venv\Scripts\activate
   python manage.py migrate
   ```

2. **For Cloudflare D1:**
   ```bash
   wrangler d1 execute letterboxd-db --file=d1_schema.sql
   ```

Both approaches will create the exact same database structure! 🎉

---

## 🆘 Troubleshooting

### "No migrations to apply"
- ✅ This is fine! It means migrations are already applied.

### "table already exists"
- Delete `db.sqlite3` and run `migrate` again
- For D1: Drop and recreate the database

### "FOREIGN KEY constraint failed"
- Make sure to create users before reviews/watched entries
- Check that referenced IDs exist

---

**Your database schema is complete and ready to use!** 🚀
