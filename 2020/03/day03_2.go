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

  trees := 1
  slopes := [][]int{{1,1},{3,1},{5,1},{7,1},{1,2}}
  for _, slope := range slopes {
    encounters := 0
    x := 0
    y := 0

    for y < len(lines)-1 {
      y += slope[1]
      x += slope[0]

      if x >= len(lines[0]) {
        x = x % len(lines[0])
      }

      if lines[y][x:x+1] == "#" {
        encounters++
      }
    }
    trees *= encounters
  }
  
  
  fmt.Println(trees)
}