const fs = require('fs');
const path = require('path');

const dirs = [
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
];

dirs.forEach(dir => {
    fs.mkdirSync(dir, { recursive: true });
    console.log(`Created: ${dir}`);
});

console.log('\nAll directories created successfully!');
