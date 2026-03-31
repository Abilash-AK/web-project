# ===========================================
# COMPLETE SETUP AND DEPLOYMENT GUIDE
# ===========================================

# Letterboxd Clone - Full-Stack Application
# Complete Production-Ready Implementation

## 📋 TABLE OF CONTENTS
1. Project Overview
2. Prerequisites
3. File Structure Setup
4. Backend Setup
5. Frontend Setup
6. Running the Application
7. Deployment to Cloudflare
8. API Documentation
9. Features Checklist
10. Troubleshooting

---

## 1. PROJECT OVERVIEW

A full-featured Letterboxd-like movie tracking and review platform built with:
- **Frontend**: React (JavaScript), Vite, Tailwind CSS
- **Backend**: Django, Django REST Framework, JWT Authentication
- **Database**: SQLite (compatible with Cloudflare D1)
- **Movie Data**: TMDb API integration
- **Deployment**: Cloudflare Pages (frontend) + Cloudflare Workers (backend)

---

## 2. PREREQUISITES

Before starting, ensure you have:

- **Python 3.9+** installed
- **Node.js 18+** and npm installed
- **Git** (optional, for version control)
- **TMDb API Key** (get free at https://www.themoviedb.org/settings/api)
- **Cloudflare Account** (for deployment, free tier available)

---

## 3. FILE STRUCTURE SETUP

### Step 1: Create Directory Structure

**Option A: Using Python (Recommended)**
```bash
cd "E:\web project"
python -c "import os; [os.makedirs(d, exist_ok=True) for d in ['letterboxd-clone/backend/config', 'letterboxd-clone/backend/users', 'letterboxd-clone/backend/movies', 'letterboxd-clone/backend/reviews', 'letterboxd-clone/backend/recommendations', 'letterboxd-clone/frontend/src/components', 'letterboxd-clone/frontend/src/pages', 'letterboxd-clone/frontend/src/context', 'letterboxd-clone/frontend/src/utils', 'letterboxd-clone/frontend/public']]"
```

**Option B: Manual Creation (Windows)**
```cmd
cd "E:\web project"
mkdir letterboxd-clone\backend\config
mkdir letterboxd-clone\backend\users
mkdir letterboxd-clone\backend\movies
mkdir letterboxd-clone\backend\reviews
mkdir letterboxd-clone\backend\recommendations
mkdir letterboxd-clone\frontend\src\components
mkdir letterboxd-clone\frontend\src\pages
mkdir letterboxd-clone\frontend\src\context
mkdir letterboxd-clone\frontend\src\utils
mkdir letterboxd-clone\frontend\public
```

### Step 2: Copy All Code Files

You now need to create all the code files from the provided code parts:

1. **COMPLETE_CODE_PART1_BACKEND_CONFIG.txt** - Backend configuration files
2. **COMPLETE_CODE_PART2_BACKEND_APPS.txt** - Users and Movies apps
3. **COMPLETE_CODE_PART3_BACKEND_REVIEWS_RECS.txt** - Reviews and Recommendations
4. **COMPLETE_CODE_PART4_FRONTEND_CONFIG.txt** - Frontend config and utilities
5. **COMPLETE_CODE_PART5_FRONTEND_CONTEXT.txt** - React Context providers
6. **COMPLETE_CODE_PART6_FRONTEND_COMPONENTS.txt** - React Components
7. **COMPLETE_CODE_PART7_FRONTEND_PAGES_1.txt** - Login, Register, Home, Search pages
8. **COMPLETE_CODE_PART8_FRONTEND_PAGES_2.txt** - MovieDetail and Profile pages

Each file in these documents is clearly marked with:
```
# ============================================
# File: path/to/file.ext
# ============================================
[file content]
```

Create each file in the corresponding location with its content.

---

## 4. BACKEND SETUP

### Step 1: Navigate to Backend Directory
```bash
cd letterboxd-clone/backend
```

### Step 2: Create Virtual Environment
```bash
python -m venv venv
```

### Step 3: Activate Virtual Environment
**Windows:**
```bash
venv\Scripts\activate
```

**macOS/Linux:**
```bash
source venv/bin/activate
```

### Step 4: Install Dependencies
```bash
pip install -r requirements.txt
```

### Step 5: Create .env File
Create a `.env` file in the backend directory:

```env
DEBUG=True
SECRET_KEY=django-insecure-your-super-secret-key-change-this-in-production
ALLOWED_HOSTS=localhost,127.0.0.1
CORS_ALLOWED_ORIGINS=http://localhost:5173,http://127.0.0.1:5173
TMDB_API_KEY=YOUR_TMDB_API_KEY_HERE
DATABASE_URL=sqlite:///db.sqlite3
```

**IMPORTANT:** Replace `YOUR_TMDB_API_KEY_HERE` with your actual TMDb API key!

### Step 6: Initialize Database
```bash
python manage.py makemigrations
python manage.py migrate
```

### Step 7: Create Superuser (Optional)
```bash
python manage.py createsuperuser
```

### Step 8: Run Development Server
```bash
python manage.py runserver
```

Backend should now be running at: **http://localhost:8000**

---

## 5. FRONTEND SETUP

### Step 1: Navigate to Frontend Directory
```bash
cd ../frontend
```

### Step 2: Install Dependencies
```bash
npm install
```

### Step 3: Create .env File
Create a `.env` file in the frontend directory:

```env
VITE_API_BASE_URL=http://localhost:8000/api
VITE_TMDB_IMAGE_BASE_URL=https://image.tmdb.org/t/p
```

### Step 4: Run Development Server
```bash
npm run dev
```

Frontend should now be running at: **http://localhost:5173**

---

## 6. RUNNING THE APPLICATION

### Development Mode

1. **Terminal 1** (Backend):
```bash
cd letterboxd-clone/backend
venv\Scripts\activate
python manage.py runserver
```

2. **Terminal 2** (Frontend):
```bash
cd letterboxd-clone/frontend
npm run dev
```

3. **Open Browser**: Navigate to http://localhost:5173

### First-Time Setup Steps

1. **Register a new account** at http://localhost:5173/register
2. **Login** with your credentials
3. **Browse movies** on the home page
4. **Search** for your favorite movies
5. **Click on a movie** to see details
6. **Write a review** and rate the movie
7. **Mark as watched** to add to your diary
8. **View your profile** to see watched movies and reviews

---

## 7. DEPLOYMENT TO CLOUDFLARE

### Backend Deployment (Cloudflare Workers)

**Note**: Deploying Django to Cloudflare Workers requires additional setup as it's not natively supported. Consider these alternatives:

**Option 1: Use Cloudflare Pages Functions**
- Deploy backend as a separate service (Railway, Render, Heroku, etc.)
- Update frontend VITE_API_BASE_URL to point to production backend

**Option 2: Traditional VPS/Cloud Hosting**
- Deploy Django to DigitalOcean, AWS, GCP, or Azure
- Use Cloudflare as CDN and DNS

### Frontend Deployment (Cloudflare Pages)

1. **Build the frontend**:
```bash
cd letterboxd-clone/frontend
npm run build
```

2. **Install Wrangler CLI**:
```bash
npm install -g wrangler
```

3. **Login to Cloudflare**:
```bash
wrangler login
```

4. **Deploy to Cloudflare Pages**:
```bash
wrangler pages deploy dist --project-name=letterboxd-clone
```

5. **Set Environment Variables** in Cloudflare Dashboard:
   - Go to Pages > Your Project > Settings > Environment Variables
   - Add: `VITE_API_BASE_URL` with your production backend URL

---

## 8. API DOCUMENTATION

### Authentication Endpoints

**Register User**
```
POST /api/auth/register/
Body: {
  "username": "string",
  "email": "string",
  "password": "string",
  "password2": "string"
}
```

**Login**
```
POST /api/auth/login/
Body: {
  "username": "string",
  "password": "string"
}
Response: {
  "access": "jwt_token",
  "refresh": "refresh_token"
}
```

**Get Profile**
```
GET /api/auth/profile/
Headers: Authorization: Bearer {access_token}
```

### Movie Endpoints

**Get Popular Movies**
```
GET /api/movies/popular/?page=1
```

**Get Trending Movies**
```
GET /api/movies/trending/
```

**Search Movies**
```
GET /api/movies/search/?q=inception&page=1
```

**Get Movie Details**
```
GET /api/movies/{movie_id}/
```

### Review Endpoints

**Create Review**
```
POST /api/reviews/
Headers: Authorization: Bearer {access_token}
Body: {
  "movie_id": 123,
  "rating": 5,
  "review_text": "Great movie!"
}
```

**Get Reviews for Movie**
```
GET /api/reviews/?movie_id=123
```

**Update Review**
```
PATCH /api/reviews/{review_id}/
Headers: Authorization: Bearer {access_token}
Body: {
  "rating": 4,
  "review_text": "Updated review"
}
```

**Delete Review**
```
DELETE /api/reviews/{review_id}/
Headers: Authorization: Bearer {access_token}
```

**Like Review**
```
POST /api/reviews/{review_id}/like/
Headers: Authorization: Bearer {access_token}
```

### Watched/Diary Endpoints

**Mark as Watched**
```
POST /api/reviews/watched/
Headers: Authorization: Bearer {access_token}
Body: {
  "movie_id": 123,
  "watched_date": "2024-01-15"
}
```

**Get Watched Movies**
```
GET /api/reviews/watched/?username=john
```

### Recommendation Endpoints

**Get Personalized Recommendations**
```
GET /api/recommendations/
Headers: Authorization: Bearer {access_token}
```

**Get Similar Movies**
```
GET /api/recommendations/similar/{movie_id}/
```

---

## 9. FEATURES CHECKLIST

✅ **Authentication System**
- User registration
- Login with JWT tokens
- Token refresh
- Logout
- Password validation

✅ **Movie Integration**
- TMDb API integration
- Popular movies display
- Trending movies
- Search functionality
- Movie details with poster, backdrop, genres

✅ **Rating & Review System**
- 1-5 star rating
- Write reviews
- Edit reviews
- Delete reviews
- View all reviews for a movie

✅ **Watched/Diary System**
- Mark movies as watched
- Store watched date
- Display in profile as diary grid

✅ **Recommendation System**
- Algorithm based on user's 4+ star ratings
- Genre extraction from favorite movies
- TMDb discover API integration
- Personalized movie suggestions

✅ **User Profile**
- View watched movies grid
- Display all reviews
- User statistics (total watched, total reviews)
- Profile customization support

✅ **Search Functionality**
- Real-time movie search
- Search results grid display
- Query parameter routing

✅ **UI/UX Features**
- Dark theme (Letterboxd-inspired)
- Responsive design
- Smooth hover effects
- Loading states
- Error handling
- Grid layouts for movies

✅ **Additional Features**
- Review likes system
- Similar movies suggestions
- Movie backdrop images
- Star rating component
- Protected routes
- JWT auto-refresh

---

## 10. TROUBLESHOOTING

### Backend Issues

**Issue**: `ModuleNotFoundError: No module named 'rest_framework'`
**Solution**: 
```bash
pip install -r requirements.txt
```

**Issue**: Database migrations not applying
**Solution**:
```bash
python manage.py makemigrations --empty users
python manage.py makemigrations --empty movies
python manage.py makemigrations --empty reviews
python manage.py makemigrations
python manage.py migrate
```

**Issue**: CORS errors in browser
**Solution**: Verify `CORS_ALLOWED_ORIGINS` in `.env` includes `http://localhost:5173`

**Issue**: TMDb API not working
**Solution**: Verify `TMDB_API_KEY` in `.env` is correct

### Frontend Issues

**Issue**: `Cannot find module 'axios'`
**Solution**:
```bash
npm install
```

**Issue**: API calls failing
**Solution**: Verify backend is running on port 8000 and `VITE_API_BASE_URL` is correct

**Issue**: Authentication not persisting
**Solution**: Check browser console for localStorage errors, ensure JWT tokens are being saved

**Issue**: Images not loading
**Solution**: Verify TMDb images are accessible, check VITE_TMDB_IMAGE_BASE_URL

### General Issues

**Issue**: Port already in use
**Solution**: 
- Backend: Use `python manage.py runserver 8001`
- Frontend: Update vite.config.js server port

**Issue**: Virtual environment not activating
**Solution**: Delete `venv` folder and recreate:
```bash
python -m venv venv
```

---

## 🎉 SUCCESS!

Your Letterboxd clone is now fully functional! Here's what you can do:

1. **Browse** trending and popular movies
2. **Search** for any movie
3. **Rate** movies from 1-5 stars
4. **Write** detailed reviews
5. **Track** watched movies in your diary
6. **Get** personalized recommendations
7. **Like** other users' reviews
8. **View** your profile and statistics

## 🚀 Next Steps

- Customize the dark theme colors in `tailwind.config.js`
- Add more features (watchlist, follow users, lists)
- Set up production database (PostgreSQL, MySQL)
- Deploy to production
- Add social sharing features
- Implement movie lists/collections
- Add advanced filtering and sorting

## 📚 Additional Resources

- **Django Docs**: https://docs.djangoproject.com/
- **React Docs**: https://react.dev/
- **Tailwind CSS**: https://tailwindcss.com/
- **TMDb API**: https://developers.themoviedb.org/3
- **Cloudflare Pages**: https://developers.cloudflare.com/pages/

---

**Built with ❤️ using React, Django, and Tailwind CSS**

