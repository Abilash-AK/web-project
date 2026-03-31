"""
Cloudflare D1 Setup Script for Letterboxd Clone
This script helps you set up Cloudflare D1 database and deploy to Cloudflare Workers
"""

import subprocess
import sys
import os
import json
import re
from pathlib import Path

def run_command(cmd, cwd=None, shell=True, capture_output=True):
    """Run a command and return success status and output"""
    print(f"\n> {cmd}")
    try:
        result = subprocess.run(
            cmd, 
            shell=shell, 
            cwd=cwd, 
            capture_output=capture_output,
            text=True
        )
        if capture_output:
            print(result.stdout)
            if result.stderr:
                print(result.stderr)
        return result.returncode == 0, result.stdout if capture_output else ""
    except Exception as e:
        print(f"❌ Error: {e}")
        return False, ""

def check_wrangler():
    """Check if Wrangler is installed"""
    success, output = run_command("wrangler --version")
    if success:
        print(f"✅ Wrangler is installed: {output.strip()}")
        return True
    else:
        print("❌ Wrangler is not installed")
        return False

def install_wrangler():
    """Install Wrangler globally"""
    print("\n📦 Installing Wrangler CLI...")
    success, _ = run_command("npm install -g wrangler")
    if success:
        print("✅ Wrangler installed successfully")
        return True
    else:
        print("❌ Failed to install Wrangler")
        return False

def login_cloudflare():
    """Login to Cloudflare"""
    print("\n🔐 Logging in to Cloudflare...")
    print("This will open a browser window for authentication.")
    input("Press Enter to continue...")
    
    success, _ = run_command("wrangler login", capture_output=False)
    if success:
        print("✅ Successfully logged in to Cloudflare")
        return True
    else:
        print("❌ Failed to login to Cloudflare")
        return False

def create_d1_database(backend_dir):
    """Create Cloudflare D1 database"""
    print("\n📊 Creating Cloudflare D1 database...")
    success, output = run_command(
        "wrangler d1 create letterboxd-db",
        cwd=backend_dir
    )
    
    if success:
        # Extract database_id from output
        match = re.search(r'database_id\s*=\s*"([^"]+)"', output)
        if match:
            database_id = match.group(1)
            print(f"✅ Database created successfully!")
            print(f"   Database ID: {database_id}")
            return database_id
        else:
            print("⚠️ Database created but couldn't extract ID")
            print("Please copy the database_id from the output above")
            database_id = input("Enter database_id: ").strip()
            return database_id
    else:
        print("❌ Failed to create D1 database")
        return None

def update_wrangler_toml(backend_dir, database_id):
    """Update wrangler.toml with database_id"""
    wrangler_path = backend_dir / "wrangler.toml"
    
    print(f"\n📝 Updating {wrangler_path}...")
    
    try:
        with open(wrangler_path, 'r') as f:
            content = f.read()
        
        # Replace empty database_id with actual ID
        updated_content = re.sub(
            r'database_id\s*=\s*""',
            f'database_id = "{database_id}"',
            content
        )
        
        with open(wrangler_path, 'w') as f:
            f.write(updated_content)
        
        print("✅ wrangler.toml updated successfully")
        return True
    except Exception as e:
        print(f"❌ Failed to update wrangler.toml: {e}")
        return False

def apply_migrations(backend_dir):
    """Apply database schema to D1"""
    schema_file = backend_dir / "d1_schema.sql"
    
    print(f"\n🔄 Applying database schema to D1...")
    
    if not schema_file.exists():
        print(f"❌ Schema file not found: {schema_file}")
        return False
    
    success, _ = run_command(
        f'wrangler d1 execute letterboxd-db --file="{schema_file}"',
        cwd=backend_dir
    )
    
    if success:
        print("✅ Database schema applied successfully")
        return True
    else:
        print("❌ Failed to apply database schema")
        return False

def verify_d1_database(backend_dir):
    """Verify D1 database by listing tables"""
    print("\n🔍 Verifying D1 database...")
    
    success, output = run_command(
        'wrangler d1 execute letterboxd-db --command="SELECT name FROM sqlite_master WHERE type=\'table\'"',
        cwd=backend_dir
    )
    
    if success:
        print("✅ Database verified! Tables found:")
        print(output)
        return True
    else:
        print("❌ Failed to verify database")
        return False

def deploy_backend(backend_dir):
    """Deploy backend to Cloudflare Workers"""
    print("\n🚀 Deploying backend to Cloudflare Workers...")
    
    success, output = run_command(
        "wrangler deploy",
        cwd=backend_dir,
        capture_output=False
    )
    
    if success:
        print("✅ Backend deployed successfully!")
        return True
    else:
        print("❌ Failed to deploy backend")
        return False

def deploy_frontend(frontend_dir):
    """Deploy frontend to Cloudflare Pages"""
    print("\n🚀 Building and deploying frontend to Cloudflare Pages...")
    
    # Build frontend
    print("Building frontend...")
    success, _ = run_command("npm run build", cwd=frontend_dir)
    if not success:
        print("❌ Failed to build frontend")
        return False
    
    # Deploy to Pages
    print("Deploying to Cloudflare Pages...")
    success, _ = run_command(
        "npx wrangler pages deploy dist --project-name=letterboxd-frontend",
        cwd=frontend_dir,
        capture_output=False
    )
    
    if success:
        print("✅ Frontend deployed successfully!")
        return True
    else:
        print("❌ Failed to deploy frontend")
        return False

def main():
    print("=" * 70)
    print("  🌐 CLOUDFLARE D1 SETUP - LETTERBOXD CLONE")
    print("=" * 70)
    
    base_dir = Path(__file__).parent
    backend_dir = base_dir / "letterboxd-clone" / "backend"
    frontend_dir = base_dir / "letterboxd-clone" / "frontend"
    
    # Check if directories exist
    if not backend_dir.exists():
        print(f"❌ Backend directory not found: {backend_dir}")
        return False
    
    if not frontend_dir.exists():
        print(f"❌ Frontend directory not found: {frontend_dir}")
        return False
    
    print("\n📋 This script will:")
    print("  1. Install/verify Wrangler CLI")
    print("  2. Login to Cloudflare")
    print("  3. Create D1 database")
    print("  4. Update configuration")
    print("  5. Apply database schema")
    print("  6. Optionally deploy to production")
    print()
    
    choice = input("Continue? (y/n): ").strip().lower()
    if choice != 'y':
        print("Setup cancelled.")
        return False
    
    # Step 1: Check/Install Wrangler
    if not check_wrangler():
        install = input("\nWrangler not found. Install it now? (y/n): ").strip().lower()
        if install == 'y':
            if not install_wrangler():
                return False
        else:
            print("Wrangler is required. Please install it manually:")
            print("  npm install -g wrangler")
            return False
    
    # Step 2: Login to Cloudflare
    if not login_cloudflare():
        retry = input("\nLogin failed. Try again? (y/n): ").strip().lower()
        if retry == 'y':
            if not login_cloudflare():
                return False
        else:
            return False
    
    # Step 3: Create D1 Database
    print("\n" + "=" * 70)
    create = input("\nCreate new D1 database? (y/n): ").strip().lower()
    if create == 'y':
        database_id = create_d1_database(backend_dir)
        if not database_id:
            return False
        
        # Step 4: Update wrangler.toml
        if not update_wrangler_toml(backend_dir, database_id):
            return False
    else:
        database_id = input("Enter existing database_id: ").strip()
        if database_id:
            update_wrangler_toml(backend_dir, database_id)
    
    # Step 5: Apply migrations
    print("\n" + "=" * 70)
    migrate = input("\nApply database schema to D1? (y/n): ").strip().lower()
    if migrate == 'y':
        if not apply_migrations(backend_dir):
            print("⚠️ Migration failed, but you can try manually later")
        else:
            verify_d1_database(backend_dir)
    
    # Step 6: Deploy to production (optional)
    print("\n" + "=" * 70)
    print("\n✅ D1 DATABASE SETUP COMPLETE!")
    print("\n" + "=" * 70)
    
    deploy = input("\nDeploy to Cloudflare now? (y/n): ").strip().lower()
    if deploy == 'y':
        # Deploy backend
        backend = input("Deploy backend? (y/n): ").strip().lower()
        if backend == 'y':
            deploy_backend(backend_dir)
        
        # Deploy frontend
        frontend = input("Deploy frontend? (y/n): ").strip().lower()
        if frontend == 'y':
            # Check if node_modules exists
            if not (frontend_dir / "node_modules").exists():
                print("\nInstalling frontend dependencies first...")
                run_command("npm install", cwd=frontend_dir, capture_output=False)
            deploy_frontend(frontend_dir)
    
    print("\n" + "=" * 70)
    print("  ✅ CLOUDFLARE SETUP COMPLETE!")
    print("=" * 70)
    print("\n📝 NEXT STEPS:")
    print("  • For local development: Use SQLite (db.sqlite3)")
    print("  • For production: Your app now uses D1!")
    print("\n🔧 USEFUL COMMANDS:")
    print("  • View D1 data: wrangler d1 execute letterboxd-db --command='SELECT * FROM users_user'")
    print("  • Deploy backend: wrangler deploy (in backend dir)")
    print("  • Deploy frontend: wrangler pages deploy dist (in frontend dir)")
    print("\n📚 Documentation: letterboxd-clone/CLOUDFLARE_D1_SETUP.md")
    print("=" * 70)
    
    return True

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
