present: Jelle, Geoff, George, Nick, Simon, Johan and Kenny.

Regrets: Hiro, Dominik.

scribe: Kenny

## Action Item Summary ##

### New Action Items ###

  * geoff add informative verbiage to the spec that outlines the steps that need to be taken to synchronise content in an  out-of-band selection model.
  * Geoff change xsds to their canonical identifiers, and close [Issue 217](https://code.google.com/p/daisy-online-delivery/issues/detail?id=217). **done**
  * kenny eliminate the label attribute definition from the lastmark element in the bookmark xsd, and close [Issue 218](https://code.google.com/p/daisy-online-delivery/issues/detail?id=218). **done**
  * Johan make the required change to the ChangeLog, and close  [Issue 219](https://code.google.com/p/daisy-online-delivery/issues/detail?id=219). **done**
  * Geoff eliminate the import of the kxo and bookmark xsds in the do-types-10.xsd file, and close [Issue 220](https://code.google.com/p/daisy-online-delivery/issues/detail?id=220). **done**
  * Kenny add required definitions to the types xsd, and close [Issue 221](https://code.google.com/p/daisy-online-delivery/issues/detail?id=221).  **done**
  * johan close [issue 222](https://code.google.com/p/daisy-online-delivery/issues/detail?id=222) and [Issue 223](https://code.google.com/p/daisy-online-delivery/issues/detail?id=223). **done**
  * kenny add a feature request to the Daisy Issue Tracker for the next version of the spec that will enable a service to determine whether a Reading system intends to download or stream content, and close [Issue 224](https://code.google.com/p/daisy-online-delivery/issues/detail?id=224).
  * Geoff make required changes to Section 4.4.1 of the spec, and close [Issue 225](https://code.google.com/p/daisy-online-delivery/issues/detail?id=225). **done**
  * Johan and Kenny advice Nick on what sections he should work on in the Interoperability Testing document.
  * Johan, Nick and kenny work on the Interoperability testing document before the next telecon to produce the first draft.
  * Johan send an email to the group when his service is refreshed to the february version of the spec. **done**
  * kenny send Hiro an email advicing of the commencement of the systems testing.
  * Kenny add a feature request to the Daisy Issue Tracker to provide the summary of Recommendations document, accompanied with a summary of Requirements, in the maintenance phase of the spec.

> ### Previous Unfinished Action Items ###

  * Geoff eliminate the ambiguity around the use of the word "Content" in the spec, and close [Issue 211](https://code.google.com/p/daisy-online-delivery/issues/detail?id=211).
  * Geoff replace "invoke" with "call" for all its occurrences in the context of an operation, and close [Issue 212](https://code.google.com/p/daisy-online-delivery/issues/detail?id=212). **done**
  * Geoff remove unnecessary use of Notes from the spec, and close [Issue 213](https://code.google.com/p/daisy-online-delivery/issues/detail?id=213). **done**
  * Hiro provide Johan manufacturer and model key names for KXO generation. **done**
  * Simon, Jelle, Johan, Geoff and Hiro implement pdtb2 support in their test implementations by 8 March. **Johan: done**
  * Simon and Geoff reformat the Conformance Testing document, and rename it to Interoperability Testing.
  * Johan provide sample content in contentMetadata. **done**
  * Kenny add a normative assertion, that sets forth the invalidParameter fault as the consequence of a Reading System calling the getQuestions operation with the "back" id when no prior call to the getQuestions operation has been made in the active session, to the spec and the Interoperability testing documents.
  * Kenny add a normative assertion, that sets forth the invalidParameter fault as the consequence of a Reading System calling the getQuestions operation with the "back" and "search" IDs, when these IDs are not supported by a Service.
  * Kenny add substantive comments to issue tracker.
  * Kenny inform the owner of a substantive comment once the comment has been addressed.
  * Simon to add the minOccurs and maxOccurs tweak to the tweaks page.
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
  * Make a formal Recommendation to the board for approval that includes:
    * A one page document that contains the recommendation by the Wg including a link to the Spec, and a link to the Primer.
    * an appendix containing the systems testing report, and another containing the interoperability testing report.

## Agenda/Minutes ##

### soap faults ###

Kenny: Consensus check: Is everyone happy with leaving the spec as is in terms of soap faults, or would people prefer that the spec explicitly state that a Service must use the client and server soap fault classes in accordance with ws-i basic profile 1.1?

George: what are we changing?

jelle: We are not changing anything. We did not clarify what the value of the faultcode and faultstring elements should be  in the spec.

george: Have any comments been received as yet?

Kenny: No.

geoff: I am expecting the comments to come in towards the end.

George: this could be an internal comment by the wg after the Call for Review.

Nick: Aren't all the faults server faults?

geoff: Most of the faults are client faults.

Nick: I am with George on this.

Geoff: I don't see how adding assertions in the spec about the faultcode element adds value. Its only a recommendation in ws-i basic profile 1.1

Nick: We could get away with not making any change then?

(Consensus: the group decided to not make any changes to the spec, and leave the spec as is.)

### Issues ###

#### [Issue 216](https://code.google.com/p/daisy-online-delivery/issues/detail?id=216) ####

Geoff: We should spell out the steps that should be taken to synchronize content
in an out-of-band selection model.  This would be informative.

(consensus: group agreed.)

#### [Issue 217](https://code.google.com/p/daisy-online-delivery/issues/detail?id=217) ####

Johan: in bookmark-2005-1.xsd we should refer to the canonical URI of xml.xsd
instead of a local copy

Kenny: there is already an action item on me to change the local xsds to their cononical identifiers. given that the pdtb2 folks have now published the changes on the DC website, perhaps now is a good time to make this change?

Geoff: I have already begun to make this change.

#### [Issue 218](https://code.google.com/p/daisy-online-delivery/issues/detail?id=218) ####

Johan: according to
http://www.daisy.org/z3986/2005/Z3986-2005.html#li_440

lastmark element doesn't contain any attributes while in the bookmark
schema we have defined a label attribute

(consensus: Group agreed to remove the label attribute from the lastmark element in the bookmark xsd.)

#### [Issue 219](https://code.google.com/p/daisy-online-delivery/issues/detail?id=219) ####

Johan: according to the [ChangeLog](ChangeLog.md)
ncxRef and charOffset has been changed from
empty complex types to xs:stringS while they are defined as xs:anyURI and
xs:long in the schema

Geoff: This is a problem with the [ChangeLog](ChangeLog.md),
not the schema.

Johan: I will fix the change log.

#### [Issue 220](https://code.google.com/p/daisy-online-delivery/issues/detail?id=220) ####

Johan: the "bookmark" and "KeyExchange" schemas are imported in do-types-10.xsd
although we don't refer to any elements in these schemas from it

(consensus: given that these schemas are already imported in the wsdl file, group agreed to eliminate the imports in the do-types-10.xsd file.)

#### [Issue 221](https://code.google.com/p/daisy-online-delivery/issues/detail?id=221) ####

Johan: no types have been defined for
  * contentMetadata/metadata/meta@name
  * contentMetadata/metadata/meta@content
    * contentMetadata@category

I suggest we assign a type for these. depending on the use we can choose
between xs:string, xs:anySimpleType, or xs:anyType

(Consensus: group agreed to add these definitions to the types xsd.)

#### [Issue 222](https://code.google.com/p/daisy-online-delivery/issues/detail?id=222) ####

Johan: as of now the keyRing element is top-level element although it's no longer
a top-level element

Geoff: Let's not.  It's a wart, but it works fine as-is.

(Consensus: Group agreed to not make any change to the spec.)

#### [Issue 223](https://code.google.com/p/daisy-online-delivery/issues/detail?id=223) ####

Johan: should we make a note that the service must include the firstItem and
lastItem attributes in a response when the RS request a partial content list

Geoff: I think thats necessary.

geoff: Its already mentioned in the definition of the contentList.

(consensus: group agreed to leave the spec as is.)

#### [Issue 224](https://code.google.com/p/daisy-online-delivery/issues/detail?id=224) ####

Johan: This proposal is to add an indicator so that service providers can
distinguish between downloading and streaming devices.

Johan: There are currently no means for a service provider to distinguish between
downloading and streaming devices. As a service provider, if I have many users
simultaneously trying to retrieve a content, I would like to redirect streaming
devices to a server where where bandwidth is available while downloading devices are
directed to a server where they all have to share the available bandwidth.

This might not be a requirement for the protocol but would make a nice feature for
service providers.

A solution to address this feature would be to add an parameter to the
getContentResources operation indicating what the RS is intending to do.

E.g. getContentResources("some id", "stream")

geoff: This is a duplicate of
> [issue 94](https://code.google.com/p/daisy-online-delivery/issues/detail?id=94) .

Geoff: This question came up in our face to face in July. Why we did not implement is because we were thinking of it from a legal perspective. In japan there was a restriction on the number of copies you could hold for downloading or streaming. We thought we would wait for other such restrictions. Its a good technical point though.

Nick: Could it be a reading system attribute for a future version?

Simon: The reading systems could always offer an option to the user to download/stream.

Nick: Can we log it as a feature request for the next version of the spec?

kenny: George, can we add this to the Daisy Issue Tracker?

George: yes.

(Consensus: Group agreed to add this as a feature request for the next version of the spec in the Daisy Issue Tracker.)

#### [Issue 225](https://code.google.com/p/daisy-online-delivery/issues/detail?id=225) ####

Johan: In Section 4.4.1 Content Retrieval Sequence, the first operation is:

"1. The  getContentMetadata   operation must be called to obtain
information about the Content. The returned metadata includes publication
information, file format and size and may include the return status and date."

- return status is required
- contentMetadata does not contain a date attribute anymore and should be
removed

(Consensus: Group agreed to implement Johan's recommendations.)

### Test suite Progress review ###

#### [Interoprability Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolInteroperabilityTesting) ####

Geoff: I have put together a fairly basic interoperability testing page. I went through each section of the spec to do this. I have filled out almost everything in the API reference. haven't done protocol fundamentals as yet. I would like someone else to take over.

Johan: I can help.

Kenny: I will give you a hand with this.

Geoff: Some of the elements in this document are not testable e.g. session duration.

Johan: I will work on this document before the next telecon. I will not be present on the next telecon though.

#### [Systems Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolSystemTesting) ####

Simon: Are we going to have a code freeze on the Service side before starting to fill the tests in.

Geoff: When systems testing starts, everyone should be on the february version of the spec.

Geoff: I think the systems testing can start right now.

Johan: My service is as per the september version. I have not released a new version as yet. In 2 days, there will be a new fresh version.

Simon: I will start filling up the  wiki page right away.

Jelle: I will send my test results to Geoff.

Geoff: I don't have the keyExchangeObject operation implemented. It will be done very soon.

Johan: the sample KXOs are now complete.

(Group agreed to commence systems testing now.)

#### [Summary of Recommendations](http://code.google.com/p/daisy-online-delivery/wiki/SummaryOfRecommendations) ####

Geoff: this should be deferred to after the spec is finalised. We should also have a summary of requirements to go with this.

(consensus: group agreed to move forward with geoff's recommendation.)

## Related Wiki Pages ##

### [Change Log](http://code.google.com/p/daisy-online-delivery/wiki/ChangeLog) ###

### [PDTB2 Description for Daisy Online Implementers](http://code.google.com/p/daisy-online-delivery/wiki/pdtb2_description) ###

### [WSDL and XSD Tweaks for Daisy Online Implementers](http://code.google.com/p/daisy-online-delivery/wiki/WSDLAndXSDTweaks) ###

## telecons before the formal submission to the Daisy board for endorsement ##

The group decided that four further telecons will be held before the formal submission to the Daisy board for endorsement on:
  * 10 march 2010.
  * 17 march 2010.
  * 24 march 2010.
  * 31 march 2010.