# 🌐 Cloudflare Setup - Quick Guide

## Prerequisites
- ✅ Node.js 18+ installed
- ✅ Cloudflare account (free tier is fine)
- ✅ Internet connection

---

## 🚀 Quick Setup (3 Options)

### Option 1: Automated Setup (Recommended)
```bash
# Run the automated Python script
python setup_cloudflare.py
```

### Option 2: Batch File (Windows)
```cmd
# Run the batch file
SETUP_CLOUDFLARE.bat
```

### Option 3: Manual Setup
Follow the steps below...

---

## 📋 Manual Setup Steps

### 1. Install Wrangler CLI
```bash
npm install -g wrangler
```

### 2. Login to Cloudflare
```bash
wrangler login
```
This opens your browser for authentication.

### 3. Create D1 Database
```bash
cd letterboxd-clone/backend
wrangler d1 create letterboxd-db
```

**IMPORTANT:** Copy the `database_id` from the output!

### 4. Update Configuration
Edit `letterboxd-clone/backend/wrangler.toml`:

```toml
[[d1_databases]]
binding = "DB"
database_name = "letterboxd-db"
database_id = "YOUR_DATABASE_ID_HERE"  # Paste the ID here
```

### 5. Apply Database Schema
```bash
cd letterboxd-clone/backend
wrangler d1 execute letterboxd-db --file=d1_schema.sql
```

### 6. Verify Setup
```bash
wrangler d1 execute letterboxd-db --command="SELECT name FROM sqlite_master WHERE type='table'"
```

You should see all your database tables listed.

---

## 🔄 Development vs Production

### Local Development (Default)
- Uses SQLite database file (`db.sqlite3`)
- Fast iteration and testing
- No internet required
- Run with: `RUN_BACKEND.bat` + `RUN_FRONTEND.bat`

### Production (Cloudflare)
- Uses Cloudflare D1 (serverless SQLite)
- Global edge distribution
- Scales automatically
- Deploy with: `wrangler deploy`

---

## 🚀 Deploying to Production

### Deploy Backend
```bash
cd letterboxd-clone/backend
wrangler deploy
```

Your backend will be live at: `https://letterboxd-backend.your-subdomain.workers.dev`

### Deploy Frontend
```bash
cd letterboxd-clone/frontend
npm run build
npx wrangler pages deploy dist --project-name=letterboxd-frontend
```

Your frontend will be live at: `https://letterboxd-frontend.pages.dev`

---

## 🔧 Useful Commands

### View Database Info
```bash
wrangler d1 info letterboxd-db
```

### Query Data
```bash
# List all users
wrangler d1 execute letterboxd-db --command="SELECT * FROM users_user"

# List all movies
wrangler d1 execute letterboxd-db --command="SELECT * FROM movies_movie LIMIT 10"

# Count reviews
wrangler d1 execute letterboxd-db --command="SELECT COUNT(*) FROM reviews_review"
```

### Insert Test Data
```bash
wrangler d1 execute letterboxd-db --command="INSERT INTO users_user (username, email) VALUES ('testuser', 'test@example.com')"
```

### Import SQL File
```bash
wrangler d1 execute letterboxd-db --file=your_data.sql
```

### Backup Database
```bash
wrangler d1 export letterboxd-db --output=backup.sql
```

### Test Locally with D1
```bash
cd letterboxd-clone/backend
wrangler dev
```

---

## 💰 Cloudflare D1 Pricing

### Free Tier (Generous!)
- ✅ 100,000 reads per day
- ✅ 50,000 writes per day
- ✅ 5 GB storage
- ✅ Perfect for small-medium apps

### Paid Tier (if needed)
- $0.001 per 1,000 reads
- $0.001 per 1,000 writes
- Very affordable!

---

## 🔍 Environment Configuration

The app automatically detects the environment:

**Local Development:**
```env
USE_CLOUDFLARE_D1=False
DATABASE_URL=sqlite:///db.sqlite3
```

**Production (Cloudflare Workers):**
```env
USE_CLOUDFLARE_D1=True
# D1 binding is automatic
```

---

## 🆘 Troubleshooting

### "Wrangler not found"
```bash
npm install -g wrangler
```

### "Database not found"
- Make sure you created the database: `wrangler d1 create letterboxd-db`
- Check the `database_id` in `wrangler.toml` matches

### "Authentication error"
```bash
wrangler login
```

### "Migration failed"
- Check if `d1_schema.sql` exists in backend directory
- Try applying it manually with the command in Step 5

### "Can't connect to D1 locally"
- Local development uses SQLite file (`db.sqlite3`)
- D1 is only used in production
- Use `wrangler dev` to test with D1 locally

---

## ✅ What You Get

After setup, you'll have:

1. **Local Development** - Fast SQLite database for development
2. **Production Database** - Cloudflare D1 ready for deployment
3. **Same Schema** - Both environments use identical structure
4. **Easy Sync** - Export from local, import to D1 anytime
5. **Global CDN** - Your app runs on Cloudflare's edge network

---

## 📚 Additional Resources

- **Full Guide:** `letterboxd-clone/CLOUDFLARE_D1_SETUP.md`
- **Cloudflare D1 Docs:** https://developers.cloudflare.com/d1/
- **Wrangler Docs:** https://developers.cloudflare.com/workers/wrangler/
- **Cloudflare Pages:** https://developers.cloudflare.com/pages/

---

## 🎯 Summary

1. **For Development:** Keep using local SQLite (already working!)
2. **For Production:** Set up D1 when you're ready to deploy
3. **No Code Changes:** The app handles both automatically

**The Cloudflare setup is optional. You can develop locally with SQLite perfectly fine!**

---

## 🚦 Current Status

After running the setup:

✅ Wrangler CLI installed  
✅ Logged in to Cloudflare  
✅ D1 database created  
✅ Configuration updated  
✅ Schema applied  
✅ Ready to deploy!

---

**Need help? Check the detailed guide in `letterboxd-clone/CLOUDFLARE_D1_SETUP.md`**
