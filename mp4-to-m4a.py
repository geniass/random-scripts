import os
import sys


mp4 = []
albumart = []

def walk(path):
    for (path, dirs, files) in os.walk(path):

        mp4.extend([os.path.join(path, f) for f in files if f[-3:] == "mp4"])
        albumart.extend([os.path.join(path, f) for f in files if (f[-3:] == "jpg" or f[-4:] == "jpeg") and f !="albumart.jpg"])


if len(sys.argv) == 2:
    root = sys.argv[1]
    walk(root)

    if len(albumart) != 0:
        for f in albumart:
            new = os.path.dirname(f) + "/albumart.jpg"
            os.rename(f, new)
            print f + "  -->  " + new
    else:
        print "Album art is correctly named"

    if len(mp4) != 0:
        for f in mp4:
            new = f[:-3] +"m4a"
            os.rename(f, new)
            print f + "  -->  " + new
    else:
        print "No .mp4 files found"


else:
    print "There shall be 1 and only 1 argument: the root directory to start in"
