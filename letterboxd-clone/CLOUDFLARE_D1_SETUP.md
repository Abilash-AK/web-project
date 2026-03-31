# 🌐 CLOUDFLARE D1 DATABASE SETUP GUIDE

## 📋 What is Cloudflare D1?

Cloudflare D1 is a serverless SQLite database that runs on Cloudflare's edge network:
- ✅ SQLite-based (same as our local development)
- ✅ Globally distributed
- ✅ Serverless (no server management)
- ✅ Pay-per-use pricing
- ✅ Free tier available (100,000 reads/day, 50,000 writes/day)

---

## 🚀 STEP-BY-STEP SETUP

### Step 1: Install Wrangler CLI

```bash
npm install -g wrangler
```

### Step 2: Login to Cloudflare

```bash
wrangler login
```

This opens a browser to authenticate with your Cloudflare account.

### Step 3: Create D1 Database

```bash
cd letterboxd-clone/backend
wrangler d1 create letterboxd-db
```

**Output will look like:**
```
✅ Successfully created DB 'letterboxd-db'!

[[d1_databases]]
binding = "DB"
database_name = "letterboxd-db"
database_id = "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
```

**Copy the `database_id`** - you'll need it!

### Step 4: Update wrangler.toml

Edit `letterboxd-clone/backend/wrangler.toml` and add your database_id:

```toml
[[d1_databases]]
binding = "DB"
database_name = "letterboxd-db"
database_id = "a1b2c3d4-e5f6-7890-abcd-ef1234567890"  # <- Your actual ID here
```

### Step 5: Run Database Migrations on D1

First, generate SQL from Django migrations:

```bash
cd letterboxd-clone/backend
venv\Scripts\activate
python manage.py sqlmigrate users 0001 > d1_schema.sql
python manage.py sqlmigrate movies 0001 >> d1_schema.sql
python manage.py sqlmigrate reviews 0001 >> d1_schema.sql
```

Then apply to D1:

```bash
wrangler d1 execute letterboxd-db --file=d1_schema.sql
```

Or run migrations directly:

```bash
# Export schema
python manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 2 > db_backup.json

# Then use Wrangler to execute SQL commands
wrangler d1 execute letterboxd-db --command="CREATE TABLE IF NOT EXISTS users_user (...);"
```

### Step 6: Update Your Backend Configuration

Your `backend/.env` is already configured to use SQLite locally and D1 in production!

**Local Development:**
```env
DATABASE_URL=sqlite:///db.sqlite3
USE_CLOUDFLARE_D1=False
```

**Production (Cloudflare Workers):**
```env
USE_CLOUDFLARE_D1=True
```

---

## 🔄 DEVELOPMENT WORKFLOW

### Local Development (Current Setup)
```bash
# Uses local SQLite database
cd letterboxd-clone/backend
venv\Scripts\activate
python manage.py runserver
```

**Database location:** `db.sqlite3` (local file)

### Testing with D1 Remotely
```bash
# Execute queries on D1
wrangler d1 execute letterboxd-db --command="SELECT * FROM users_user LIMIT 5"

# Run local preview with D1
wrangler dev
```

### Production Deployment
```bash
# Deploy to Cloudflare Workers with D1
wrangler deploy
```

---

## 📊 DATABASE OPERATIONS

### View D1 Database Info
```bash
wrangler d1 info letterboxd-db
```

### List All Tables
```bash
wrangler d1 execute letterboxd-db --command="SELECT name FROM sqlite_master WHERE type='table'"
```

### Query Data
```bash
wrangler d1 execute letterboxd-db --command="SELECT * FROM users_user"
```

### Insert Data
```bash
wrangler d1 execute letterboxd-db --command="INSERT INTO users_user (username, email) VALUES ('test', 'test@example.com')"
```

### Import SQL File
```bash
wrangler d1 execute letterboxd-db --file=migrations.sql
```

### Backup Database
```bash
wrangler d1 export letterboxd-db --output=backup.sql
```

---

## 🏗️ MIGRATION STRATEGY

Since D1 is SQLite-based, you can:

### Option 1: Use Django Migrations Locally, Then Sync to D1

```bash
# 1. Run migrations locally
python manage.py makemigrations
python manage.py migrate

# 2. Export schema
sqlite3 db.sqlite3 .dump > schema.sql

# 3. Apply to D1
wrangler d1 execute letterboxd-db --file=schema.sql
```

### Option 2: Generate SQL and Apply Directly

```bash
# Generate SQL for all apps
python manage.py sqlmigrate users 0001 > all_migrations.sql
python manage.py sqlmigrate movies 0001 >> all_migrations.sql
python manage.py sqlmigrate reviews 0001 >> all_migrations.sql
python manage.py sqlmigrate recommendations 0001 >> all_migrations.sql

# Apply to D1
wrangler d1 execute letterboxd-db --file=all_migrations.sql
```

---

## 🌍 DEPLOYMENT TO CLOUDFLARE WORKERS

### Update Backend Settings for Production

The app is already configured! When deployed to Cloudflare Workers:

1. **D1 binding** automatically connects to your database
2. **No connection string needed** - Workers use bindings
3. **Environment variables** from wrangler.toml are used

### Deploy Backend

```bash
cd letterboxd-clone/backend
wrangler deploy
```

### Deploy Frontend to Cloudflare Pages

```bash
cd letterboxd-clone/frontend
npm run build
npx wrangler pages deploy dist --project-name=letterboxd-frontend
```

---

## 💰 PRICING (Free Tier)

Cloudflare D1 Free Tier:
- ✅ **100,000 reads per day**
- ✅ **50,000 writes per day**
- ✅ **5 GB storage**
- ✅ Perfect for small to medium apps!

Paid tier if you need more:
- $0.001 per 1,000 reads
- $0.001 per 1,000 writes

---

## 🔧 CURRENT SETUP STATUS

✅ **wrangler.toml** - Updated with D1 configuration  
✅ **Backend .env** - Configured for local SQLite + D1 production  
⏳ **Need to create D1 database** - Run `wrangler d1 create letterboxd-db`  
⏳ **Need to update database_id** - Copy from creation output to wrangler.toml  
⏳ **Need to run migrations** - Apply schema to D1  

---

## 🚀 QUICK START (Cloudflare D1)

```bash
# 1. Install Wrangler
npm install -g wrangler

# 2. Login
wrangler login

# 3. Create database
cd letterboxd-clone/backend
wrangler d1 create letterboxd-db

# 4. Copy database_id to wrangler.toml

# 5. Set up local database (for development)
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
python manage.py migrate  # Creates local db.sqlite3

# 6. Generate schema and apply to D1
python manage.py sqlmigrate users 0001 > schema.sql
python manage.py sqlmigrate movies 0001 >> schema.sql
python manage.py sqlmigrate reviews 0001 >> schema.sql
wrangler d1 execute letterboxd-db --file=schema.sql

# 7. Run locally (uses SQLite)
python manage.py runserver

# 8. Deploy to production (uses D1)
wrangler deploy
```

---

## 📝 IMPORTANT NOTES

### Development vs Production

| Environment | Database | Connection |
|-------------|----------|------------|
| **Local Dev** | SQLite file (`db.sqlite3`) | Direct file access |
| **Production** | Cloudflare D1 | Workers binding |

### Why This Approach?

1. **Local development** uses SQLite for fast iteration
2. **Production** uses D1 for global edge distribution
3. **Same SQL syntax** - easy to sync between environments
4. **No code changes** needed when deploying!

### Syncing Data

To sync local data to D1:

```bash
# Export local database
sqlite3 db.sqlite3 .dump > local_data.sql

# Import to D1
wrangler d1 execute letterboxd-db --file=local_data.sql
```

---

## ✅ YOUR NEXT STEPS

1. **Install Wrangler:** `npm install -g wrangler`
2. **Create D1 database:** `wrangler d1 create letterboxd-db`
3. **Update wrangler.toml** with the database_id
4. **For now, use local SQLite** for development (already working!)
5. **When ready to deploy,** migrate schema to D1

**Right now, you can develop locally with SQLite. D1 is for production deployment!** 🚀

---

## 🆘 TROUBLESHOOTING

### "Database not found"
- Make sure you created the D1 database: `wrangler d1 create letterboxd-db`
- Check the database_id in wrangler.toml matches

### "Migration errors"
- D1 uses SQLite, so standard Django migrations work
- Test migrations locally first, then apply to D1

### "Can't connect to D1 locally"
- Local development uses `db.sqlite3` (file)
- D1 is only used in production (Cloudflare Workers)
- Use `wrangler dev` to test with D1 locally

---

**For local development right now: Just use SQLite (it's already configured!)** 🎯
