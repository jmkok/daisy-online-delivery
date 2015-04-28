present: Geoff, Johan, George, Simon, Jelle and Kenny.

Regrets: Hiro, Dominik.

scribe: Kenny

## Action Item Summary ##

### New Action Items ###

  * Geoff eliminate the ambiguity around the use of the word "Content" in the spec, and close [Issue 211](https://code.google.com/p/daisy-online-delivery/issues/detail?id=211).
  * Geoff replace "invoke" with "call" for all its occurrences in the context of an operation, and close [Issue 212](https://code.google.com/p/daisy-online-delivery/issues/detail?id=212).
  * Geoff remove unnecessary use of Notes from the spec, and close [Issue 213](https://code.google.com/p/daisy-online-delivery/issues/detail?id=213).
  * Hiro provide Johan manufacturer and model key names for KXO generation.
  * Simon, Jelle, Johan, Geoff and Hiro implement pdtb2 support in their test implementations by 8 March.
  * Simon and Geoff reformat the Conformance Testing document, and rename it to Interoperability Testing.
  * Johan provide sample content in contentMetadata.

> ### Previous Unfinished Action Items ###

  * Jelle post the key name he intends to use to the list for KXO creation. **done**
  * Johan make three KXOs available per Reading system. **done**
  * Kenny add a normative assertion, that sets forth the invalidParameter fault as the consequence of a Reading System calling the getQuestions operation with the "back" id when no prior call to the getQuestions operation has been made in the active session, to the spec and the conformance testing documents.
  * Kenny add a normative assertion, that sets forth the invalidParameter fault as the consequence of a Reading System calling the getQuestions operation with the "back" and "search" IDs, when these IDs are not supported by a Service.
  * Geoff add verbiage to the spec stating that no input questions should be sent to a Reading System that require an input type not supported by the Reading System. **done**
  * Kenny create a new page called "Summary of Recommendations," to record the optional assertions in the spec. **done**
  * Kenny add substantive comments to issue tracker.
  * Kenny inform the owner of a substantive comment once the comment has been addressed.
  * All define test cases for the conformance testing document by 28 Feb.
  * Nick, Hiro, Johan and Kenny to review the Systems Testing document and post their comments/participation intentions  on the page or on the list before the next telecon. **done**
  * Nick, Johan, Simon, Hiro and Jelle to review the Conformance Testing document, post their comments on the page or the list, and add test cases.
  * Hiro and Jelle to send their public keys to the service implementers. **done: Waiting for KXOs**
  * Johan to provide the RS specific KXOs to the service implementers. **done**
  * Simon to add the minOccurs and maxOccurs tweak to the tweaks page.
  * Geoff to record an issue in the issue tracker for the setBlob/getBlob operations as suggested by Jelle, and mark this issue as an enhancement for the next version of the spec.   **done**
  * After the pdtb2 folks have fixed their version of kxo.xsd, kenny to change XSDs to their canonical URIs. **done**
  * Markus fix the &apos; entity problem. (outstanding; bug in IE.) (Markus will fix this when ready to publish.)

### Group Action Items ###

#### Action items for formal recommendation to the Board on April 5, 2010 ####

  * Deliver Final version of the spec.
  * Provide Information on comments Received, and how they were addressed.
  * Make available the Interoperability Testing document.
  * Make Available the Systems Testing document.
  * Make available the Interoperability Testing Conformance Report.
  * make available the systems testing  Conformance report.
  * Make a page available that provides PDTB2 specific knowledge to Daisy Online Implementers.
  * Make a page available that provides all the tweaks to the WSDL and XSD files, that group members had to make to these files for their respective implementations.
  * Make a formal Recommendation to the board for approval.

## Agenda/Minutes ##

### Issues ###

#### [Issue 211](https://code.google.com/p/daisy-online-delivery/issues/detail?id=211) ####

Geoff: Content gets used in various ways in the text.  We should settle on whether
Content is singular, plural or a collective noun and stick to it throughout
the documentation.  (I think collective noun is best, with Content item as
singular and Content items as plural.)

Kenny: Agree. There seems to be an ambiguity around the use of the word content in the spec.

(Consensus: Group decided to move forward with Geoff's proposal.)

#### [Issue 212](https://code.google.com/p/daisy-online-delivery/issues/detail?id=212) ####

Geoff: Sometimes we say "call an operation" sometimes, it's "invoke an operation".
> We should decide on one and stick to it.  I say, "call".

Also, "invoke the X operation" is kind of wordy.  Apart from introducing
operations, that should be shortened to "call X" or "invoke X", whichever
we decide.

kenny: I prefer "Call" too.

Simon: I am happy with "Call."

Johan: "Call" sounds good.

(consensus: Group agreed to replace the word "Invoke" with "Call.")

#### [Issue 213](https://code.google.com/p/daisy-online-delivery/issues/detail?id=213) ####

Geoff: There are too many notes in the spec.  This breaks up the flow and makes
important highlights harder to notice.  We should only use notes for
unexpected things (like audio notes not being supported in bookmarks) and
not for everything after the first paragraph in a section.

Kenny: What criteria should we follow to determine whether something constitutes a note?

Geoff: Notes should be exceptional things or security considerations. The purpose of a Note is to draw attention to a particular paragraph.

Simon: I am happy with Notes being used sparingly.

(Consensus: Group decided to make the required modifications to the spec to eliminate unnecessary notes. Notes will only be used in exceptional circumstances.)

### PDTB2 support progress review ###

  * Sample KXOs.

Johan: I have provided three KXOs for Humanware and Solutions Radio, and one for Plextor. I am waiting for Hiro on Manufacturer and Model key names. I have these keys, but don't know what names to use.

  * RS and Service Implementers?

Johan: I will implement pdtb2 support in my Service. I have made all the changes but have not released them yet. I will release a new version in a week.

Simon: Are we going to agree on a specific PDTB2 protected content.

Geoff: In my Service, I was intending to provide the content supplied by Neale. I will llet you know what the content id is.

Kenny: Do we agree on using only the content supplied by Neale for the purposes of PDTB2 support in the spec?

(consensus: Group agreed to only use the content supplied by Neale for the purposes of pdtb2 support in the spec in all the test implementations.)

Geoff: I will be supporting pdtb2 support in my Service too.

Simon: I will be supporting pdtb2 in my RS test implementation.

Jelle: me too in my RS test implementation.

Kenny: Since we have two Service and client test implementations to demonstrate the pdtb2 support in the spec, is everyone happy with Vision Australia not supporting pdtb2 in its test implementation? We could then focus on ironing out any remaining issues with our implementation.

  * Implementation Timelines.

Johan: I will be done with PDTB2 support by 8 March.

Geoff: I will aim for 8 March too.

Simon: I will aim for 8 March too.

Jelle: Me too.

### Test suite Progress review ###

#### [Conformance Testing](http://code.google.com/p/daisy-online-delivery/wiki/tsg_test_suite) ####

  * What remains to be done? (define and assign outstanding tasks)

Kenny: We will move the Systems and Conformance Testing documents to the DC website when the spec is approved.

George: There is already a issue tracking mechanism on the Daisy website. Lets add Daisy Online to this mechanism. The Wg would then receive an issue, determine whether the issue is substantive, non-substantive .. There is already a list of categories for issues.

Kenny: Do we have a category for extensions?

George: We have it in the revision of the Daisy Standard.

Geoff: I am totally uninterested in proprietary extensions to Daisy Online. They could perhaps be considered for the next version.

Kenny: Do we have an enhancement category already, george?

George: Yes.

Definition of Tasks to complete this document:

  1. Somebody needs to go through all the comments and determine what needs to be done.
  1. Finish off the list of assertions.
    1. Define test cases for each assertion.

George: The point of this exercise is to make sure that there are no major issues with the specification.

Geoff: Instead of testing conformance George, could we test for interoperability?

George: I think interoperability is the key.

Geoff: This means that we don't need to build test cases for quite as wide a variety of scenarios. I suggest we change the word Conformance to Interoperability.

Kenny: Can we call the document Interoperability Testing then?

Geoff: The format of this document could then be similar to the Systems Testing document.

(Consensus: Group agreed to rename the Conformance Testing document to Interoperability Testing, and reformat this document.)

#### [Systems Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolSystemTestingTestCases) ####

Geoff: We have two test cases that there are no implementations for. One of them is minor. Audio feedback is the major one. There are no client implementations of this feature.

Simon: I will do the audio feedback test.

Johan: I think someone needs to provide sample content for the other test case.

Geoff: The sample can be in any format as the content can be in any format. You can provide the first few chapters of a daisy book.

Johan: Will it be possible for me to provide a chapter out of a daisy book as sample content?

Geoff: Yes.

Johan: I will provide sample content then.

#### [Summary of Recommendations](http://code.google.com/p/daisy-online-delivery/wiki/SummaryOfRecommendations) ####

  * Should this document be a part of the test suite? This will mean that the test suite is composed of three documents: Conformance Testing, Systems Testing and Summary of Recommendations.

kenny: At first glance, due to the informative nature of this document, it does not appear to belong to the Test Suite. Thoughts all?

Geoff: This document could be provided after the spec is finalised.

## Related Wiki Pages ##

### [Change Log](http://code.google.com/p/daisy-online-delivery/wiki/ChangeLog) ###

### [PDTB2 Description for Daisy Online Implementers](http://code.google.com/p/daisy-online-delivery/wiki/pdtb2_description) ###

### [WSDL and XSD Tweaks for Daisy Online Implementers](http://code.google.com/p/daisy-online-delivery/wiki/WSDLAndXSDTweaks) ###