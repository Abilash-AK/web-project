# Letterboxd Clone - Complete Application Code

## IMPORTANT: Setup Instructions

### Step 1: Create Directory Structure
Run ONE of these commands in your terminal (choose based on your system):

**Windows (Command Prompt):**
```cmd
cd "E:\web project"
mkdir letterboxd-clone\backend\config letterboxd-clone\backend\users letterboxd-clone\backend\movies letterboxd-clone\backend\reviews letterboxd-clone\backend\recommendations letterboxd-clone\frontend\src\components letterboxd-clone\frontend\src\pages letterboxd-clone\frontend\src\context letterboxd-clone\frontend\src\utils letterboxd-clone\frontend\public
```

**Windows (PowerShell):**
```powershell
cd "E:\web project"
New-Item -ItemType Directory -Path letterboxd-clone\backend\config -Force
New-Item -ItemType Directory -Path letterboxd-clone\backend\users -Force
New-Item -ItemType Directory -Path letterboxd-clone\backend\movies -Force
New-Item -ItemType Directory -Path letterboxd-clone\backend\reviews -Force
New-Item -ItemType Directory -Path letterboxd-clone\backend\recommendations -Force
New-Item -ItemType Directory -Path letterboxd-clone\frontend\src\components -Force
New-Item -ItemType Directory -Path letterboxd-clone\frontend\src\pages -Force
New-Item -ItemType Directory -Path letterboxd-clone\frontend\src\context -Force
New-Item -ItemType Directory -Path letterboxd-clone\frontend\src\utils -Force
New-Item -ItemType Directory -Path letterboxd-clone\frontend\public -Force
```

**Using Python:**
```cmd
python -c "import os; [os.makedirs(d, exist_ok=True) for d in ['letterboxd-clone/backend/config', 'letterboxd-clone/backend/users', 'letterboxd-clone/backend/movies', 'letterboxd-clone/backend/reviews', 'letterboxd-clone/backend/recommendations', 'letterboxd-clone/frontend/src/components', 'letterboxd-clone/frontend/src/pages', 'letterboxd-clone/frontend/src/context', 'letterboxd-clone/frontend/src/utils', 'letterboxd-clone/frontend/public']]"
```

### Step 2: Follow the file creation instructions below

---

## Project Structure

```
letterboxd-clone/
├── backend/
│   ├── config/
│   │   ├── __init__.py
│   │   ├── settings.py
│   │   ├── urls.py
│   │   ├── asgi.py
│   │   └── wsgi.py
│   ├── users/
│   │   ├── __init__.py
│   │   ├── models.py
│   │   ├── serializers.py
│   │   ├── views.py
│   │   ├── urls.py
│   │   └── admin.py
│   ├── movies/
│   │   ├── __init__.py
│   │   ├── models.py
│   │   ├── serializers.py
│   │   ├── views.py
│   │   ├── urls.py
│   │   ├── admin.py
│   │   └── tmdb_service.py
│   ├── reviews/
│   │   ├── __init__.py
│   │   ├── models.py
│   │   ├── serializers.py
│   │   ├── views.py
│   │   ├── urls.py
│   │   └── admin.py
│   ├── recommendations/
│   │   ├── __init__.py
│   │   ├── views.py
│   │   ├── urls.py
│   │   └── recommendation_engine.py
│   ├── manage.py
│   ├── requirements.txt
│   ├── .env.example
│   ├── wrangler.toml
│   └── README.md
└── frontend/
    ├── src/
    │   ├── components/
    │   │   ├── Navbar.jsx
    │   │   ├── Footer.jsx
    │   │   ├── MovieCard.jsx
    │   │   ├── ReviewCard.jsx
    │   │   ├── RatingStars.jsx
    │   │   ├── LoginForm.jsx
    │   │   ├── RegisterForm.jsx
    │   │   └── ReviewForm.jsx
    │   ├── pages/
    │   │   ├── Home.jsx
    │   │   ├── MovieDetail.jsx
    │   │   ├── Profile.jsx
    │   │   ├── Search.jsx
    │   │   ├── Login.jsx
    │   │   └── Register.jsx
    │   ├── context/
    │   │   ├── AuthContext.jsx
    │   │   └── ApiContext.jsx
    │   ├── utils/
    │   │   ├── axios.js
    │   │   └── ProtectedRoute.jsx
    │   ├── App.jsx
    │   ├── main.jsx
    │   └── index.css
    ├── public/
    │   └── _redirects
    ├── index.html
    ├── package.json
    ├── vite.config.js
    ├── tailwind.config.js
    ├── postcss.config.js
    ├── .env.example
    ├── wrangler.toml
    └── README.md
```

---

##  COMPLETE FILE CONTENTS BELOW

This document contains the COMPLETE source code for all files.
After creating the directory structure (Step 1 above), create each file with the content provided.

