'''
Created on Apr 26, 2012

@author: travis
'''
import urllib2

def _get_remote_html(url):
    response = None
    try:
        response = urllib2.urlopen(url)
    except:
        print "ERROR: HTTP failure connecting to %s" %url
        return ""
    if response.getcode() >= 400:
        print "ERROR:  %s returned status code %d" %(url, response.getcode())
        response.close()
        return ""
    bnet_xhtml = response.read()
    response.close()
    return bnet_xhtml

print _get_remote_html("http://www.google.com")
print
print _get_remote_html("http://qa-atswebsvc01.ascitest.net:8080/atswebservices/segments/customers")