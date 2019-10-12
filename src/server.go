package main

import (
	"log"
	"net/http"
	"strings"
)

func main() {
	startUp()

	fs := http.FileServer(http.Dir("."))
	http.Handle("/", fs)
	http.HandleFunc("/regenerate/", RegenerateHandler)

	log.Println("Listening...")
	http.ListenAndServe(":8080", nil)
}

func RegenerateHandler(w http.ResponseWriter, r *http.Request) {
	repoName := strings.TrimPrefix(r.URL.Path, "/regenerate/")
	generateReport(repoName)

	http.Redirect(w, r, "/", http.StatusFound)
}
