package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
)

func main() {
	links := ""
	fmt.Println("Generate PHP-Metrics Reports...")

	repos, err := ioutil.ReadDir("./repos")
	if err != nil {
		log.Fatal(err)
	}

	for _, f := range repos {
		reportLink := generateReport(f.Name())

		links = links + reportLink
	}

	createIndexFile(links)
	fmt.Println("Done!")
}

func createIndexFile(links string) {
	input, err := ioutil.ReadFile("template.html")
	if err != nil {
		log.Fatal(err)
	}

	output := bytes.Replace(input, []byte("%repo-links%"), []byte(links), -1)

	if err = ioutil.WriteFile("index.html", output, 0666); err != nil {
		log.Println(err)
		os.Exit(1)
	}
}

func generateReport(repoName string) string {
	cmd := exec.Command("php", "../vendor/bin/phpmetrics", "--report-html=../report-"+repoName, repoName)
	err := cmd.Run()
	if err != nil {
		log.Fatal(err)
	}

	return createLink(repoName)
}

func createLink(repoName string) string {
	return fmt.Sprintf("<a href =\"report-%s\" class=\"btn btn-info form-control\">%s</a><br><br>", repoName, repoName)
}
