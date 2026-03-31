import subprocess
import sys
import os
import time
from pathlib import Path

def run_command(cmd, cwd=None, shell=True):
    """Run a command and return success status"""
    print(f"\n> {cmd}")
    result = subprocess.run(cmd, shell=shell, cwd=cwd)
    return result.returncode == 0

def main():
    base_dir = Path(__file__).parent
    backend_dir = base_dir / "letterboxd-clone" / "backend"
    frontend_dir = base_dir / "letterboxd-clone" / "frontend"
    
    print("=" * 70)
    print("  🎬 LETTERBOXD CLONE - BUILD & RUN")
    print("=" * 70)
    
    # Check if venv exists
    venv_path = backend_dir / "venv"
    if not venv_path.exists():
        print("\n[STEP 1/5] Creating virtual environment...")
        if not run_command("python -m venv venv", cwd=backend_dir):
            print("❌ Failed to create virtual environment")
            return False
        print("✅ Virtual environment created")
    else:
        print("\n[STEP 1/5] Virtual environment exists, skipping...")
    
    # Install backend dependencies
    pip_exe = backend_dir / "venv" / "Scripts" / "pip.exe"
    requirements = backend_dir / "requirements.txt"
    print("\n[STEP 2/5] Installing backend dependencies...")
    if not run_command(f'"{pip_exe}" install -r "{requirements}"', cwd=backend_dir):
        print("❌ Failed to install backend dependencies")
        return False
    print("✅ Backend dependencies installed")
    
    # Run migrations
    python_exe = backend_dir / "venv" / "Scripts" / "python.exe"
    manage_py = backend_dir / "manage.py"
    print("\n[STEP 3/5] Running database migrations...")
    run_command(f'"{python_exe}" "{manage_py}" makemigrations', cwd=backend_dir)
    if not run_command(f'"{python_exe}" "{manage_py}" migrate', cwd=backend_dir):
        print("❌ Migration failed")
        return False
    print("✅ Database ready")
    
    # Install frontend dependencies
    node_modules = frontend_dir / "node_modules"
    if not node_modules.exists():
        print("\n[STEP 4/5] Installing frontend dependencies...")
        if not run_command("npm install", cwd=frontend_dir):
            print("❌ Failed to install frontend dependencies")
            return False
        print("✅ Frontend dependencies installed")
    else:
        print("\n[STEP 4/5] Frontend dependencies exist, skipping...")
    
    # Start servers
    print("\n[STEP 5/5] Starting servers...")
    print("\n" + "=" * 70)
    print("  ✅ SETUP COMPLETE! Starting servers...")
    print("=" * 70)
    print("\n  Backend:  http://localhost:8000")
    print("  Frontend: http://localhost:5173")
    print("\n  Press Ctrl+C to stop both servers")
    print("=" * 70 + "\n")
    
    # Start backend in subprocess
    backend_cmd = f'"{python_exe}" "{manage_py}" runserver'
    backend_proc = subprocess.Popen(backend_cmd, shell=True, cwd=backend_dir)
    
    # Give backend time to start
    time.sleep(3)
    
    # Start frontend in subprocess
    frontend_cmd = "npm run dev"
    frontend_proc = subprocess.Popen(frontend_cmd, shell=True, cwd=frontend_dir)
    
    try:
        # Wait for both processes
        backend_proc.wait()
        frontend_proc.wait()
    except KeyboardInterrupt:
        print("\n\nStopping servers...")
        backend_proc.terminate()
        frontend_proc.terminate()
        backend_proc.wait()
        frontend_proc.wait()
        print("Servers stopped.")
    
    return True

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
