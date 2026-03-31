# 🔧 DATABASE & ENVIRONMENT CONFIGURATION GUIDE

## ✅ CURRENT STATUS

Good news! Your environment files are **already configured correctly** for local development!

---

## 📋 BACKEND ENVIRONMENT (.env) - EXPLAINED

**File location:** `letterboxd-clone/backend/.env`

### Current Configuration:

```env
DEBUG=True                                                    ✅ CONFIGURED
SECRET_KEY=your-secret-key-here-change-in-production         ⚠️ NEEDS UPDATE (for production)
ALLOWED_HOSTS=localhost,127.0.0.1                             ✅ CONFIGURED
CORS_ALLOWED_ORIGINS=http://localhost:5173,http://127.0.0.1:5173  ✅ CONFIGURED
TMDB_API_KEY=84a89fcc39a773de3f318a81abfa3a70               ✅ CONFIGURED
DATABASE_URL=sqlite:///db.sqlite3                             ✅ CONFIGURED
```

### What Each Value Means:

| Variable | Purpose | Current Value | Status |
|----------|---------|---------------|--------|
| **DEBUG** | Enable Django debug mode | `True` | ✅ Perfect for development |
| **SECRET_KEY** | Django security key for sessions/cookies | Default | ⚠️ Change for production |
| **ALLOWED_HOSTS** | Which domains can access backend | localhost | ✅ Good for local dev |
| **CORS_ALLOWED_ORIGINS** | Which frontend URLs are allowed | localhost:5173 | ✅ Matches Vite port |
| **TMDB_API_KEY** | Your TMDb API key | Your key | ✅ Already configured! |
| **DATABASE_URL** | Database connection string | SQLite file | ✅ Will auto-create |

---

## 🗄️ DATABASE SETUP

### Current Configuration: SQLite (Local File Database)

Your app is configured to use **SQLite** - a file-based database perfect for development.

**Database location:** `letterboxd-clone/backend/db.sqlite3`

### How It Works:

1. **No installation needed** - SQLite is built into Python
2. **Auto-created** - The database file is created automatically when you run migrations
3. **No credentials needed** - Just a file path

### To Initialize the Database:

Run these commands:
```bash
cd letterboxd-clone/backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
python manage.py makemigrations
python manage.py migrate
```

This creates:
- `db.sqlite3` - Your database file
- All tables: Users, Reviews, Watched, MovieCache, ReviewLike

---

## 🔄 SWITCHING TO DIFFERENT DATABASES (OPTIONAL)

If you want to use a different database instead of SQLite:

### Option 1: PostgreSQL
```env
DATABASE_URL=postgresql://username:password@localhost:5432/letterboxd_db
```

### Option 2: MySQL
```env
DATABASE_URL=mysql://username:password@localhost:3306/letterboxd_db
```

### Option 3: Cloudflare D1 (Production)
For Cloudflare D1, you'll need to:
1. Create a D1 database in Cloudflare dashboard
2. Use the D1 binding in wrangler.toml
3. Deploy to Cloudflare Workers

---

## 🎨 FRONTEND ENVIRONMENT (.env) - EXPLAINED

**File location:** `letterboxd-clone/frontend/.env`

```env
VITE_API_BASE_URL=http://localhost:8000/api              ✅ CONFIGURED
VITE_TMDB_IMAGE_BASE_URL=https://image.tmdb.org/t/p      ✅ CONFIGURED
```

### What Each Value Means:

| Variable | Purpose | Current Value | Status |
|----------|---------|---------------|--------|
| **VITE_API_BASE_URL** | Backend API endpoint | localhost:8000/api | ✅ Matches Django port |
| **VITE_TMDB_IMAGE_BASE_URL** | TMDb image CDN | TMDb's official URL | ✅ Correct |

**Note:** Vite requires `VITE_` prefix for environment variables!

---

## ✅ YOUR CONFIGURATION IS READY!

### What's Already Set Up:

✅ TMDb API key configured  
✅ Database configured (SQLite)  
✅ CORS configured for localhost  
✅ Frontend pointing to correct backend  
✅ All ports configured correctly  

### What Happens When You Run:

1. **Backend starts** on `http://localhost:8000`
2. **Frontend starts** on `http://localhost:5173`
3. **Database auto-creates** at `letterboxd-clone/backend/db.sqlite3`
4. **Movies fetched** from TMDb API using your key

---

## 🚀 READY TO RUN!

Your environment is **100% configured**. Just run:

```bash
cd "E:\web project"
START_WEBSITE.bat
```

Or manually:

**Terminal 1 - Backend:**
```bash
cd letterboxd-clone/backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

**Terminal 2 - Frontend:**
```bash
cd letterboxd-clone/frontend
npm install
npm run dev
```

---

## 🔐 FOR PRODUCTION DEPLOYMENT

When you're ready to deploy, update these:

### Backend .env (Production):
```env
DEBUG=False
SECRET_KEY=generate-a-secure-random-key-here
ALLOWED_HOSTS=your-domain.com,www.your-domain.com
CORS_ALLOWED_ORIGINS=https://your-domain.com
TMDB_API_KEY=84a89fcc39a773de3f318a81abfa3a70
DATABASE_URL=postgresql://user:pass@host:5432/dbname
```

### Frontend .env (Production):
```env
VITE_API_BASE_URL=https://your-api-domain.com/api
VITE_TMDB_IMAGE_BASE_URL=https://image.tmdb.org/t/p
```

---

## 📝 SUMMARY

**For local development (NOW):**
- ✅ Everything is already configured
- ✅ Just run the setup script
- ✅ Database will auto-create

**Database file:** `db.sqlite3` (auto-created in backend folder)  
**No additional setup needed!** 🎉

---

## 🆘 TROUBLESHOOTING

### "TMDb API not working"
- Check your API key is correct in backend/.env
- Test it: https://api.themoviedb.org/3/movie/550?api_key=YOUR_KEY

### "Database errors"
- Delete `db.sqlite3` and run `python manage.py migrate` again

### "CORS errors"
- Make sure backend is running on port 8000
- Make sure frontend is running on port 5173
- Check CORS_ALLOWED_ORIGINS in backend/.env

### "Frontend can't connect to backend"
- Make sure VITE_API_BASE_URL matches backend URL
- Check both servers are running
- Clear browser cache

---

**You're all set! Run `START_WEBSITE.bat` now!** 🚀
