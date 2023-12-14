File.foreach('list.csv') {|l|
  r = l.strip.split(',')
  p `ipfs pin add #{r[1]}`
}

