from bs4 import BeautifulSoup
import urllib2
import subprocess

DEBUG = 1

proc = subprocess.Popen(['mocp', '--info'], stdout = subprocess.PIPE)
stdout, stderr = proc.communicate()

np = stdout.decode('ascii').splitlines()

for line in np:
    if 'Artist:' in line:
        b = line.split()[1:] # Split out band name in to 'b'
        band_name =' '.join(b)
        if DEBUG is 2:
            print band_name
    if 'Album:' in line:
        a = line.split()[1:] # Split out album title in to 'a'
        album_title = ' '.join(a)
        if DEBUG is 2:
            print a

if DEBUG is (1 or 2):
    print "DEBUG: band_url is: ", band_url
    print "DEBUG: album_url is: ", album_url

# r = band_name.replace(' ', '+')
m = 'http://www.metal-archives.com/bands/' + band_name
#m = 'http://www.metal-archives.com/search?searchString=' + r  + '&type=band_name'
ma_url = m.encode('ascii')
#ma_page = urllib2.urlopen('http://www.metal-archives.com/bands/Impetigo/').read()
ma_page = urllib2.urlopen(ma_url)
soup = BeautifulSoup(ma_page)
ma_band_info = soup.find('div', id='band_stats')
text = soup.get_text
print text
