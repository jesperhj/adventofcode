package main

import (
  "bufio"
  "fmt"
  "log"
  "os"
  "strings"
  "strconv"
)

func main() {
  f, err := os.Open("input.txt")

  if err != nil {
    log.Fatal(err)
  }
  defer f.Close()

  var lines [][]string
  
  scanner := bufio.NewScanner(f)
  for scanner.Scan() {

    line := strings.Split(scanner.Text(), " ")  // spit the line
    tmp := strings.Split(line[0], "-")          // replace x-y with 2 individual elements
    _, line = line[0], line[1:]    
    line = append([]string{tmp[1]}, line...)
    line = append([]string{tmp[0]}, line...)
    line[2] = strings.TrimSuffix(line[2], ":")  // change x: into x
    
    lines = append(lines, line)
  }

  if err := scanner.Err(); err != nil {
    log.Fatal(err)
  }

  // check that only 1 of the places in string match
  valid_passwords := 0
  for _, i := range lines {    
    min, _ := strconv.Atoi(i[0])
    max, _ := strconv.Atoi(i[1])
        
    if (i[3][min-1:min] == i[2]) != (i[3][max-1:max] == i[2]) {
      valid_passwords++
    }

  }
  fmt.Println(valid_passwords)

}