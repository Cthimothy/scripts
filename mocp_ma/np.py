import subprocess
import urllib2
import httplib
import sys  

from PyQt4.QtGui import *  
from PyQt4.QtCore import *  
from PyQt4.QtWebKit import *  
from lxml import html 

class Render(QWebPage):  
  def __init__(self, url):  
    self.app = QApplication(sys.argv)  
    QWebPage.__init__(self)  
    self.loadFinished.connect(self._loadFinished)  
    self.mainFrame().load(QUrl(url))  
    self.app.exec_()  
  
  def _loadFinished(self, result):  
    self.frame = self.mainFrame()  
    self.app.quit()
    
DEBUG = 0
headers = {'User-Agent' : 'Mozilla/5.0'}

if DEBUG is 1:
    httplib.HTTPConnection.debuglevel = 1

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
            print an

if DEBUG is (1 or 2):
    print "DEBUG: band_url is: ", band_url
    print "DEBUG: album_url is: ", album_url

r = band_name.replace(' ', '+')
ma_url = 'http://www.metal-archives.com/search?searchString=' + r  + '&type=band_name'
#print ma_url

md = Render(ma_url)
ma_data = md.frame.toHtml()
ma_formatted_result = str(ma_data.toAscii())

#Next build lxml tree from formatted_result
ma_tree = html.fromstring(ma_formatted_result)
#band_country = tree.xpath('//div[@class="campaign"]/a/@href')
#band_country = ma_tree.xpath('//div[@class="campaign"]/a/@href')
#print band_country
#ma_request = urllib2.Request(ma_url, None, headers)
#print ma_request
#opener = urllib2.build_opener()
#ma_data = opener.open(ma_request).read()
#print ma_data
#data = ma.read()
#print data
#request.get_full_url()
#headers = { 'User-Agent' : 'Mozilla/5.0' }
#req = urllib2.Request('metal-archives.com', None, headers)
#html = urllib2.urlopen(req).read()
