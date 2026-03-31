import os

# Base directory
base = r"E:\web project\letterboxd-clone\backend"

# Create migrations directories
apps = ['users', 'movies', 'reviews']
for app in apps:
    migrations_dir = os.path.join(base, app, 'migrations')
    os.makedirs(migrations_dir, exist_ok=True)
    print(f"✓ Created {migrations_dir}")

print("\n✓ All migrations directories created!")
