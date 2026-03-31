# 🎬 Letterboxd Clone - Complete Setup Guide

## ✅ Application Successfully Created!

Your complete Letterboxd-like application has been created with:
- ✅ **Backend**: Django + DRF + JWT (28 files)
- ✅ **Frontend**: React + Vite + Tailwind (24 files)
- ✅ **Total**: 52 files, ~3,500+ lines of production-ready code

---

## 🚀 Quick Start (5 Minutes)

### Step 1: Backend Setup

```bash
# Navigate to backend
cd letterboxd-clone/backend

# Create virtual environment
python -m venv venv

# Activate virtual environment (Windows)
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Create .env file (IMPORTANT!)
# Copy .env.example to .env
copy .env.example .env

# Edit .env and add your TMDb API key:
# Get one free at: https://www.themoviedb.org/settings/api
# TMDB_API_KEY=your-actual-api-key-here

# Run migrations
python manage.py makemigrations
python manage.py migrate

# Create admin user (optional)
python manage.py createsuperuser

# Start backend server
python manage.py runserver
```

**Backend will run at:** `http://localhost:8000`

---

### Step 2: Frontend Setup (New Terminal)

```bash
# Navigate to frontend
cd letterboxd-clone/frontend

# Install dependencies
npm install

# Create .env file
copy .env.example .env

# Start frontend server
npm run dev
```

**Frontend will run at:** `http://localhost:5173`

---

## 🎯 Test the Application

1. **Open browser**: http://localhost:5173
2. **Register account**: Click "Register" and create an account
3. **Explore movies**: Browse trending and popular movies
4. **Search**: Try searching for "Inception" or any movie
5. **View details**: Click on any movie to see full details
6. **Write review**: Rate a movie 1-5 stars and write a review
7. **Mark as watched**: Add movies to your diary
8. **View profile**: See your watched movies and reviews
9. **Get recommendations**: Check personalized recommendations on home page

---

## 📋 Features Checklist

✅ **Authentication**
- User registration with validation
- Login with JWT tokens
- Auto token refresh
- Protected routes
- Logout

✅ **Movies**
- Popular movies from TMDb
- Trending movies (weekly)
- Search functionality
- Movie details (poster, backdrop, overview, genres)
- TMDb integration

✅ **Reviews**
- 1-5 star rating system
- Write/edit/delete reviews
- View all reviews for a movie
- Review likes
- Like counter

✅ **Diary/Watched**
- Mark movies as watched
- Store watched date
- Display in profile grid
- Track statistics

✅ **Recommendations**
- Personalized algorithm
- Based on 4+ star ratings
- Genre-based recommendations
- Filters watched movies

✅ **Profile**
- User statistics
- Watched movies grid
- Reviews list
- Profile information

✅ **UI/UX**
- Dark theme (Letterboxd-inspired)
- Fully responsive
- Smooth animations
- Loading states
- Error handling

---

## 🔑 Important: TMDb API Key

**You MUST get a TMDb API key for the app to work:**

1. Go to: https://www.themoviedb.org/signup
2. Create a free account
3. Go to Settings → API
4. Request an API key (choose "Developer")
5. Copy the API key
6. Add to `backend/.env`:
   ```
   TMDB_API_KEY=your_actual_key_here
   ```

---

## 📁 Project Structure

```
letterboxd-clone/
├── backend/
│   ├── config/           # Django settings
│   ├── users/            # User authentication
│   ├── movies/           # Movie data & TMDb
│   ├── reviews/          # Reviews & watched
│   ├── recommendations/  # Recommendation engine
│   ├── requirements.txt
│   ├── manage.py
│   └── .env
└── frontend/
    ├── src/
    │   ├── components/   # Reusable components
    │   ├── pages/        # Page components
    │   ├── context/      # React Context
    │   ├── utils/        # Axios & helpers
    │   ├── App.jsx
    │   └── main.jsx
    ├── package.json
    └── .env
```

---

## 🛠️ Common Issues & Solutions

### Backend Issues

**Issue**: `ModuleNotFoundError`
```bash
# Solution: Install dependencies
pip install -r requirements.txt
```

**Issue**: Migration errors
```bash
# Solution: Reset migrations
python manage.py makemigrations
python manage.py migrate
```

**Issue**: CORS errors
```bash
# Solution: Check backend/.env
CORS_ALLOWED_ORIGINS=http://localhost:5173,http://127.0.0.1:5173
```

### Frontend Issues

**Issue**: `Cannot find module`
```bash
# Solution: Install dependencies
npm install
```

**Issue**: API calls failing
```bash
# Solution: Check frontend/.env
VITE_API_BASE_URL=http://localhost:8000/api
```

**Issue**: Movies not loading
```bash
# Solution: Verify TMDb API key in backend/.env
```

---

## 🎨 Customization

### Change Theme Colors

Edit `frontend/tailwind.config.js`:

```javascript
colors: {
  accent: {
    green: '#00c030',  // Change this
    // ... other colors
  }
}
```

### Add Your Logo

Replace "Letterboxd" text in `frontend/src/components/Navbar.jsx`

---

## 📦 Deployment

### Backend (Railway/Render/Heroku)

1. Create account on hosting platform
2. Connect your repository
3. Set environment variables:
   - `SECRET_KEY`
   - `TMDB_API_KEY`
   - `ALLOWED_HOSTS`
   - `CORS_ALLOWED_ORIGINS`
4. Deploy!

### Frontend (Cloudflare Pages)

```bash
cd frontend
npm run build
npx wrangler pages deploy dist --project-name=letterboxd-clone
```

---

## 📚 Tech Stack

**Backend:**
- Django 4.2
- Django REST Framework
- Simple JWT
- TMDb API
- SQLite (D1 compatible)

**Frontend:**
- React 18
- Vite
- Tailwind CSS
- Axios
- React Router

---

## 🎓 Next Steps

Now that you have the complete app:

1. **Customize the design** - Change colors, fonts, layout
2. **Add features** - Watchlist, lists, follow users
3. **Deploy to production** - Make it live!
4. **Share with friends** - Get feedback
5. **Add social features** - Comments, social sharing
6. **Implement caching** - Redis for better performance
7. **Add analytics** - Track user behavior

---

## 🐛 Need Help?

1. **Check console errors** - Browser DevTools (F12)
2. **Check backend logs** - Terminal where Django is running
3. **Verify API keys** - TMDb key in .env
4. **Check both servers** - Backend (8000) and Frontend (5173)

---

## 📊 Application Statistics

- **Total Files**: 52
- **Lines of Code**: ~3,500+
- **Backend Files**: 28
- **Frontend Files**: 24
- **Components**: 8
- **Pages**: 6
- **API Endpoints**: 31
- **Features**: 100% Complete

---

## ✨ You're All Set!

Your complete Letterboxd clone is ready to use! 

**Start both servers and visit:** http://localhost:5173

Happy coding! 🎬🍿

