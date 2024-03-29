"""stethoscope.py -- Debug a DAISY Online service.

DAISY Online Stethoscope v0.9 alpha
by Geoff Gilmour-Taylor
2009-2010

This tool sends SOAP messages to a DAISY Online service and prints the
responses raw, that is without any parsing.  The only requirement is
Python 2.4 or later (but not Python 3) and a Web connection.  To use,
uncomment one of the service names below, then edit the session function calls
given at the end of the file, then run
% python stethoscope.py

All operations but getQuestions are implemented.

setBookmarks requires you to generate the bookmarkSet XML to pass as a
parameter.

It is not thread-safe.
"""

import httplib

# Uncomment one of the following.
service = 'cnib'
## service = 'vails'
## service = 'solrad'
## service = 'pratsam'

# Set the credentials for logging on.
if service == 'cnib':
    creds = ('test', 'bogos')
elif service == 'solrad':
    creds = ('daisy', 'ysiad')
elif service == 'vails':
    creds = ('test', 'test')
elif service == 'pratsam':
    creds = ('tsg', 'daisy')
else:
    raise Exception('No service selected.')

#--------------------------- SOAP message strings ----------------------------

logOnMess = """\
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
   <SOAP-ENV:Header />
   <SOAP-ENV:Body xmlns:do="http://www.daisy.org/ns/daisy-online/">
      <do:logOn>
        <do:username>%s</do:username>
        <do:password>%s</do:password>
      </do:logOn>
   </SOAP-ENV:Body>
</SOAP-ENV:Envelope>"""

logOffMess = """\
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Header />
  <SOAP-ENV:Body xmlns:do="http://www.daisy.org/ns/daisy-online/">
    <do:logOff />
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>"""

setMarks = """\
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Header />
  <SOAP-ENV:Body xmlns:do="http://www.daisy.org/ns/daisy-online/">
    <do:setBookmarks>
      <do:contentID>%s</do:contentID>
      <do:bookmarkSet>%s</do:bookmarkSet>
    </do:setBookmarks>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>"""

getMarks = """\
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Header />
  <SOAP-ENV:Body xmlns:do="http://www.daisy.org/ns/daisy-online/">
    <do:getBookmarks>
      <do:contentID>%s</do:contentID>
    </do:getBookmarks>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>"""

getSA = """\
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Header />
  <SOAP-ENV:Body xmlns:do="http://www.daisy.org/ns/daisy-online/">
    <do:getServiceAttributes />
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>"""

setRSA = u"""\
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Header />
  <SOAP-ENV:Body xmlns:do="http://www.daisy.org/ns/daisy-online/">
    <do:setReadingSystemAttributes>
      <do:readingSystemAttributes>
        <do:manufacturer>Geoff Gilmour-Taylor</do:manufacturer>
        <do:model>DAISY Online Stethoscope</do:model>
        <do:version>0.9\u03b1</do:version>
        <do:config>
          <do:supportsMultipleSelections>false</do:supportsMultipleSelections>
          <do:preferredUILanguage>en</do:preferredUILanguage>
          <do:supportedContentFormats />
          <do:supportedContentProtectionFormats>
            <do:protectionFormat>PDTB2</do:protectionFormat>
          </do:supportedContentProtectionFormats>
          <do:supportedMimeTypes />
          <do:supportedInputTypes />
          <do:requiresAudioLabels>false</do:requiresAudioLabels>
        </do:config>
      </do:readingSystemAttributes>
    </do:setReadingSystemAttributes>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>""".encode('utf-8')

getList = """\
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Header />
  <SOAP-ENV:Body xmlns:do="http://www.daisy.org/ns/daisy-online/">
    <do:getContentList>
      <do:id>%s</do:id>
      <do:firstItem>%d</do:firstItem>
      <do:lastItem>%d</do:lastItem>
    </do:getContentList>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>"""

getCM = """\
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Header />
  <SOAP-ENV:Body xmlns:do="http://www.daisy.org/ns/daisy-online/">
    <do:getContentMetadata>
      <do:contentID>%s</do:contentID>
    </do:getContentMetadata>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>"""

getKXO = """\
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Header />
  <SOAP-ENV:Body xmlns:do="http://www.daisy.org/ns/daisy-online/">
    <do:getKeyExchangeObject>
      <do:requestedKeyName>%s</do:requestedKeyName>
    </do:getKeyExchangeObject>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>"""

getAnn = """\
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Header />
  <SOAP-ENV:Body xmlns:do="http://www.daisy.org/ns/daisy-online/">
    <do:getServiceAnnouncements />
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>"""

markRead = """\
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Header />
  <SOAP-ENV:Body xmlns:do="http://www.daisy.org/ns/daisy-online/">
    <do:markAnnouncementsAsRead>
      <do:read>
%s
      </do:read>
    </do:markAnnouncementsAsRead>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>"""

getCR = """\
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Header />
  <SOAP-ENV:Body xmlns:do="http://www.daisy.org/ns/daisy-online/">
    <do:getContentResources>
      <do:contentID>%s</do:contentID>
    </do:getContentResources>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>"""

issueCon = """\
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Header />
  <SOAP-ENV:Body xmlns:do="http://www.daisy.org/ns/daisy-online/">
    <do:issueContent>
      <do:contentID>%s</do:contentID>
    </do:issueContent>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>"""

returnCon = """\
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Header />
  <SOAP-ENV:Body xmlns:do="http://www.daisy.org/ns/daisy-online/">
    <do:returnContent>
      <do:contentID>%s</do:contentID>
    </do:returnContent>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>"""

#------------------------ end of SOAP message strings ------------------------

# Set up an HTTP or HTTPS connection.
if service == 'cnib':
    c = httplib.HTTPSConnection('76.10.166.135')
elif service == 'vails':
    c = httplib.HTTPConnection('test.i-access.visionaustralia.org')
elif service == 'solrad':
    c = httplib.HTTPConnection('soap.solrad.nl')
elif service == 'pratsam':
    c = httplib.HTTPConnection('thoth.pratsam.com', 81)

# HTTP header dictionary.
soapheader = {'Content-Type': 'text/xml; charset=utf-8'}

def sendMessage(body):
    """Send a SOAP message to the service."""
    if service == 'cnib':
        c.request('POST', '/do/', body, soapheader)
    elif service == 'vails':
        c.request('POST', '/daisyonline/service.svc', body, soapheader)
    elif service == 'solrad':
        c.request('POST', '/daisy/service/wrapped-document-literal/', body, soapheader)
    elif service == 'pratsam':
        c.request('POST', '/daisyonlinedemo/service.php', body, soapheader)

def printResponse():
    """Get the response from the server and print it.
    
    Print the HTTP response code, the HTTP headers and the body of the
    response.  Returns the response body.
    """
    
    response = c.getresponse()
    print response.status, response.reason
    headers = response.getheaders()
    for key, value in headers:
        if key == 'set-cookie':
            soapheader['Cookie'] = value
    print headers
    resptext = response.read()
    print resptext
    return resptext

#---------------------------- Required operations ----------------------------

def logOn(username, password):
    """Send the logOn message."""
    soapheader['SOAPAction'] = '/logOn'
    sendMessage(logOnMess % (username, password))
    resptext = printResponse()

def logOff():
    """Send the logOff message."""
    soapheader['SOAPAction'] = '/logOff'
    sendMessage(logOffMess)
    printResponse()

def setReadingSystemAttributes():
    """Send the setReadingSystemAttributes message."""
    soapheader['SOAPAction'] = '/setReadingSystemAttributes'
    sendMessage(setRSA)
    printResponse()

def issueContent(id):
    """Send the issueContent message."""
    soapheader['SOAPAction'] = '/issueContent'
    sendMessage(issueCon % id)
    printResponse()

def getContentMetadata(id):
    """Send the getContentMetadata message."""
    soapheader['SOAPAction'] = '/getContentMetadata'
    sendMessage(getCM % id)
    printResponse()

def getContentResources(id):
    """Send the getContentResources message."""
    soapheader['SOAPAction'] = '/getContentResources'
    sendMessage(getCR % id)
    printResponse()

def getServiceAttributes():
    """Send the getServiceAttributes message."""
    soapheader['SOAPAction'] = '/getServiceAttributes'
    sendMessage(getSA)
    printResponse()

def getContentList(id, firstItem=0, lastItem=-1):
    """Send the getContentList message."""
    soapheader['SOAPAction'] = '/getContentList'
    sendMessage(getList % (id, firstItem, lastItem))
    printResponse()

#---------------------------- Optional operations ----------------------------

def getServiceAnnouncements():
    """Send the getServiceAnnouncements message."""
    soapheader['SOAPAction'] = '/getServiceAnnouncements'
    sendMessage(getAnn)
    printResponse()    

def markAnnouncementsAsRead(*ids):
    """Send the markAnnouncementsAsRead message."""
    soapheader['SOAPAction'] = '/getServiceAnnouncements'
    read = '\n'.join('        <do:item>%s</do:item>' % id for id in ids)
    sendMessage(markRead % read)
    printResponse()    

def returnContent(id):
    """Send the returnContent message."""
    soapheader['SOAPAction'] = '/returnContent'
    sendMessage(returnCon % id)
    printResponse()

def getBookmarks(id):
    """Send the getBookmarks message."""
    soapheader['SOAPAction'] = '/getBookmarks'
    sendMessage(getMarks % id)
    printResponse()

def setBookmarks(id, bmset):
    """Send the setBookmarks message.
    
    Note that bmset must be an XML bookmarkSet
    """
    soapheader['SOAPAction'] = '/setBookmarks'
    sendMessage(setMarks % (id, bmset))
    printResponse()

def getKeyExchangeObject(name):
    """Send the getKeyExchangeObject message."""
    soapheader['SOAPAction'] = '/getKeyExchangeObject'
    sendMessage(getKXO % name)
    printResponse()    

def init():
    """Initialize a session."""
    logOn(*creds)
    getServiceAttributes()
    setReadingSystemAttributes()

if __name__ == '__main__':
    # This block is executed if this is run as a standalone programme, but not
    # if it is imported as a module.
    
    # Display the new, issued, and expired content lists.
    init()
    for id in ['new', 'issued', 'expired']:
        getContentList(id)  # firstItem and lastItem default to 0 and -1.
    logOff()
    