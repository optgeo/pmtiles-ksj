require 'find'

SRC_DIR = "../Downloads"
DRY_RUN = false

w = File.open('list.csv', 'w')

Find.find("#{SRC_DIR}") {|path|
  next unless /shp$/.match path
  if DRY_RUN
    p path
    next
  end
  fgb_path = path.sub('.shp', '.fgb')
  pmtiles_path = path.sub('.shp', '.pmtiles')
  layer = File.basename(path, '.shp')
  system <<-EOS
rm -f #{fgb_path}; \
ogr2ogr -overwrite -oo ENCODING=CP932 \
-nlt PROMOTE_TO_MULTI \
#{fgb_path} #{path}; \
tippecanoe -f -o #{pmtiles_path} \
--layer #{layer} \
--drop-densest-as-needed #{fgb_path}
  EOS
  cid = `ipfs add #{pmtiles_path}`.split(' ')[1]
  [$stdout, w].each {|o|
    o.print "#{layer},#{cid}\n"
  }
}

w.close
