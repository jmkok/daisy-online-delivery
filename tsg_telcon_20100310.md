present: Jelle, Geoff, Hiro, Simon and Kenny.

Regrets: George.

scribe: Kenny

## Action Item Summary ##

### New Action Items ###

  * Kenny clarify in the spec that the logOff operation can be called within the session innitialisation sequence, and close [Issue 227](https://code.google.com/p/daisy-online-delivery/issues/detail?id=227).
  * Geoff clarify in the spec that a cookie can be issued even when the logOn operation is unsuccessful, and close [Issue 228](https://code.google.com/p/daisy-online-delivery/issues/detail?id=228).
  * Kenny talk to Johan about the markAnnouncementsAsRead operation. **done**

> ### Previous Unfinished Action Items ###

  * geoff add informative verbiage to the spec that outlines the steps that need to be taken to synchronise content in an  out-of-band selection model.
  * kenny add a feature request to the Daisy Issue Tracker for the next version of the spec that will enable a service to determine whether a Reading system intends to download or stream content, and close [Issue 224](https://code.google.com/p/daisy-online-delivery/issues/detail?id=224). **done**
  * Johan and Kenny advice Nick on what sections he should work on in the Interoperability Testing document.
  * Johan, Nick and kenny work on the Interoperability testing document before the next telecon to produce the first draft.
  * Kenny add a feature request to the Daisy Issue Tracker to provide the summary of Recommendations document, accompanied with a summary of Requirements, in the maintenance phase of the spec. **done**
  * Geoff eliminate the ambiguity around the use of the word "Content" in the spec, and close [Issue 211](https://code.google.com/p/daisy-online-delivery/issues/detail?id=211).
  * Simon, Jelle, Johan, Geoff and Hiro implement pdtb2 support in their test implementations by 8 March. **Johan: done**
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

### Issues ###

#### [Issue 227](https://code.google.com/p/daisy-online-delivery/issues/detail?id=227) ####

Jelle: The spec mentions: "A return value of false or an issued fault both indicate that the operation was not
successful."
So any other response could actually mean that the reading system is still logged in.
I do not think this is acceptable/useful for a logOff command, and could confuse the reading system.

logOff should return true after a successful logOn (regardless of any other commands)
logOff should throw noActiveSessionFault if the RS was already logged off

Geoff: I am happy with it. We just need to clarify what happens if logOff is called between a session innitialisation sequence. Lets add a note in the sequence saying that you can call logOff within the sequence.

(Consensus: group agreed to move forward with Jelle's suggestion.)

#### [Issue 228](https://code.google.com/p/daisy-online-delivery/issues/detail?id=228) ####

Geoff: The first note in section 3.1 says, "An established HTTP session is not in
itself a valid indicator that a Reading System has successfully logged on
to the Service ...."

But a session isn't established until a successful logOn.  I'm pretty sure
this note is incorrect or out-of-date.

Geoff: We say in section 4.2.2 that session begins after logOn and ends after logOff.

Jelle: In terms of a reading system, it does not matter, but for a service its extra work to issue a cookie after the logOn operation was successful. Most of the frameworks issue a cookie when a client connects before any operation is called.

Geoff: We should probably change the spec to say that a service determines when a session starts and ends. Sessions are identified to a reading system with a cookie. The common uses should be covered by this.

Kenny: Given that the Daisy Online Service is a soap-based web service, wouldn't it be true that the first time an RS communicates with a Service in a session would be when it calls the logOn operation?

Geoff: Yes.

Kenny: Then the problem we are dealing with would be that most frameworks would issue a cookie even if the logOn operation was unsuccessful, Right?

Jelle: Yes. We should draw a distinction between an http session and a soap session.

Geoff: There is no difference between the two types of sessions. In my service I create a session id when the logOn operation is successful, and delete it when the logOff operation is called.

Jelle: I do the same.

(Consensus: Group agreed to move forward with allowing a cookie to be issued even when the logOn operation is unsuccessful.)

#### [Issue 229](https://code.google.com/p/daisy-online-delivery/issues/detail?id=229) ####

If markAnnouncementsAsRead is called with multiple ids, and one of those ids
is invalid, it is not exactly clear/defined what should happen.
I guess, the function should at return "invalidParameterFault" as one of the
parameters is invalid, but then the service should not mark any of the other
messages as read.
Might it not be simpler to just limit the operation to one message at a
time.

Kenny: My only concern is the round trip time for each call to the markAnnouncementsAsRead operation.

Jelle: There should not be more than a few announcements per day.

Kenny: We need to make a change. This is most definitely a significant issue. The markAnnouncementsAsRead operation currently allows multiple announcement IDS to be passed in as a parameter. If one of these IDs are invalid, the Service will need to throw an invalidParameter fault, but there is no way for the Reading System to know what announcements were marked as read successfully.

Jelle: We could either say in the spec that only one id should be passed into the operation, or change the operation definition to allow only one string or nmtoken parameter.

Geoff: I am not opposed to a change to the wsdl.

Simon: I am not in favour of changing the wsdl file at this stage as we will need to wait for all services to implement this for testing.

Geoff: Pratsam, Vision Australia, Humanware and solutions radio are assigned to do the test pertaining to this operation.

(Group decided to defer the issue till the next telecon.)

### Test suite Progress review ###

#### [Interoprability Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolInteroperabilityTesting) ####

  * Where are we at?
  * What needs to be done further?
  * Commencement of the Interoperability Testing phase?
  * Who does which tests?

Kenny: Johan suggested that we merge Section 4 and 5.

Geoff: The current format is how it was in the spec. I am ok with the change.

Kenny: By next telecon, we will aim to merge the two sections, and come up with the first draft. This should give us two weeks for testing.

Kenny: If the Interoperability Testing was not to be completed, and tested, would it be a showstopper?

Simon: I don't think so. We would have the Systems testing document anyway. The first one should cover the second one anyway.

Kenny: Lets do the test assignments on the next telecon.

#### [Systems Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolSystemTesting) ####

#### [Summary of Recommendations](http://code.google.com/p/daisy-online-delivery/wiki/SummaryOfRecommendations) ####

## Related Wiki Pages ##

### [Change Log](http://code.google.com/p/daisy-online-delivery/wiki/ChangeLog) ###

### [PDTB2 Description for Daisy Online Implementers](http://code.google.com/p/daisy-online-delivery/wiki/pdtb2_description) ###

### [WSDL and XSD Tweaks for Daisy Online Implementers](http://code.google.com/p/daisy-online-delivery/wiki/WSDLAndXSDTweaks) ###