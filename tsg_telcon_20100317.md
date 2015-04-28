present: Nick, Geoff, Markus, Jelle, Johan and Kenny.

> Regrets: Simon and Hiro.

> scribe: Kenny

> ## Action Item Summary ##

> ### New Action Items ###

  * Johan clarify in the spec that for the markAnnouncementsAsRead operation, true = announcement marked as read successfully, false = announcement already marked as read, and invalidParameter fault = announcement id not valid. **done**
  * Johan and Kenny clarify in the spec that if an invalidParameter Fault is returned through a call to the markAnnouncementsAsRead operation, a reading system must call the markAnnouncementsAsRead operation sequentially with individual announcement ids to determine which of the announcement ids caused the fault, and close [Issue 229](https://code.google.com/p/daisy-online-delivery/issues/detail?id=229). **done**
  * Jelle add verbiage to the spec that defines the following fault precedence: internalServerError, noActiveSession, operationNotSupported, invalidOperation, invalidParameter, and close [Issue 230](https://code.google.com/p/daisy-online-delivery/issues/detail?id=230). **done**
  * Geoff implement his proposal for [Issue 231](https://code.google.com/p/daisy-online-delivery/issues/detail?id=231), and close [Issue 231](https://code.google.com/p/daisy-online-delivery/issues/detail?id=231). **done**
  * Kenny move the getBlob/setBlob issue to the Daisy Online issue tracker on the DC website, and close this issue on the tracker in Google Code. **done**
  * Kenny add feature request to the Daisy Online issue tracker on the DC website for a Conformance Testing document to be delivered in the maintenance phase of the spec. **done**
  * Kenny check with Humanware and Plextor on what their position is on not delivering the Interoperability Testing document in this version of the spec. **done**
  * Geoff talk to Kenny offline about an issue in the issue tracker. **done**
  * Jelle talk to Geoff offline about the Systems Testing report.

> ### Previous Unfinished Action Items ###

  * Kenny clarify in the spec that the logOff operation can be called within the session innitialisation sequence, and close [Issue 227](https://code.google.com/p/daisy-online-delivery/issues/detail?id=227). **done**
  * Geoff clarify in the spec that a cookie can be issued even when the logOn operation is unsuccessful, and close [Issue 228](https://code.google.com/p/daisy-online-delivery/issues/detail?id=228). **done**
  * geoff add informative verbiage to the spec that outlines the steps that need to be taken to synchronise content in an  out-of-band selection model.
  * Johan and Kenny advice Nick on what sections he should work on in the Interoperability Testing document.
  * Johan, Nick and kenny work on the Interoperability testing document before the next telecon to produce the first draft.
  * Geoff eliminate the ambiguity around the use of the word "Content" in the spec, and close [Issue 211](https://code.google.com/p/daisy-online-delivery/issues/detail?id=211). **done**
  * Simon, Jelle, Johan, Geoff and Hiro implement pdtb2 support in their test implementations by 8 March. **Johan: done, Geoff: gave up**
  * Kenny add a normative assertion, that sets forth the invalidParameter fault as the consequence of a Reading System calling the getQuestions operation with the "back" id when no prior call to the getQuestions operation has been made in the active session, to the spec and the Interoperability testing documents. **done**
  * Kenny add a normative assertion, that sets forth the invalidParameter fault as the consequence of a Reading System calling the getQuestions operation with the "back" and "search" IDs, when these IDs are not supported by a Service. **done**
  * Kenny add substantive comments to issue tracker. **no comments received**
  * Kenny inform the owner of a substantive comment once the comment has been addressed. **no comments received**
  * Simon to add the minOccurs and maxOccurs tweak to the tweaks page.
  * Markus fix the &apos; entity problem. (outstanding; bug in IE.) (Markus will fix this when ready to publish.)

> ### Group Action Items ###

> #### Action items for formal recommendation to the Board on April 5, 2010 ####

  * Deliver Final version of the spec.
  * Provide Information on comments Received, and how they were addressed.
  * Make Available the Systems Testing document.
  * make available the systems testing  Conformance report.
  * Make a formal Recommendation to the board for approval that includes:
    * A one page document that contains the recommendation by the Wg including a link to the Spec, and a link to the Primer.
    * an appendix containing the systems testing report.

> ## Agenda/Minutes ##

> ### Issues ###

> #### [Issue 229](https://code.google.com/p/daisy-online-delivery/issues/detail?id=229) ####

> Nick: We leave the wsdl as is but describe the following behaviour in the spec and the implementations:

> if a service returns the invalidParameter fault in response to markAnnouncementsAsRead the reading system should then call markAnnouncementsAsRead sequentially
> with each ID to discover which one caused the fault.

> The service can either actually mark the announcements as read during the call which caused the original fault or during the calls for each single announcement.
> The spec does not currently say what happens if you call the function with an Id which has already been marked as read so this could return true - or false
> to indicate that the announcement has already been marked  - but should not cause an invalidParameter fault.

> Simon:I’m with Nick on that. Easy and Clean.

> Kenny: So we have two questions then:
    * What does the tru/false return value mean for the markAnnouncementsAsRead operation?
    * Which of the following options do we need to go forward with to resolve this issue:
      1. Specify in the spec that this operation must not be called with multiple Announcement IDs.
      1. Change this operation to receive one string or nmtoken parameter that would contain an announcement id. (requires modification to the wsdl file)
      1. Nick's suggestion above.

> Kenny: I think we should clarify in the spec what the true and false return values mean for the markAnnouncementsAsRead operation.

> Johan: I think its a good idea to specify what these return values mean.

> Kenny: We have other functions too that return a boolean value. Should we be clarifying what these return values mean as well?

> Johan: For issueContent for example, if you receive a false return value, it may mean that the content was already issued. In terms of the markAnnouncementsAsRead operation, I return an invalidParameter fault if the announcement id passed in was already marked as read in my test implementation right now.

> Kenny: My proposal is we state in the spec that true = the announcement id was successfully marked as read, false = the announcement id had already been marked as read, and invalidParameter fault = the announcement id was not valid.

> Johan: I agree.

> Jelle: Me too.

> Geoff: me too.

> Nick: I am happy with it.

> (Consensus: Group agreed to define the conditions for true, false and InvalidParameter fault for the markAnnouncementsAsRead operation as proposed above where true = announcement marked as read successfully, false = announcement already marked as read, and invalidParameterFault = announcement id not valid)

> Johan: Regarding a change to the markAnnouncementsAsRead operation, I am ok with a change and I can implement the changes during this week.

> Jelle: I think we can go with Nick's suggestion. It sounds fine and does not require any change to the wsdl.

> Geoff: Me too.

> Johan: me too.

> Kenny: Me too.

> (Consensus: Group decided to move forward with Nick's proposal on dealing with the multiple announcements ids and invalidParameter fault issue.)

> #### [Issue 230](https://code.google.com/p/daisy-online-delivery/issues/detail?id=230) ####

> Jelle: In some occasions multiple faults can happen.
> eg. If you are not logged in and you want to call a non-implemented call.
> You might get any fault from noActiveSession, operationNotSupported or even invalidOperation.
> I think we should defined the priority and the order of the checks to make this clear.

> The order I would suggest (which might be obvious in most cases anyway)
> - noActiveSession - always first as we don't want to disclose anything about this service until properly logged in
> - operationNotSupported - if it is not supported, it cannot be out of context (so before invalidOperation)
> - invalidOperation - If out of context, do not look at the parameters (so before invalidParameter)
> - invalidParameter
> - internalServerError - actually this is a last resort

> kenny: Where a connection to a back-end database was lost, would internalServerError not precede the invalidParameter fault if the Service was relying on the database to determine whether a parameter was valid?

> Geoff: I think internalServerError fault should be the first fault in the sequence as all other faults would only be thrown if there was no error on the server.

> (Consensus: Group agreed to move forward with Jelle's proposal with Geoff's recommendation embedded i.e. the internalServerError fault will be the first fault in the sequence that defines the fault precedence.)

> #### [Issue 231](https://code.google.com/p/daisy-online-delivery/issues/detail?id=231) ####

> Geoff: The references section looks like part of it is in alphabetical order by
> reference abbreviation.  We should put it in a definite order.  Also,
> attributions are missing from some; they should be added in.

> (Consensus: Group agreed with Geoff's proposal.)

> ### Timelines for the next two weeks ###

  * Complete all action items.

> Kenny: Will finish mine by next telecon.

> Geoff: Me too.

> Johan: Will aim for next telecon.

> Jelle: before next telecon.

  * Close all issues. For the deferred issues, move them to the Daisy Online issue tracker on the Daisy website. (?)

> Kenny: I will move the getBlob/setBlob issue to the Daisy Online issue tracker on the DC website, and close this issue on Google code.

> Geoff: I will talk to you offline about an issue. We can close the rest of the issues by the next telecon.

  * Proof read the spec. (?)

> Geoff: If we can get all the issues fixed by the 24th of March, we can dedicate the next week to proof reading.

> Kenny: Agree.

> Johan: agree.

  * proof read the Primer. (?)

> (group agreed to follow the same timelines as for proof reading the spec above.)

  * Complete the systems Testing report. (?)

> Geoff: I expect I will be preparing the final version of this report. I will aim for it To be complete by the 1st of April. Both 2nd and 5th of April are public holidays here in Toronto.

> What about the wsdl tweaks and PDTB2 description documents?
    * Provided or not with the spec release?
    * Where would they live?

> Geoff: Lets keep them as wiki pages.

> Johan: I agree.

> Kenny: The spec submission is not dependent on these two documents, right?

> (Consensus: Group agreed that these documents should live on the Daisy Online wiki in Google code, and are not required for the spec submission to the board.)

> ### Test suite Progress review ###

> #### [Interoprability Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolInteroperabilityTesting) ####

> Kenny: Given the time constraints, I propose we not provide this document with this version of the spec. We could provide this document in the maintenance phase of the spec if the need be. This would also give us an opportunity to gage whether there is a need for this document once the spec goes live.

> Geoff: If we don't have time to prepare it, we don't have time to prepare it. I don't think we have a choice.

> Markus: I think the best we can do at this point is to provide the information in its current state and let the board go with it.

> Geoff: One good thing that could come out of the interoperability testing being pushed back is that we may be able to work on a full conformance testing document in the maintenance phase.

> Kenny: We should also be able to pick up feedback on whether the community requires a Conformance Testing document once the spec goes live if we were to defer this to the maintenance phase. I propose we add a feature request to the Daisy Online issue tracker on the DC website for a Conformance Testing document to be delivered in the maintenance phase.

> Johan: I agree.

> (Consensus: Group agreed to not deliver the Interoperability Testing document in this version of the spec due to the time constraints. A feature request will be added to the Daisy Online issue tracker on the DC website for a Conformance Testing document in the maintenance phase of the spec. Group members agree to make the submission to the Daisy board without the Interoperability Testing document. As Humanware and Plextor were not on the telecon, Kenny will contact them to ascertain what their position is on this decision.)

> #### [Systems Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolSystemTesting) ####

> Geoff: Hiro has sent me his report. I am in the process of translating it. I will be working on it over the next few weeks.

> Jelle: I will have a chat with Geoff offline about the Systems Testing document.

> #### [Summary of Recommendations](http://code.google.com/p/daisy-online-delivery/wiki/SummaryOfRecommendations) ####

> ## Related Wiki Pages ##

> ### [Change Log](http://code.google.com/p/daisy-online-delivery/wiki/ChangeLog) ###

> ### [PDTB2 Description for Daisy Online Implementers](http://code.google.com/p/daisy-online-delivery/wiki/pdtb2_description) ###

> ### [WSDL and XSD Tweaks for Daisy Online Implementers](http://code.google.com/p/daisy-online-delivery/wiki/WSDLAndXSDTweaks) ###