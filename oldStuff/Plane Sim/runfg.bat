C:
cd C:\Program Files\FlightGear

SET FG_ROOT=C:\Program Files\FlightGear\data
.\\bin\\win64\\fgfs --aircraft=dhc2W --fdm=network,localhost,5501,5502,5503 --start-date-lat=2004:06:01:05:00:00 --disable-sound --in-air --enable-freeze --airport=KSFO --runway=10L --altitude=7224 --heading=113 --offset-distance=4.72 --offset-azimuth=0 --atlas=socket,out,1,localhost,5505,udp --fog-disable --disable-clouds --disable-clouds3d --fg-scenery="$FG_ROOT/Scenery/:$HOME/fgfsScenery"