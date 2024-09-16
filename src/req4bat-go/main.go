package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"strconv"
	"strings"
)

func main() {
	var targetUrl, sliceJson string
	args := os.Args[1:]
	if len(args) < 4 {
		fmt.Println("error")
		os.Exit(1)
	}

	for i := 0; i < len(args); i++ {
		switch args[i] {
		case "--url":
			if i+1 < len(args) {
				targetUrl = args[i+1]
				i++
			} else {
				fmt.Println("error")
				os.Exit(1)
			}
		case "--slice-json":
			if i+1 < len(args) {
				sliceJson = args[i+1]
				i++
			} else {
				fmt.Println("error")
				os.Exit(1)
			}
		default:
			fmt.Printf("error")
			os.Exit(1)
		}
	}

	reqData, err := request(targetUrl)
	if err != nil {
		fmt.Println("error")
		os.Exit(1)
	}

	var data interface{}
	if err := json.Unmarshal([]byte(reqData), &data); err != nil {
		fmt.Println("error")
		os.Exit(1)
	}

	keys := parseKeys(sliceJson)

	value, err := getValueByKeys(data, keys)
	if err != nil {
		fmt.Println("error")
		os.Exit(1)
	} else if value == nil {
		fmt.Println("error")
		os.Exit(1)
	}

	fmt.Println(value)
}

func request(url string) (string, error) {
	resp, err := http.Get(url)
	if err != nil {
		return "", fmt.Errorf("error")
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return "", fmt.Errorf("error")
	}

	return string(body), nil
}

func parseKeys(keysStr string) []string {
	return strings.Split(keysStr, ",")
}

func getValueByKeys(data interface{}, keys []string) (interface{}, error) {
	var current interface{} = data
	for _, key := range keys {
		switch v := current.(type) {
		case map[string]interface{}:
			current = v[key]
		case []interface{}:
			index, err := strconv.Atoi(key)
			if err != nil || index < 0 || index >= len(v) {
				return nil, fmt.Errorf("error")
			}
			current = v[index]
		default:
			return nil, fmt.Errorf("error")
		}
	}
	return current, nil
}
