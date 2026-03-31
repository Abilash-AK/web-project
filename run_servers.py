import subprocess
import sys
import os

if len(sys.argv) < 2:
    print("Usage: python run_servers.py [backend|frontend]")
    sys.exit(1)

server_type = sys.argv[1].lower()
base_dir = os.path.dirname(os.path.abspath(__file__))

if server_type == "backend":
    backend_dir = os.path.join(base_dir, "letterboxd-clone", "backend")
    venv_python = os.path.join(backend_dir, "venv", "Scripts", "python.exe")
    
    print("=" * 60)
    print("  🚀 Starting Backend Server")
    print("=" * 60)
    print("\nServer will run at: http://localhost:8000")
    print("Press Ctrl+C to stop\n")
    
    os.chdir(backend_dir)
    subprocess.run([venv_python, "manage.py", "runserver"])

elif server_type == "frontend":
    frontend_dir = os.path.join(base_dir, "letterboxd-clone", "frontend")
    
    print("=" * 60)
    print("  🚀 Starting Frontend Server")
    print("=" * 60)
    print("\nServer will run at: http://localhost:5173")
    print("Press Ctrl+C to stop\n")
    
    os.chdir(frontend_dir)
    subprocess.run(["npm", "run", "dev"], shell=True)

else:
    print("Invalid option. Use 'backend' or 'frontend'")
    sys.exit(1)
