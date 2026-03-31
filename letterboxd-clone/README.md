# 🎬 QUICK START - Letterboxd Clone

## ⚡ 3-Minute Setup

### Terminal 1 - Backend:
```bash
cd letterboxd-clone/backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
copy .env.example .env
# Edit .env and add your TMDb API key!
python manage.py makemigrations
python manage.py migrate
python manage.py runserver
```

### Terminal 2 - Frontend:
```bash
cd letterboxd-clone/frontend
npm install
copy .env.example .env
npm run dev
```

### Open Browser:
**http://localhost:5173**

---

## 🔑 CRITICAL: Get TMDb API Key

1. Visit: https://www.themoviedb.org/settings/api
2. Request API key (free)
3. Add to `backend/.env`:
   ```
   TMDB_API_KEY=your_key_here
   ```

---

## ✅ Test Everything

1. Register account
2. Search for "Inception"
3. Click on a movie
4. Write a review (rate 1-5 stars)
5. Mark as watched
6. View your profile
7. Check recommendations

---

## 📁 What You Have

✅ 52 files created
✅ Complete Django backend (28 files)
✅ Complete React frontend (24 files)
✅ JWT authentication
✅ TMDb API integration
✅ Reviews & ratings (1-5 stars)
✅ Watched/diary system
✅ Personalized recommendations
✅ Dark theme UI
✅ Fully responsive

---

## 🚀 All Features Working

- ✅ User registration & login
- ✅ Browse popular/trending movies
- ✅ Search movies
- ✅ View movie details
- ✅ Write/edit/delete reviews
- ✅ Rate movies 1-5 stars
- ✅ Mark as watched
- ✅ View profile with diary
- ✅ Get personalized recommendations
- ✅ Like reviews
- ✅ User statistics

---

## 🎯 Project Structure

```
letterboxd-clone/
├── backend/          # Django + DRF + JWT
│   ├── config/       # Settings & URLs
│   ├── users/        # Authentication
│   ├── movies/       # TMDb integration
│   ├── reviews/      # Reviews & watched
│   └── recommendations/  # Recommendation engine
└── frontend/         # React + Vite + Tailwind
    └── src/
        ├── components/   # 8 components
        ├── pages/        # 6 pages
        ├── context/      # Auth & API
        └── utils/        # Axios setup
```

---

## 🛠️ Troubleshooting

**Movies not loading?**
→ Add TMDb API key to backend/.env

**Can't login?**
→ Check backend is running on port 8000

**Import errors?**
→ Run `pip install -r requirements.txt`

**Module not found (frontend)?**
→ Run `npm install`

---

## 📞 Quick Commands

**Backend:**
```bash
python manage.py runserver     # Start server
python manage.py createsuperuser  # Create admin
```

**Frontend:**
```bash
npm run dev      # Start dev server
npm run build    # Build for production
```

---

## 🎉 You're Done!

Complete Letterboxd clone built and ready!

**Next:** Open http://localhost:5173 and start using it! 🍿
