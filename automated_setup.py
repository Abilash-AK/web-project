import subprocess
import os
import sys

def run_command(cmd, cwd=None, shell=True):
    """Run a command and return the result"""
    print(f"\n▶ Running: {cmd}")
    try:
        result = subprocess.run(
            cmd,
            cwd=cwd,
            shell=shell,
            capture_output=True,
            text=True,
            timeout=300
        )
        if result.stdout:
            print(result.stdout)
        if result.stderr and result.returncode != 0:
            print(f"ERROR: {result.stderr}")
        return result.returncode == 0
    except Exception as e:
        print(f"ERROR: {e}")
        return False

print("=" * 60)
print("  🎬 LETTERBOXD CLONE - AUTOMATED SETUP")
print("=" * 60)

base_dir = os.path.dirname(os.path.abspath(__file__))
backend_dir = os.path.join(base_dir, "letterboxd-clone", "backend")
frontend_dir = os.path.join(base_dir, "letterboxd-clone", "frontend")

# BACKEND SETUP
print("\n" + "=" * 60)
print("  STEP 1: BACKEND SETUP")
print("=" * 60)

print("\n[1/6] Creating virtual environment...")
if run_command("python -m venv venv", cwd=backend_dir):
    print("✓ Virtual environment created")
else:
    print("✗ Failed to create virtual environment")
    sys.exit(1)

print("\n[2/6] Installing backend dependencies...")
venv_python = os.path.join(backend_dir, "venv", "Scripts", "python.exe")
venv_pip = os.path.join(backend_dir, "venv", "Scripts", "pip.exe")

if run_command(f'"{venv_pip}" install -r requirements.txt', cwd=backend_dir):
    print("✓ Backend dependencies installed")
else:
    print("✗ Failed to install dependencies")
    sys.exit(1)

print("\n[3/6] Creating .env file...")
env_example = os.path.join(backend_dir, ".env.example")
env_file = os.path.join(backend_dir, ".env")
if not os.path.exists(env_file):
    import shutil
    shutil.copy(env_example, env_file)
    print("✓ .env file created")
    print("\n⚠️  IMPORTANT: You need to add your TMDb API key to backend/.env")
    print("   Get one free at: https://www.themoviedb.org/settings/api")
else:
    print("✓ .env file already exists")

print("\n[4/6] Running database migrations...")
if run_command(f'"{venv_python}" manage.py makemigrations', cwd=backend_dir):
    print("✓ Migrations created")
else:
    print("⚠ No migrations needed or error occurred")

if run_command(f'"{venv_python}" manage.py migrate', cwd=backend_dir):
    print("✓ Database migrated")
else:
    print("✗ Migration failed")
    sys.exit(1)

print("\n✓ Backend setup complete!")

# FRONTEND SETUP
print("\n" + "=" * 60)
print("  STEP 2: FRONTEND SETUP")
print("=" * 60)

print("\n[1/3] Installing frontend dependencies...")
if run_command("npm install", cwd=frontend_dir):
    print("✓ Frontend dependencies installed")
else:
    print("✗ Failed to install frontend dependencies")
    sys.exit(1)

print("\n[2/3] Creating .env file...")
env_example_front = os.path.join(frontend_dir, ".env.example")
env_file_front = os.path.join(frontend_dir, ".env")
if not os.path.exists(env_file_front):
    import shutil
    shutil.copy(env_example_front, env_file_front)
    print("✓ .env file created")
else:
    print("✓ .env file already exists")

print("\n✓ Frontend setup complete!")

print("\n" + "=" * 60)
print("  ✅ SETUP COMPLETE!")
print("=" * 60)

print("\n📝 NEXT STEPS:")
print("\n1. Add your TMDb API key:")
print(f"   Edit: {env_file}")
print("   Add: TMDB_API_KEY=your_actual_key_here")
print("\n2. Start the servers:")
print("   Backend:  python run_servers.py backend")
print("   Frontend: python run_servers.py frontend")
print("\n3. Open browser: http://localhost:5173")
print("\n" + "=" * 60)
