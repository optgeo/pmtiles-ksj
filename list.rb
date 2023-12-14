w = File.open('list.md', 'w')
File.foreach('list.csv') {|l|
  r = l.strip.split(',')
  w.print <<-EOS
- [#{r[0]}](https://protomaps.github.io/PMTiles/?url=https://smb.optgeo.org/ipfs/#{r[1]})
  EOS
}
w.close
