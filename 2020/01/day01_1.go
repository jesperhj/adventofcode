package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
  f, err := os.Open("input_test.txt")

  if err != nil {
    log.Fatal(err)
  }
  defer f.Close()

  var lines []int
  
  scanner := bufio.NewScanner(f)
  for scanner.Scan() {  	
  	line, err := strconv.Atoi(scanner.Text())		
  	if err != nil {
    	log.Fatal(err)
  	}

  	lines = append(lines, line)
  }


  if err := scanner.Err(); err != nil {
   log.Fatal(err)
  }

	for _, a := range lines {
  	for _, b := range lines {
  		if (a + b == 2020) {
  			fmt.Println(a*b)
  			return
  		}  		
  	}  	
  }


 }