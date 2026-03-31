package main

import (
	"fmt"
	"os"
)

func main() {
	dirs := []string{
		"letterboxd-clone/backend/config",
		"letterboxd-clone/backend/users",
		"letterboxd-clone/backend/movies",
		"letterboxd-clone/backend/reviews",
		"letterboxd-clone/backend/recommendations",
		"letterboxd-clone/frontend/src/components",
		"letterboxd-clone/frontend/src/pages",
		"letterboxd-clone/frontend/src/context",
		"letterboxd-clone/frontend/src/utils",
		"letterboxd-clone/frontend/public",
	}

	for _, dir := range dirs {
		err := os.MkdirAll(dir, 0755)
		if err != nil {
			fmt.Printf("Error creating %s: %v\n", dir, err)
			continue
		}
		fmt.Printf("Created: %s\n", dir)
	}

	fmt.Println("\nAll directories created successfully!")
}
