present: Johan, Hiro, Nick, Geoff, Dominik, Simon and Kenny.

Regrets: George and Markus.

scribe: Kenny

## Action Item Summary ##

### New Action Items ###

  * Kenny to follow up with James and Neale the status of the two required fixes in the pdtb2 spec: Reg Exp and Example/xsd inconsistency.
  * kenny to send Nick an email containing all the svcutil specific tweaks.
  * Nick, Hiro, Johan and Kenny to review the Systems Testing document and post their comments/participation intentions  on the page or on the list before the next telecon.
  * Nick, Johan, Simon, Hiro and Jelle to review the Conformance Testing document, post their comments on the page or the list, and add test cases.
  * Hiro and Jelle to send their public keys to the service implementers.
  * Simon and Hiro to send their email addresses to kenny to be added as Project comittors.
  * Kenny to ask Mark/Neale: What format is the private key encrypted in in the KxO? Record this information in the pdtb2\_description page.
  * Johan to provide the RS specific KXOs to the service implementers.
  * Simon to add the minOccurs and maxOccurs tweak to the tweaks page.
  * Geoff clarify in the spec that the Expired `contentList` should only be used in exceptional circumstances and is not required to contain overdue items (i.e. returnBy date < currentDate).
  * Geoff to remove the recommendation that states the markAnnouncementsAsRead operation should be called every time an announcement is rendered to a user.
  * Nick, Johan, Kenny and Geoff to proof read the spec documentation before Feb 15.

> ### Previous Unfinished Action Items ###

  * Geoff to record an issue in the issue tracker for the setBlob/getBlob operations as suggested by Jelle, and mark this issue as an enhancement for the next version of the spec.
  * kenny to make the required cosmetic change to section 4.4.3, and present it to the group for review.
  * Kenny to reflect all the changes recorded in the change log in the Dynamic Menus Primer. **tentative: should be done by the telecon on 10 february**
  * Geoff, Johan, Simon, Hiro and Kenny to build PDTB2 support in their test implementations by end March using the sample content provided by Neale.
  * After the pdtb2 folks have fixed their version of kxo.xsd, kenny to change XSDs to their canonical URIs, and close [issue 128](https://code.google.com/p/daisy-online-delivery/issues/detail?id=128) and [Issue 144](https://code.google.com/p/daisy-online-delivery/issues/detail?id=144).
  * Markus fix the &apos; entity problem. (outstanding; bug in IE.) (Markus will fix this when ready to publish.)

### Group Action Items ###

#### Action items for the public review period commencing February 15, 2010 ####

  * All issues should be resolved or formally deferred.
  * Any updates to the spec documentation, wsdl and xsd files need to be completed and proof read.
  * The primer should be proof read.
  * The Conformance Testing and The Systems Testing documents should be made available.

#### Action items for formal recommendation to the Board on April 5, 2010 ####

  * Deliver Final version of the spec.
  * Provide Information on comments Received, and how they were addressed.
  * Make available the Conformance Testing Conformance Report.
  * make available the systems testing  Conformance report.
  * Create an area where implementers can post information about the additional features that they have implemented on top of the spec, and that the community at large may be interested in.
  * Make a page available that provides PDTB2 specific knowledge to Daisy Online Implementers.
  * Make a page available that provides all the tweaks to the WSDL and XSD files, that group members had to make to these files for their respective implementations.
  * Make a formal Recommendation to the board for approval.

## Agenda/Minutes ##

### PDTB2 support in Daisy Online ###

#### Do we have consensus? ####

As no objections have been received on the suggested approach, there is consensus among group members that we should move forward with the suggested approach i.e. moving keyRing to readingSystemAttributes and removing the keyRing parameter from the getKeyExchangeObject operation. Geoff has already reflected this decision in the wsdl and xsd files.

### [Issue 188](https://code.google.com/p/daisy-online-delivery/issues/detail?id=188), 190, 201 and 203 ###

#### Can we close all these four issues now? ####

As no issues have been reported thus far, pertaining to the changes made to address each of these four issues, the group has unanimously agreed to close these four issues.

Geoff: I propose that no further changes be made to the spec from hereon in, given that we have less than two weeks left to the public review phase.

Kenny: I agree.

The group agreed to freeze the spec pending feedback received in the public review phase. The group will only entertain bug fixes in the feedback received.

Geoff: I propose we also close [Issue 94](https://code.google.com/p/daisy-online-delivery/issues/detail?id=94). We wanted to wait till the end of the Test Implementation Phase to determine whether this issue should be dealt with. Given no comments have been received thus far requesting us to make a distinction between the issuance of content for downloading and streaming, I suggest we close this issue.
Johan: I agree.

Nick: I agree.

There was consensus in the group that [Issue 94](https://code.google.com/p/daisy-online-delivery/issues/detail?id=94) should be closed.

### Suggestion to move minOccurs and maxOccurs attributes to the parent sequence element in the xsd to deal with an svcutil issue ###

#### Discussion on the list ####

Simon: There is an issue with svcutil when trying to generate code for “array” element.

There are 3 places (announcements, userResponses and read) in do-types-10.xsd where an element is defined with a single item element that as the maxOccurs=”unbounded” set. This translate into a type that is an array of items.

Moving the minOccurs and maxOccurs to the parent <xs:sequence ...> tag seems to solve the issue. And it’s still translated into the same type since there is only one element in the sequence.

Here’s what I propose:

Before:



&lt;xs:element name="announcements"&gt;



> 

&lt;xs:complexType&gt;



> 

&lt;xs:sequence&gt;



> 

&lt;xs:element name="announcement" minOccurs="0" maxOccurs="unbounded"&gt;



> ...

> 

&lt;/xs:element&gt;



> 

&lt;/xs:sequence&gt;



> 

&lt;/xs:complexType&gt;





&lt;/xs:element&gt;







&lt;xs:element name="userResponses"&gt;



> 

&lt;xs:complexType&gt;



> 

&lt;xs:sequence&gt;



> 

&lt;xs:element name="userResponse" minOccurs="1" maxOccurs="unbounded"&gt;



> ...

> 

&lt;/xs:element&gt;



> 

&lt;/xs:sequence&gt;



> 

&lt;/xs:complexType&gt;





&lt;/xs:element&gt;





&lt;xs:element name="read"&gt;



> 

&lt;xs:complexType&gt;



> 

&lt;xs:sequence&gt;



> 

&lt;xs:element ref="item" minOccurs="0" maxOccurs="unbounded"/&gt;



> 

&lt;/xs:sequence&gt;



> 

&lt;/xs:complexType&gt;





&lt;/xs:element&gt;



After:



&lt;xs:element name="announcements"&gt;



> 

&lt;xs:complexType&gt;



> 

&lt;xs:sequence minOccurs="0" maxOccurs="unbounded"&gt;



> 

&lt;xs:element name="announcement"&gt;



> ...

> 

&lt;/xs:element&gt;



> 

&lt;/xs:sequence&gt;



> 

&lt;/xs:complexType&gt;





&lt;/xs:element&gt;







&lt;xs:element name="userResponses"&gt;



> 

&lt;xs:complexType&gt;



> 

&lt;xs:sequence minOccurs="1" maxOccurs="unbounded"&gt;



> 

&lt;xs:element name="userResponse"&gt;



> ...

> 

&lt;/xs:element&gt;



> 

&lt;/xs:sequence&gt;



> 

&lt;/xs:complexType&gt;





&lt;/xs:element&gt;







&lt;xs:element name="read"&gt;



> 

&lt;xs:complexType&gt;



> 

&lt;xs:sequence minOccurs="0" maxOccurs="unbounded"&gt;



> 

&lt;xs:element ref="item"/&gt;



> 

&lt;/xs:sequence&gt;



> 

&lt;/xs:complexType&gt;





&lt;/xs:element&gt;



From what I understand, this is a bug with Microsoft tool and not with the xsd. But since both form are valid, I suggest we make the change.

Johan: Doesn't work with my tools.

I think we should keep the syntax consistent. Mixing things up in schemas gives an impression of a sloppy work. Since Microsoft's tool seems to understand array elements for other types I think it would be better to report this issue to Microsoft and let them to fix the bug.

Kenny, do you also have the same problem?

Kenny:Yes we do. Moving minOccurs and maxOccurs to the sequence element solves the problem for us too. In fact, we have followed Simon's lead to resolve this issue in our implementation.

I propose we record the fix for the Microsoft toolkit as a tweak, and add it to [1](1.md), but not modify the xsd for semantic correctness and maximum interoperability.
[1](1.md) http://code.google.com/p/daisy-online-delivery/wiki/WSDLAndXSDTweaks

Nick: I am happy with recording this in the tweaks page.

Simon: I understand the semantic inconsistency this tweak will cause if added to the xsd. I am happy with adding this tweak to the tweaks page.

The group agreed to add this tweak to the tweaks page.

### Is a Service required to provide an "expired" `contentList` in the Lending Model ###

Kenny: Section 4.1.1.1 states:
"
...
• offer the issued
contentList
"

Is a Service required to also offer an "expired" `contentList` in this model?

This section then states:
"
...
• if issued,the Content item must be listed in either the User's issued or expired contentList until it is returned
...
"

Do we need to be more specific on when the content appears in the "issued" and "expired" `contentList`(s)?

Geoff: The answer is no, the "expired" contentList is not required.  We do not need to be more specific; I believe when content is on which list is covered in
the rest of the documentation.

Kenny: I think if we make it mandatory for service providers to have all the content that is over due listed in the expired `contentList`, along with other content that the service wants to render expired, this should benefit the RS implementers.

Geoff: Currently, a Reading System is not required to support the expired list. This will create a false expectation for Service implementers that the RS honours the expired `contentList`. If a Service wants to ensure content expiration, it should use PDTB2.

Simon: My understanding was that the expired `contentList` only contained content that was over due i.e. returnBy date older than current date.

Geoff: Expired `contentList` was for exceptional circumstances. Automatic book deletion based on this list is not required by the spec for Reading Systems.
Simon: i propose we make this clear in the spec.

Group agreed that the Expired `contentList` should not be required, and should only be used in exceptional circumstances. Where a Service wants to implement content expiration, it should use PDTB2.

### marking multiple Announcements as Read ###

kenny: Section 4.5.2 states:
"
...
After rendering each announcement to a User, a Reading System should immediately invoke the
markAnnouncementsAsRead operation to inform the Service not to send the announcement again the next time the User connects to the Service.
...
"

The read parameter to the markAnnouncementsAsRead operation is capable of holding more than one announcement IDs. Should we modify the verbiage to make it clear that an RS can mark multiple announcements as read through the markAnnouncementsAsRead operation, and that it does not need to invoke this operation after rendering every individual announcement to the user?

Geoff: No, it should be immediate.  It's just a recommendation, however, so Reading Systems can have their own behaviour here.

Simon: I don't see why you would call the markAnnouncementsAsRead operation every single time you render an announcement to the user.

Geoff: Should we remove the recommendation then?

The group agreed to remove the recommendation.

> ### Spec update review ###

#### Timelines going forward ####

  1. documentation including the wsdl and xsd files. (to be made available by Feb 15)
  1. Primer. (available with the change log reflected by 10 Feb)
  1. systems testing and Conformance Testing documents. (to be made available by Feb 15)
  1. Conformance Testing Conformance Report (Deferred to end March)
  1. Systems Testing Conformance report (deferred to end March)

Geoff: Feb 15 is a public holiday in Toronto. I will try to wrap everything up before the end of next week.

### Test suite Progress review ###

#### [Test Suite](http://code.google.com/p/daisy-online-delivery/wiki/tsg_test_suite) ####

  * Should assertions be defined for elements/attributes in the types that are necessary for a Reading System to understand, to determine whether a Service supports a particular feature of the spec e.g. getBookmarks, setBookmarks ...?

> The group decided to drop these assertions from the RS conformance area in the Conformance Testing document, and reconsider adding these assertions if anyone asks for them in the public review phase.

#### [Systems Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolSystemTestingTestCases) ####

Geoff: I'd like to start filling in who does what in the system testing.  Since the protocol is client-driven, it will mostly be client developers running the tests.  I'll try to spread the tests out evenly among the client developers who participate.

I need both client and server developers to send me a list of which tests you are going to be capable of performing (something like, "All except X, Y and Z," is fine, too).  I'll do some kind of mix-and-match and send out the assigned tests for confirmation.

Realistically, we have until near the end of March to do the testing.  However, I'd like to get started as early as possible: when the protocol is finalized and implementors have integrated the changes into their systems.  It would be nice if test reports trickled in as they get done, rather than as a huge lump at the end, so we can watch the progress and reassign tests if needed.

## Related Wiki Pages ##

### [Change Log](http://code.google.com/p/daisy-online-delivery/wiki/ChangeLog) ###

### [PDTB2 Description for Daisy Online Implementers](http://code.google.com/p/daisy-online-delivery/wiki/pdtb2_description) ###

### [WSDL and XSD Tweaks for Daisy Online Implementers](http://code.google.com/p/daisy-online-delivery/wiki/WSDLAndXSDTweaks) ###