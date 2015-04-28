present: Hiro, Simon, Geoff, Johan and Kenny.

Regrets: jelle

scribe: Kenny

## Action Item Summary ##

### New Action Items ###

  * Johan clarify in the spec that if service supports audio labels and reading system requires them, service must provide them. If service does not support audio labels and reading system requires them, it is up to reading system to decide whether it wants to continue with the session. **done**
  * Kenny close [Issue 191](https://code.google.com/p/daisy-online-delivery/issues/detail?id=191). **done**
  * Kenny add elementFormDefault="qualified" to the bookmark xsd, and close [Issue 232](https://code.google.com/p/daisy-online-delivery/issues/detail?id=232).  **done**
  * Geoff clarify in the spec that it is up to a Service to decide whether it wants to link a soap session with the downloading/streaming of content, and close [Issue 233](https://code.google.com/p/daisy-online-delivery/issues/detail?id=233). **done**
  * geoff clarify in the spec that the content id passed into the getContentMetadata operation must be the same as the dc:identifier in the returned contentMetadata type, however, the dc:identifier does not need to be the same as the actual publication identifier, and close [Issue 234](https://code.google.com/p/daisy-online-delivery/issues/detail?id=234). **done**
  * Geoff inform the group on his availability for the conformance testing document. **Geoff: I have two days (16 hours) I can spare for this.**
  * Kenny post to the list asking for volunteers for the Conformance testing document. **done**
  * Johan, Geoff, Simon and Kenny complete all their action items before the end of the week (26 march 2010). **geoff:done, kenny:done, johan:done**
  * Johan, Geoff (types reference and API) and kenny to proof read the spec before the next telecon. **geoff: done, kenny: done**
  * Johan and kenny to proof read the primer before the next telecon. **kenny: done**
  * Kenny ask markus and Nick if they can proof read the spec and primer before the next telecon. **done**
  * Simon ask colleagues in HumanWare if they could proof read the spec and primer before the next telecon.
  * johan, Geoff and Kenny to inform the group once their action items are complete to commence the proof reading. **geoff:done, kenny:done, Johan: done**
  * geoff clarify in the spec that issueContent/returnContent should return true even if the content has been issued/returned before, and close [Issue 235](https://code.google.com/p/daisy-online-delivery/issues/detail?id=235). **done**
  * Kenny add a feature request to the Daisy Online issue tracker on the Daisy Website for an optional content-type attribute, and close [Issue 236](https://code.google.com/p/daisy-online-delivery/issues/detail?id=236). **done**

> ### Previous Unfinished Action Items ###

  * Jelle talk to Geoff offline about the Systems Testing report.
  * geoff add informative verbiage to the spec that outlines the steps that need to be taken to synchronise content in an  out-of-band selection model. **done, should be proofread**
  * Simon to add the minOccurs and maxOccurs tweak to the tweaks page.
  * Kenny add substantive comments to issue tracker. **no comments received**
  * Kenny inform the owner of a substantive comment once the comment has been addressed. **no comments received**
  * Markus fix the &apos; entity problem. (outstanding; bug in IE.) (Markus will fix this when ready to publish.)

### Group Action Items ###

#### Action items for formal recommendation to the Board on April 5, 2010 ####

  * Deliver Final version of the spec.
  * Provide Information on comments Received, and how they were addressed.
  * Make Available the Systems Testing document.
  * make available the systems testing  Conformance report.
  * Make a formal Recommendation to the board for approval that includes:
    * A one page document that contains the recommendation by the Wg including a link to the Spec, and a link to the Primer.
    * an appendix containing the systems testing report.

## Agenda/Minutes ##

### Calculating range header values from the SMIL clipBegin/clipEnd attributes ###

Nick: If a reading system wishes to request parts of an audio resource how does it calculate the values for the range header from the smil clipBegin / clipEnd attributes?

Currently the only way I can think of is to request the first few bytes, parse / calculate the bitrate / byterate and then request the range required.

Should we add an attribute to the resource element containing the bit / byte rate?

Should this information be part of the content / including in the `<audio>` tag of the smil in future Daisy standards?

What happens with variable bit rate encoding which I beleive is allowed in later Daisy versions and could be in other content types?

Am I missing something?

This is less of a problem with offline reading systems as they will have the entire resouce locally.

Mark: I don’t believe having the bit rate will be enough. Even assuming a constant bit rate, you still need to know the offset where the actual encoded frames start. About the only files that don’t require this would be mp3 with no id3 tags at all. Other audio formats (remember there are ongoing activities to add codecs to Daisy) might actually store the header information at the end (anything using the iso file format might store the metadata anywhere but typically at the start or end).

Also worth mentioning, in the case of a PDTB2 book with encrypted audio, the system can’t start decrypting from anywhere in the file. It must do so from a AES block aligned data (16 bytes if I recall) so that complicates things even further.

Simon: I suggest we leave it to the Reading Systems, and don't say anything about this in the spec.

Geoff: I think we discussed this at the first face to face. Reading systems getting byte ranges from the disk is not very different from a web scenario.

Simon: I don't think we can come up with a way to calculate byte ranges that fits all.

Geoff: I suggest we stay silent about this in the spec.

Johan: I agree.

Kenny: Me too.

(Consensus: The group decided to stay silent about the calculation of byte ranges. It is up to the Reading systems to work out the most effective way to do these calculations.)

### Issues with Audio Labels ###

Johan: What is supposed to happen in a scenario where the service does not support audio labels and the reading system requires audio labels?

Should the readingSystem be able to establish a session? Suppose that the service supports Dynamic Menus and Announcements, should the service throw a fault when operation getQuestions or getServiceAnnouncements is called? Should the service disregard this information and send responses not containing audio

What is your thoughts?

Geoff: I thought we had agreed to the behaviour at the July face-to-face meeting, but it looks like we just waffled.

http://code.google.com/p/daisy-online-delivery/wiki/TorontoF2F2009Minutes#TTS

Note that the question was only about announcements and menus.  I don't know if we'd added the label elements to content lists by then.

I think the session should not start, since we use labels for everything.  It should be the reading system's responsibility to check the serviceAttributes to see if the service supports audio labels before continuing initialization.  If a service does not support audio labels and a reading system declares in its readingSystemAttributes that it requires them, then the service should throw an invalidParameter fault.

Simon: I suggest we let the Reading systems handle this. A Reading system retrieves the service attributes before it posts its reading system attributes. It can decide when it retrieves the service attributes whether it wants to proceed with the session or not.

Johan: I agree. We can leave it to the Reading systems to decide whether they want to continue with a session or not.

Kenny: should we say something to this affect in the spec?

Geoff: We will need to change the definition of requiresAudioLabels then. I suggest we say the following:
If Service supports audio labels and Reading system requires audio labels, service must provide audio labels. If a Service does not support audio labels and reading system requires audio labels, it is up to reading system to decide whether it wants to continue with the session.

(Consensus: Group decided to go forward with Geoff's proposal. )

### Issues ###

#### [Issue 191](https://code.google.com/p/daisy-online-delivery/issues/detail?id=191) ####

Kenny: This issue refers to the definition of a test suite. Can this now be closed?

(Consensus: Group agreed that this issue can now be closed in the Daisy Online Issue tracker on google code. This issue has already been logged as a feature request in the Daisy Online issue tracker on the Daisy website.)

#### [Issue 232](https://code.google.com/p/daisy-online-delivery/issues/detail?id=232) ####

Jelle: I needed to add elementFormDefault="qualified" (in bookmark-2005-1.xsd) to
the `<xs:schema>` to make my soap client and server use correct namespaces in
setBookmarks and getBookmarks calls.

Johan: the types schema has elementFormDefault="qualified" already defined.

(Consensus: Group agreed to add elementFormDefault="qualified"  to the bookmark xsd.)

#### [Issue 233](https://code.google.com/p/daisy-online-delivery/issues/detail?id=233) ####

Johan: The note in section 4.4.2 says "A Reading System does not require an active
Session to access Content."

This is a security risk for services offering the service only via HTTP. If
the user credentials get sniffed the resources might be downloaded and
distributed to the public on other networks.

Suggestion: we remove the note.

Geoff: It's not a bug, it's a feature.  Service providers offering content or service via
HTTP have to accept the risks of using an insecure transfer protocol.

Johan: If I as service provider believe that HTTPS will dramatically decrease the
performance of the service, but still keep the content as secure as possible, can I
change the credentials when the user initialize a new session?

Geoff: The way my service is set up, it is very dificult for me to link the soap session with the downloading/streaming of content.

Kenny: Its the same in our service. soap sessions are completely independent of the downloading/streaming of content.

Johan: Currently, our service generates a session password, and embeds the username + the session password in the basic authentication field (i.e. http|https://username:sessionpassword@domain.com/....) in the urls of resources in contentResources.

(Consensus: group agreed to leave it up to the Service to decide whether it wants to link the soap session with the downloading/streaming of content.)

#### [Issue 234](https://code.google.com/p/daisy-online-delivery/issues/detail?id=234) ####

Johan: In section 5.1.6 the contentID parameter is defiened as

"Contains the Content Identifier of the Content item for which the
resources list is being requested (as defined in the [Core](Dublin.md)
identifier  field of the contentMetadata)."

I thought that the service could use arbitrary IDs for contents.

Geoff: The wording is perhaps unclear here: the contentMetadata has to contain the content
ID in it's dc:identifier field.  getContentResources also uses the content ID.  I
think we can remove the parenthetical, since content ID is defined in the glossary.

Johan: Just to clarify this. If the 'dc:identifier' value is xxx-yyyy-zzzz, can I as a
service provider use an arbitrary id e.g. aaa\_b for this content? The RS must then
use this id in calls to getContentMetadata, issueContent, getContentResources and
returnContent.

Johan: there may be different content ids for a particular piece of content e.g. different content id for the acquisition and lending models.

Geoff: the content identifier passed into the getContentMetadata operation must be the same as the dc:identifier in the returned contentMetadata type. However, the dc:identifier does not need to be the same as the actual publication identifier.

(consensus: Group agreed to move forward with Geoff's proposal.)

#### [Issue 235](https://code.google.com/p/daisy-online-delivery/issues/detail?id=235) ####

jelle: issueContent for already issued content

What should the service respond ?
At first I thought an "invalidParameter" should be best.
However when further implementing the menus it struck me that a RS might indeed issue some content again.

I think that indeed a "true" response might be best. This way a RS knows that its attempt to issue the content has
succeeded and thus the reading system does not need to take additional actions.

(consensus: Group agreed that issueContent and ReturnContent should return true even if the content has been issued/returned before.)

#### [Issue 236](https://code.google.com/p/daisy-online-delivery/issues/detail?id=236) ####

jelle: A reading system may send other formats than "RIFF WAVE" to the service.
Should the data not have an (optional) "Content-Type" attribute that
identifies the content.
NOTE: I guess that a service will be able to determine it anyway by looking
at the data.

Kenny: I think it is too late to be adding attributes. Perhaps this could be a feature request for the next version of the spec?

Geoff: I agree.

Simon: I agree too.

Johan: Me too.

(Consensus: Group agreed to leave the spec as is and add a feature request to the Daisy Online issue tracker on the Daisy website for the next version of the spec.)

### Test suite Progress review ###

#### [Interoprability Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolInteroperabilityTesting) ####

Kenny: If the Interoperability Testing document was not to be ready before the Daisy Online Wg submission on the 1st of April, would Humanware, Plextor support this submission? There is now a feature request in the Daisy Online Issue Tracker on the Daisy Website for a full-fledged Conformance Testing document, to be created in the maintenance phase of the spec:
http://www.daisy.org/online-delivery/issues/provide-conformance-testing-document-maintenance-phase-spec

Hiro: Yes, we will support the submission.

Simon: If everything goes well with the System Testing, we will support the submission without the Interoperability Testing document.
This feature request should be addressed as soon as possible.

Kenny: Do we have complete consensus then to drop the Interoperability Testing document for this version of the spec, and work on a Conformance Testing Document in the maintenance phase? Is everyone happy to support the submission without the Interoperability Testing document?

simon: I have a major concern that the conformance Testing document may not be done, which may lead to a lot of interoperability issues with new services.

Kenny: who will be participating in the work on this document?

Hiro: I will dedicate ten percent of my time to it.

simon: 10% for me too.

Johan: I will dedicate 20% of my time to this.

Kenny: 10% for me.

Geoff: I will find out what percentage of my time I can dedicate to this.

(Consensus: Group agreed to drop the interoperability testing document for this version of the spec. all group members are willing to support the submission of the spec to the daisy board next week without this document.)


#### [Systems Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolSystemTesting) ####

### Health check, and Timelines for the next week ###

  * Complete all action items.

Geoff: will close all of mine before the end of this week.

Johan: will complete mine in 24 hours.

Simon: I will finish mine before the end of the week too.

Kenny: I will have mine done before the end of the week too.

(group agreed to wrap up all action items before the end of the week.)

  * Close all issues. For the deferred issues, move them to the Daisy Online issue tracker on the Daisy website.

Geoff: I will have the two cleanup issues closed before the end of the week.

(Group agreed to close all issues before the next telecon.)

  * Proof read the spec.

kenny: Who will be participating in the proof reading?

(Johan, Geoff (types Reference and API) and Kenny will be proof reading the spec before the next telecon.)

  * proof read the Primer.

Who will be participating in proof reading the Primer?

(Johan and Kenny will be proof reading the Primer before the next telecon.)

  * Complete the systems Testing report.

Geoff: I won't be able to complete the systems testing report if all the test result data is not with me by the next telecon. I will have the report structurally ready by the next telecon. Lets discuss the report then.

  * Final submission

Kenny: Will prepare it immediately after the last telecon on the 31st of March and post it to the list for endorsement. Are 24 hours enough for everyone to post their endorsement or objection to the list? If there were no objections, we could get the submission to Bernhard on the 2nd of April.

(Consensus: the group agreed that a 24 hour period will be sufficient to raise any objections. kenny will prepare the submission. Geoff will prepare the systems testing report. the report will be added as an appendix to the submission and posted to the list for approval/objections on the 1st of april. After 24 hours, if there are no objections received, the submission will be sent to bernhard with the formal WG recommendation on the 2nd of april.)