import os

# Create all necessary directories
dirs = [
    'letterboxd-clone/backend/config',
    'letterboxd-clone/backend/users',
    'letterboxd-clone/backend/movies',
    'letterboxd-clone/backend/reviews',
    'letterboxd-clone/backend/recommendations',
    'letterboxd-clone/frontend/src/components',
    'letterboxd-clone/frontend/src/pages',
    'letterboxd-clone/frontend/src/context',
    'letterboxd-clone/frontend/src/utils',
    'letterboxd-clone/frontend/public',
]

for dir_path in dirs:
    os.makedirs(dir_path, exist_ok=True)
    print(f'Created: {dir_path}')

print('\nAll directories created successfully!')
