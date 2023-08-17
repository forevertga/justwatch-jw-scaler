package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/minio/minio-go/v7"
)

func main() {
	// Initialize Minio client
	minioClient, err := minio.New("localhost:9000", "AQSaLIobRvkjl26OiFtM", "qo9CWjotAmwzpyuYEfKjMmfU9cTfZkoeDkPZgaGK", false)
	if err != nil {
		log.Fatal(err)
	}

	http.HandleFunc("/posters/", func(w http.ResponseWriter, r *http.Request) {
		objectName := r.URL.Path[len("/posters/"):]

		// Generate a presigned URL for the object (poster)
		presignedURL, err := minioClient.PresignedGetObject("posters", objectName, 60*5, nil)
		if err != nil {
			http.Error(w, "Object not found", http.StatusNotFound)
			return
		}

		// Redirect the user to the presigned URL
		http.Redirect(w, r, presignedURL.String(), http.StatusSeeOther)
	})

	fmt.Println("Server listening on :8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
