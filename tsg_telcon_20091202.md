Present: George, Geoff, Simon and Kenny.

Regrets: Matt, Nick, Dominik and Markus.

scribe: Kenny

## Action Item Summary ##

### New Action Items ###

  * George contact Dedicon to source PDTB2 content and confirm whether Dedicon will have a test implementation ready by February 15, 2010.
  * Simon check with Dominik on making sample PDTB2 content available to the spec implementers.
  * Kenny post to the list asking for volunteers for the formulation of the test suite.
  * kenny create wiki page for the test suite and post the Testable items identified thus far to it.
  * Geoff and Kenny start work on the Test document.

### Previous Unfinished Action Items ###

  * Jelle: propose resolution to [Issue 118](https://code.google.com/p/daisy-online-delivery/issues/detail?id=118) {DONE?}
  * Geoff and Markus analyze RequirementsDocument vs current API. {ONGOING}
  * Markus fix the &apos; entity problem.

### Group Action Items ###

#### Action items for the public review period commencing February 15, 2010 ####

  * All issues should be resolved or formally deferred.
  * Any updates to the spec need to be completed and proof read.
  * The primer should be proof read.
  * The Test suite, and the Test Implementations Conformance report should be made available.
  * A report needs to be made available that illustrates the conformance of the spec to the requirements.
  * Create an area where implementers can post information about the additional features that they have implemented on top of the spec, and that the community at large may be interested in.

#### Action items for formal recommendation to the Board on April 5, 2010 ####

  * Deliver Final version of the spec.
  * Provide Information on comments Received, and how they were addressed.
  * Make available the Test Implementations Conformance Report.
  * Make a formal Recommendation to the board for approval.

## Agenda/Minutes ##

### Timelines going forward ###

Kenny: Vision Australia has implemented all operations with the exception of the getKeyExchangeObject operation. Internally, we do not have a use for PDTB2 as yet.

George: RFB&D may be interested in implementing getKeyExchangeObject but not other parts of the spec.

Geoff: This operation cannot be implemented without the implementation of the Daisy Online spec.

Geoff: If there are no test implementations that support the getKeyExchangeObject operation, I am not comfortable with putting something in the spec that has not been tested.

Simon: We do not have any plans of supporting pdtb2 in our test implementation.

Kenny: George, can we source sample PDTB2 content from somewhere?

George: RFB&D and Library of Congress do protected content. RFB&D support PDTB1 content only.

George: Simon, do you have any PDTB2 content?


Simon: I will get back to the group after running it past Dominik.

George: I will take an action item to contact Dedicon for protected content.

Kenny: Given that we intend to submit the spec to the Daisy Board for approval in April 2010, what would your preferred timelines be George?

George: The spec should be ready by the 5th of April for formal recommendation by the Daisy Online Working Group for approval.

Daisy Online wg:

What needs to be done from here to get the spec to an internal reccomendation stage?
  * Any updates to the spec need to be completed and proof read.
  * The primer should be proof read by then too.
  * All issues should be resolved or formally deferred.
  * The Test suite, and the Test Implementations Conformance report should be made available.
  * A report needs to be made available that illustrates the conformance of the spec to the requirements. This report could be in the form of a table available on the same page as the Test Implementations Conformance Report page.

Agreed timelines:

  * 15 February: Begin public review period (last call).
  * 17 March: End public review period.
  * 5 april Make available to the board:
    * Final version of the spec.
    * Information on comments Received, and how they were addressed.
    * Test Implementations Conformance Report.
    * A formal Recommendation by the working group for approval.

### Issues ###

#### [Issue 191](https://code.google.com/p/daisy-online-delivery/issues/detail?id=191) ####

Potential testable items to kick off the discussion:

  * The wsdl published by a service is canonically equivalent to the normative wsdl provided in this spec.
  * All programming constructs generated conform to the published WSDL.
  * A published Service is available over http/https.
  * The Session innitialisation sequence is followed to commence a session with a published service.
  * Service model conformance.
  * Content selection mode conformance.
  * Content retrieval sequence conformance.
  * downloading and Streaming conformance.
  * Publishing updates and instalments conformance.
  * rights management conformance.
  * Service Announcements conformance.
  * dynamic menus conformance.
  * All fault stipulations in the normative WSDL are adhered to by a published Service.
  * All required operations are implemented as specified in the normative wsdl.
  * Range headers are always honoured in http requests by a published service.
  * A published service complies to WS-I basic  Profile 1.1

Proposed composition of the Test suite:

  * A list of testable items. (aka categories, components)
  * For each item, assertions that need to be met to claim conformance to the item.
  * Test cases to test these assertions.

Consensus: The test suite will be a document available on our wiki that will contain the three elements listed above. due to the time constraints, no automated conformance-checking utilities will be made available in version 1.0 of the spec. This Document will be a living document as the Primer.

##### Volunteers to work on the test cases #####

Geoff and Kenny to commence the work. Another volunteer required.

(Next telecon Wednesday, 9 December at 2100 UTC)