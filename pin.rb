File.foreach('list.csv') {|l|
  r = l.strip.split(',')
  system "ipfs pin add --progress #{r[1]}"
}

