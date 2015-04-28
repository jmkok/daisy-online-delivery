Present: Dominik, Jelle, Simon, geoff, George, Markus, Nick, Kenny and Johan.

Regrets:

scribe: Kenny

## Action Item Summary ##

  * Nick get back to the group on his availability for the Test suite work.

## Agenda/Minutes ##

### Call for volunteers for the Test suite ###

  * Nick will get back to the group on his availability for the test suite work.
  * Jelle and Johan will help out with the test suite work.

### RNIB ###

#### test Implementation update ####

  * What has been implemented?
    * A test server and test client in c#.
    * The server implements out-of-band content selection and all operations, including dynamic menus  -  except ReturnContent, getBookmarks, setBookmarks  Search, ServerSideBack and PDTB2 key delivery .

  * What will be implemented by Feb 15, 2010?
    * Update to the latest published wsdl.
    * ReturnContent, ServerSideBack, getBookmark / setBookmark (if the issues with the bookmark structure are fixed). Not PDTB2 support.  I could do Search but probably not actually make the returned content available.

  * PDTB2 support in scope or out of scope?
    * No. Unless a usable "test" key can be generated in which case the test implementation can serve it (or not).

  * Will you be contributing to the Test Implementation compliance report?
    * Yes.

  * Challenges?
    * Learning about SOAP, webservices, WSDL and Microsofts WCF framework.

  * learnings?
    * That developing an international technical standard is not as quick or easy as it may at first appear.

### CNIB ###

#### Test Implementation update ####

  * What has been implemented?
    * A basic client library in Python.  The interface code is written, and downloading is implemented.  No optional operations besides `returnContent` have been implemented.  `requiresReturn` and `returnBy` currently do nothing.
    * A diagnostic tool in Python.  This library contains SOAP messages for the core operations as strings.  You send the messages using just an ordinary HTTP interface, and it will print the response headers and body.

  * What will be implemented by Feb 15, 2010?
    * A basic service, also written in Python.  This is nearly done; I just need to set up hosting and get some test content.  All core operations + `returnContent` are implemented.  The back end handles very basic library-style functionality; I hope to have it somewhat automated by February.

  * PDTB2 support in scope or out of scope?
    * Most likely out of scope.  We may be able to help do testing on the server end if content and keys are provided to us.

  * Will you be contributing to the Test Implementation compliance report?
    * We plan to show core compliance to demonstrate another interoperable client and server.

  * Challenges?
    * I was unable to implement bookmarks.  The code generator failed to generate types until I had commented out the bookmark import from the input XSD and the bookmark operations in the input WSDL.  The code generator did not give sufficient information to determine the cause of failure.
    * The web service library I chose, ZSI 2.0, is buggy and incomplete (although it seems to be the best server available for Python), and not has not seen a release since February 2007.  I had to debug some of the parsing code and the request handler myself.  I also had to add some functionality to the request handler to handle cookies properly and to generate `internalServerError` faults instead of the built-in fault.  The stub code generated for the Service was misleading and had to be rewritten.
    * More work has been done on WSDL stub code generators for clients rather than servers.  I think the expectation is that servers will more often be designed first, then the WSDL interface generated from that, rather than the server built to a common interface.  This creates challenges for server developers, since the stub code generation tools are more likely to be buggy and rudimentary.
    * Most developers on dynamic language platforms (such Perl, Python, Ruby, etc.) seem to range from uninterested to derisive of SOAP, and are more concerned with REST.  This leads to only a small group of people working on SOAP libraries which are in turn less developed.  I think this means that the world is moving towards REST for web services.  We may be interested in producing a RESTful protocol in the next version.

  * Learnings?
    * You don't have to publish the same WSDL you used to create your stub code.  I had to comment out the bookmark operations and type in order for ZSI's `wsdl2py` to generate any code.  I then added `get`- and `setBookmark` operations that did nothing but return an `invalidOperation` fault.  The WSDL I publish will include those operations, though, since the interface is still compliant.

### vision australia ###

#### test Implementation update ####

  * What has been implemented?
    * All operations with the exception of getKeyExchangeObject.
    * Both lending and acquisition Service Models.
    * Both the out-of-band and browse content selection methods.
    * Our test implementation is built using Microsoft's WCF 3.5 web services stack. It is being hosted on a windows server 2003 box with a sql server 2005 back-end.

  * What will be implemented by Feb 15, 2010?
    * The latest version of the spec.

  * PDTB2 support in scope or out of scope?
    * Subject to our time constraints, we may be able to implement the getKeyExchangeObject operation if we had sample PDTB2 content.

  * Will you be contributing to the Test Implementation compliance report?
    * Yes.

  * Challenges?
    * To generate code from the normative wsdl file without any manual tweaking.

  * learnings?
    * The svcutil.exe tool does not handle xsd imports or includes.
    * If the code generated from the svcutil tool is manually tweaked, it is very dificult to make a wsdl based on this code available that is equivalent to the normative wsdl at an Infoset level excluding the concrete information.

### Solutions Radio ###

#### test Implementation update ####

  * What has been implemented?
    * Currently we have a test-client and a service.
    * The test-client can be accessed over the internet.
    * Its primary goal is to fire SOAP queries and show the results, this might hopefully be very helpful for any party who wishes to get started using this protocol.
    * Currently the test-client can call all functions in order and see if all succeeds.
    * It will not be playing content.
    * "Bookmarks" are not being sent correctly as we have a problem with the complex type definitions ([issue 188](https://code.google.com/p/daisy-online-delivery/issues/detail?id=188)) The service has implemented all functions and returns responses to these functions.
    * The "getKeyExchangeObject" functions return just a load of strings
    * Changes will not be stored at this moment (so you can call issueContent, but it won't be issued)

  * What will be implemented by Feb 15, 2010?
    * The service will store bookmarks and keep track of issued content
    * The dynamic menu structure will be enlarged (currently only a single top level menu is implemented) - focus will be on "multipleChoiceQuestion"
    * The test-client is already very usable (but still might contain bugs), but we can extent the tests further.

  * PDTB2 support in scope or out of scope?
    * Due to the knowledge required for implementing PDTB2 support, it is out of scope for our test implementation.

  * Will you be contributing to the Test Implementation compliance report?
    * I am not sure what is required to contribute to this report.

  * Challenges?

  * learnings?
    * I think the WSDL should be in such shape that even simple clients and services should be able to use them.
    * A "wild" idea. It sprung to mind that a "setBlob" and "getBlob" might replace the bookmark functions. This way a client might send a bookmark as a "blob" to the service which keeps this blob attached to a specific book. This makes the service extremely easy to build, as it won't have to have any notion of "bookmarks" itself. This function could be called with a "contentID", a type (eg. "BOOKMARK") and the data (eg. the bookmark itself). The same could be done for getBlob eg.
getBlob("contentID","BOOKMARK"). This would actually enable:
      * Future kind of data being stored on the service, without creating additional commands and/or making modifications on the service
      * Clients being able to store proprietary information on the server/service, which needs to be attached to a book.

### Humanware ###

#### test Implementation update ####

  * What has been implemented?
    * Humanware Companion (PC transfer tool) is being modified to support access to library service using Microsoft WCF .

  * What will be implemented by feb 15, 2010?
    * Downloading and returning of content.
    * Support for dynamic menu.
    * Test generating client code using different soap client.

  * PDTB2 support in scope or out of scope?
    * If content can be found, test could be made to acquire and transfer to a Stream a PDTBT2 Key Exchange Object.
    * If no organisation intend to publish protected content or to use this functionality at first, we don’t mind leaving this out of scope for now.

  * Will you be contributing to the Test Implementation compliance report?
    * Yes.

  * Challenges?

  * learnings?
    * I haven’t been able to generate valid client code from the WSDL available in svn. This is using svcutil from Microsoft.
    * My understanding is that this WSDL will be the starting point for all service and client. Effort should be made to have it work with all major tools. Not that I pretend to know who’s major ...
    * About the bookmark issue, we don’t intend to support bookmark exchange for now. I agree that Jelle suggestion would make it work. But it also open a door for storing unknown content on the service side.

### Plextor ###

#### test Implementation update ####

  * What has been implemented?
    * We are implementing client functions.
    * Dynamic menu is partially supported. It is available from player's menu.
    * Streaming/Download contents.

  * What will be implemented by feb 15, 2010?
    * Remaining dynamic menu functions (inputQuestions)
    * Loaning book management. (Issue/Return contents)
    * Out-of-band contents selection.

  * PDTB2 support in scope or out of scope?
    * In scope. But it is depending on availability at service provider side.
Function may not be implemented by Feb 15.

  * Will you be contributing to the Test Implementation compliance report?
  * Yes

  * Challenges?

  * learnings?
    * Compatibility improvements for various server applications. When we connect to new service provider, we always need some adjustments depending on which technology each organization is using such as WCF.
    * Generating code from normative WSDL without manual adjustment.

### PratSam ###

#### test Implementation update ####

  * What has been implemented?
    * an out-of-band content selection service implemented in WSO2 WSF/PHP
    * all functions except getQuestions and getKeyExchangeObject

  * What will be implemented by Feb 15, 2010?
    * update to the current WSDL
    * getQuestions with support for search and back
    * getKeyExchangeObject (hopefully with a real keys)

  * PDTB2 support in scope or out of scope?
    * in scope
    * random keys will be generated and returned unless I get a sample PDTB2 content

  * Will you be contributing to the Test Implementation compliance report?
    * yes

  * Challenges?
    * understanding the WSO2 Web Service Framework
    * understanding XML schemas and namespaces
    * generating code from the normative wsdl without any manual tweaking.
    * handling of choices where maxOccurs > 1

  * learnings?
    * make sure that the framework support choices with maxOccurs > 1
    * choose a framework with a rich documentation, where samples are provided, where support is available, that has been around for a while, and that seems to evolve
    * the generated code is not always correct
    * elements in XML schemas, complex or simple, can be expressed in various ways. the code generator may not be able to understand everything whereas it may be necessary to describe elements in such a way that it can be understood by your code generator and your framework
    * there are several [built-in datatypes](http://www.w3.org/TR/xmlschema-2/#built-in-datatypes) in XML schemas, check how these types are mapped in your programming language if you use a weakly typed language like PHP, Python, Ruby, etc