const fs = require('fs');
const path = require('path');

console.log('Creating Letterboxd Clone Directory Structure...\n');

const directories = [
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

directories.forEach(dir => {
    try {
        fs.mkdirSync(dir, { recursive: true });
        console.log('✓ Created:', dir);
    } catch (error) {
        console.error('✗ Error creating', dir, ':', error.message);
    }
});

console.log('\n================================================');
console.log('✓ All directories created successfully!');
console.log('================================================\n');
console.log('You can now proceed with creating the application files.');
