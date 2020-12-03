package main

import (
  "bufio"
  "fmt"
  "log"
  "os" 
)

func main() {
  f, err := os.Open("input.txt")

  if err != nil {
    log.Fatal(err)
  }
  defer f.Close()

  var lines []string
  
  scanner := bufio.NewScanner(f)
  for scanner.Scan() {    
    line := scanner.Text()
    lines = append(lines, line)
  }

  if err := scanner.Err(); err != nil {
    log.Fatal(err)
  }

  encounters := 0
  x := 0
  y := 0
  for y < len(lines)-1 {
    y += 1
    x += 3

    if x >= len(lines[0]) {
      x = x % len(lines[0])
    }

    if lines[y][x:x+1] == "#" {
      encounters++
    }    
  }
  fmt.Println(encounters)
}