Present: Geoff, Dominik, Jelle, Simon, George, Markus, Kenny, Nick and Johan.

Regrets:

scribe: Kenny

## Action Item Summary ##

### New Action Items ###

  * Markus ensure that @xml:lang is required on the label type and @dir is optional on label/text in the svn, and close [Issue 93](https://code.google.com/p/daisy-online-delivery/issues/detail?id=93).
  * Markus close [Issue 142](https://code.google.com/p/daisy-online-delivery/issues/detail?id=142).
  * Geoff make a note in the spec that the fault types defined in the wsdl must be child elements of the details element of the soap:fault element, and close [Issue 184](https://code.google.com/p/daisy-online-delivery/issues/detail?id=184).
  * Geoff close [Issue 186](https://code.google.com/p/daisy-online-delivery/issues/detail?id=186).
  * Geoff close [Issue 187](https://code.google.com/p/daisy-online-delivery/issues/detail?id=187).
  * Kenny modify the bookmark xsd to eliminate empty complex types. The issue should be kept open until the group has reviewed the xsd.
  * Kenny add relative values as per proposal 2 to the wsdl. This issue should be kept open until the compatibility with Microsoft tools is confirmed.
  * Geoff mark [Issue 191](https://code.google.com/p/daisy-online-delivery/issues/detail?id=191) as started in the tracker.
  * Geoff change invalidOperation to invalidParameter in Section 4.4.4.3, and close [Issue 194](https://code.google.com/p/daisy-online-delivery/issues/detail?id=194).
  * Geoff record in the spec that the getContentResources operation returns an invalidParameter fault for content that has not been issued, and close [Issue 195](https://code.google.com/p/daisy-online-delivery/issues/detail?id=195).

### Previous Unfinished Action Items ###

  * Kenny check in the implementer's call for test suite volunteers.
  * Kenny add a recommendation in the spec documentation pertaining to state information being held for the duration of a session and close [Issue 39](https://code.google.com/p/daisy-online-delivery/issues/detail?id=39).
  * Kenny close [Issue 101](https://code.google.com/p/daisy-online-delivery/issues/detail?id=101)
  * Kenny close [Issue 103](https://code.google.com/p/daisy-online-delivery/issues/detail?id=103)
  * Geoff record in the Systems Testing document that the requirement for Diagnostic Information has not been met.
  * Kenny to make a note in the documentation and the test suite that audio notes are specifically not supported. An http based put scheme may be introduced in a future version but not in this version, and close [Issue 104](https://code.google.com/p/daisy-online-delivery/issues/detail?id=104).
  * Geoff to modify the verbiage of the paragraph after the second Note in Section 4.4.2 of the documentation and close [Issue 157](https://code.google.com/p/daisy-online-delivery/issues/detail?id=157).
  * Geoff to add the normative assertion that Services must not change the value of the returnBy attrribute once the getContentResources operation has been called once to the documentation and the test suite, and close [Issue 165](https://code.google.com/p/daisy-online-delivery/issues/detail?id=165).
  * Geoff remove the paragraph on TTS in Section 6 (Type Reference) under Narrator of the spec, and close [Issue 173](https://code.google.com/p/daisy-online-delivery/issues/detail?id=173).
  * Geoff to clarify the verbiage for segmented contentList(s) and close [Issue 174](https://code.google.com/p/daisy-online-delivery/issues/detail?id=174).
  * Kenny to document that returnContent should never return false in the documentation and test suite, and close [Issue 181](https://code.google.com/p/daisy-online-delivery/issues/detail?id=181).
  * Geoff and Kenny start work on the Test suite. (In progress)
  * Geoff and Kenny start work on the Systems Testing document (in progress)
  * Markus fix the &apos; entity problem. (outstanding; bug in IE.) (Markus will fix this when ready to publish.)

### Group Action Items ###

#### Action items for the public review period commencing February 15, 2010 ####

  * All issues should be resolved or formally deferred.
  * Any updates to the spec need to be completed and proof read.
  * The primer should be proof read.
  * The Test suite, The Systems testing document and the Test Implementations Conformance report should be made available.
  * Create an area where implementers can post information about the additional features that they have implemented on top of the spec, and that the community at large may be interested in.

#### Action items for formal recommendation to the Board on April 5, 2010 ####

  * Deliver Final version of the spec.
  * Provide Information on comments Received, and how they were addressed.
  * Make available the Test Implementations Conformance Report.
  * make available the systems testing  document.
  * Make a formal Recommendation to the board for approval.

## Agenda/Minutes ##

### Issues ###

#### [Issue 93](https://code.google.com/p/daisy-online-delivery/issues/detail?id=93) ####

markus: There is an i18n issue with the label/text element. This needs to support
at least inline markup for xml:lang, directionality, bdo, and optimally
also ruby. One solution is to allow a subset of XHTML1.1 inline in this
context.

Markus: Out of scope?  Need at least xml:lang, dir attributes on label element.

Resolution: @xml:lang to be required on the label type, and @dir to be optional on label/text. Markus to make the necessary change in the svn, and close [issue 93](https://code.google.com/p/daisy-online-delivery/issues/detail?id=93).

#### [Issue 142](https://code.google.com/p/daisy-online-delivery/issues/detail?id=142) ####

Markus: We have
-serviceAttributes/supportedOptionalOperations/operation/DYNAMIC\_MENUS that
declares if a Service supports dynamic menus **in general**
- serviceAttributes/supportsServerSideBack which is a subset of the above
- serviceAttributes/supportsSearch which is a subset of the above
- serviceAttributes/supportedContentSelectionModels/BROWSE which **almost**
but not entirely overlaps with supportsSearch (BROWSE could be fulfilled by
other means than collection searching facilities, eg exposing precomposed
contentLists through the menus)

Although I cant see that the above is broken per se, it could be expressed
in a more easy to grok form.

Resolution: The group decided to defer any design changes to ServiceAttributes to the next version of the spec. The group will only entertain a bug-fix from hereon in. Markus to close [Issue 142](https://code.google.com/p/daisy-online-delivery/issues/detail?id=142).

#### [Issue 184](https://code.google.com/p/daisy-online-delivery/issues/detail?id=184) ####

Matt: Clarify fault documentation re email inquiry:

Where and how
should the invalidOperation be integrated in the SOAP fault? Should it
appear as a child element in the detail element of the fault element or
should it be a string representing the faultcode of the fault element or
what?

Resolution: Geoff make a note in the spec that the fault types defined in the wsdl must be child elements of the details element of the soap:fault element, and close [Issue 184](https://code.google.com/p/daisy-online-delivery/issues/detail?id=184).

#### [Issue 186](https://code.google.com/p/daisy-online-delivery/issues/detail?id=186) ####

Geoff: Since returnContent is an optional operation, it should be declared in a
Service's 

&lt;serviceAttributes&gt;

.  However, it's missing from the list of
allowed values for 

&lt;operation&gt;

.

http://www.daisy.org/projects/daisy-online-delivery/drafts/20090927/do-spec-20090927.html#tp_operation

Resolution: No change required. Geoff to close [Issue 186](https://code.google.com/p/daisy-online-delivery/issues/detail?id=186).

#### [Issue 187](https://code.google.com/p/daisy-online-delivery/issues/detail?id=187) ####

Geoff: The localized, plain language error messages requirement says that error
messages should be localized.

http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Localized,_plain_language_error_messages

If we're going to localize them, then we should probably have an optional
xml:lang attribute on the 

&lt;reason&gt;

 subelement (

&lt;faultstrings&gt;

 already have
this, via WS-i).

Resolution: No change to be made in this version of the spec. The group agreed that meaningful error messages are best left to the Reading Systems at this stage. Geoff close [Issue 187](https://code.google.com/p/daisy-online-delivery/issues/detail?id=187).

#### [Issue 188](https://code.google.com/p/daisy-online-delivery/issues/detail?id=188) ####

Matt: Using empty complexType definitions for ncxRef, etc. is causing problems
with some tools. There appears to be no reason why the using @type to
specify a simpler type wouldn't work instead.

Resolution: Kenny to modify the bookmark xsd to eliminate empty complex types. This issue should be kept open until the group has reviewed the xsd.

#### [Issue 190](https://code.google.com/p/daisy-online-delivery/issues/detail?id=190) ####

kenny: Do we need to specify a value for soap actions in the wsdl to cater for
development tools that do not accept empty soap action values?

Proposal 1: Do not specify a value. (no change required)

Proposal 2: Specify a relative value i.e. "/getServiceAttributes"

Resolution: Kenny add relative values as per proposal 2 to the wsdl. This issue should be kept open until the compatibility with Microsoft tools is confirmed.

#### [Issue 191](https://code.google.com/p/daisy-online-delivery/issues/detail?id=191) ####

Kenny: Currently, the spec  does not provide a test suite. Lack of a test suite
may lead to interoperability issues.

Action: As the Test Suite is in progress, Geoff to mark this issue as started in the tracker.

#### [Issue 194](https://code.google.com/p/daisy-online-delivery/issues/detail?id=194) ####

Geoff: 4.4.4.3. Accessing PDTB2 Content says, "If the Service does not have any of
the keys or if the User is not authorized to access the Content, then the
Service must reply with an invalidOperation fault."  This should be
invalidParameter instead, to be consistent with other operations.  The
problem is that the User did not supply the correct parameters (missing
keys, unauthorized keys).

Resolution: Geoff change invalidOperation to invalidParameter in Section 4.4.4.3, and close [Issue 194](https://code.google.com/p/daisy-online-delivery/issues/detail?id=194).

#### [Issue 195](https://code.google.com/p/daisy-online-delivery/issues/detail?id=195) ####

geoff: What fault should getContentResources return if it is called for Content
that is not issued?  invalidOperation or invalidParameter?  The docs say
the call is invalid if the Content is not issued.  However, the operation
itself could be valid, but the wrong Content ID was used.

Resolution: Geoff record in the spec that the getContentResources operation returns an invalidParameter fault for content that has not been issued, and close [Issue 195](https://code.google.com/p/daisy-online-delivery/issues/detail?id=195).

### Test suite Progress ###

#### [Test Suite](http://code.google.com/p/daisy-online-delivery/wiki/tsg_test_suite) ####

#### [Systems Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolSystemTestingTestCases) ####

Next telecon on January 6, 2010 at 2100UTC.