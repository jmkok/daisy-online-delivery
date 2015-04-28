present: George, Simon, Geoff, Nick, Jelle, Hiro, Kenny.

Regrets: Markus, Dominik.

scribe: Kenny

## Action Item Summary ##

### New Action Items ###

  * Jelle post the key name he intends to use to the list for KXO creation.
  * Johan make three KXOs available per Reading system.
  * Geoff make one KXO available per manufacturer.
  * Kenny add a normative assertion, that sets forth the invalidParameter fault as the consequence of a Reading System calling the getQuestions operation with the "back" id when no prior call to the getQuestions operation has been made in the active session, to the spec and the conformance testing documents.
  * Kenny add a normative assertion, that sets forth the invalidParameter fault as the consequence of a Reading System calling the getQuestions operation with the "back" and "search" IDs, when these IDs are not supported by a Service.
  * Geoff add verbiage to the spec stating that no input questions should be sent to a Reading System that require an input type not supported by the Reading System.
  * Kenny create a new page called "Summary of Recommendations," to record the optional assertions in the spec.
  * Kenny add substantive comments to issue tracker.
  * Kenny inform the owner of a substantive comment once the comment has been addressed.
  * All define test cases for the conformance testing document by 28 Feb.

> ### Previous Unfinished Action Items ###

  * Kenny to follow up with James and Neale the status of the two required fixes in the pdtb2 spec: Reg Exp and Example/xsd inconsistency. **done**
  * kenny to send Nick an email containing all the svcutil specific tweaks. **done**
  * Nick, Hiro, Johan and Kenny to review the Systems Testing document and post their comments/participation intentions  on the page or on the list before the next telecon. **kenny: done; Jelle: will be done before the next telecon**
  * Nick, Johan, Simon, Hiro and Jelle to review the Conformance Testing document, post their comments on the page or the list, and add test cases.
  * Hiro and Jelle to send their public keys to the service implementers. **done: Waiting for KxOs**
  * Simon and Hiro to send their email addresses to kenny to be added as Project committors. **done**
  * Kenny to ask Mark/Neale: What format is the private key encrypted in in the KxO? Record this information in the pdtb2\_description page. **done**
  * Johan to provide the RS specific KXOs to the service implementers. **in progress. See the key names area of the General Section of the agenda below for discussion on key names that ensued when reviewing this action item in this telecon**
  * Simon to add the minOccurs and maxOccurs tweak to the tweaks page.
  * Geoff clarify in the spec that the Expired `contentList` should only be used in exceptional circumstances and is not required to contain overdue items (i.e. returnBy date < currentDate). **Done**
  * Geoff to remove the recommendation that states the markAnnouncementsAsRead operation should be called every time an announcement is rendered to a user. **Done**
  * Nick, Johan, Kenny and Geoff to proof read the spec documentation before Feb 15. **done**
  * Geoff to record an issue in the issue tracker for the setBlob/getBlob operations as suggested by Jelle, and mark this issue as an enhancement for the next version of the spec.
  * kenny to make the required cosmetic change to section 4.4.3, and present it to the group for review. **done: Thanks Geoff**
  * Kenny to reflect all the changes recorded in the change log in the Dynamic Menus Primer. **done**
  * Geoff, Johan, Simon, Hiro and Kenny to build PDTB2 support in their test implementations by end March using the sample content provided by Neale. **in Progress. See the KXO area of the General Section below for the discussion that ensued when reviewing this action item in this telecon**
  * After the pdtb2 folks have fixed their version of kxo.xsd, kenny to change XSDs to their canonical URIs, and close [issue 128](https://code.google.com/p/daisy-online-delivery/issues/detail?id=128) and [Issue 144](https://code.google.com/p/daisy-online-delivery/issues/detail?id=144).
  * Markus fix the &apos; entity problem. (outstanding; bug in IE.) (Markus will fix this when ready to publish.)

### Group Action Items ###

#### Action items for the public review period commencing February 15, 2010 ####

  * All issues should be resolved or formally deferred.
  * Any updates to the spec documentation, wsdl and xsd files need to be completed and proof read.
  * The primer should be proof read.

#### Action items for formal recommendation to the Board on April 5, 2010 ####

  * Deliver Final version of the spec.
  * Provide Information on comments Received, and how they were addressed.
  * Make available the Conformance Testing document.
  * Make Available the Systems Testing document.
  * Make available the Conformance Testing Conformance Report.
  * make available the systems testing  Conformance report.
  * Create an area where implementers can post information about the additional features that they have implemented on top of the spec, and that the community at large may be interested in.
  * Make a page available that provides PDTB2 specific knowledge to Daisy Online Implementers.
  * Make a page available that provides all the tweaks to the WSDL and XSD files, that group members had to make to these files for their respective implementations.
  * Make a formal Recommendation to the board for approval.

## Agenda/Minutes ##

### What should a Service return where getQuestions"Back") is invoked when no previous call to the getQuestions operation has been made in the active session ###

#### Discussion on the List ####

Kenny: If a Reading System sends a "back" id in a userResponses type passed into the getQuestions operation, when there has been no previous call to the getQuestions operation in the active session, what must a Service return?

The following two options come to mind:
1. Throw an invalidParameter fault.

2. Return the main menu i.e. equivalent to getQuestions("default")

Since this is a question that all implementers that support the dynamic menu feature with the back accessory will need to think about, what are your thoughts on adding a recommendation to the primer when we do a pass on it suggesting one of these two approaches, or perhaps a better approach?

Geoff: InvalidParameter.

kenny: Any dissenters? Anyone leaning towards the getQuestions("default") option? My vote is for invalidParameter too to make it consistent with other parts of the spec.

Johan: I vote for getQuestions("default")

In a scenario where the user have been exploring the menu and taken a certain path, the user decides to start all over again. Unfortunately, the device does not support this functionality so the user must press the back button repeatedly until the main menu is presented again. Once the main menu is rendered to the user, what should happen if the user press the back button again? invalidParameter or getQuestions("default"). This scenario is identical to browsing the internet in your web browser. Lets assume that you start from www.google.com and end up at www.daisy.org. If you start pressing the back button you will eventually reach your start page. Once back at the start, you will not be able to press the back button anymore, but if you were one could ask himself what would happen. I would not like to see error message.

However, the spec should be consistent so if the majority vote for invalidParameter then I'm happy to implement it.

kenny: Thanks Johan.

We have two votes for invalidParameter and one vote for getQuestions("default") thus far.

Nick, Jelle, Simon, hiro, and all, which of the two options would you like to vote for?

I intend to update the Primer before the next call, so please post your votes to the list over the next couple of days.

Nick: My vote is for invalidParameter.

The reading system knows that the service does not support serverside back from the supportsServerSideBack in the serviceAttrributes. If a reading system wants to translate the fault into getQuestions("default") it is free to do so.

jell: I think invalidParameter would be best.

Doing 'getQuestions("default")' would actually mask the fault. This might generate (yet unforeseen) problems or difficulties.
And a reading system could always internally map**this if it would like to... (but the other way around won't be possible)**) "back" + "invalidParameter" => getQuestions("default")

(Consensus: Group decided to go with invalidParameter.)

### What should happen when a Reading System does not support any input types that an inputQuestion lists in its inputTypes element? ###

#### Discussion on the list ####

Simon: How will dynamic menus work if no supportedInputTypes are present? Will there be a menu with only multiple choices question?

For example, a player with 4 arrows would not fit in any categories but could still work with multiple choices question.

If this is the case, it might be a code idea to specify it in the spec.

geoff:      The supported input types are strictly for the inputQuestion.  It's assumed that multipleChoiceQuestions would be supported by any reading system that calls getQuestions.  (And a reading system that doesn't support input of any type would have to be an out-of-band system and not need menus.)

kenny: I think we should make such assumptions explicit in the spec. I am concerned We may have the contextual understanding that people who have not been involved in the spec development may not have. What does everyone else think?

kenny: My vote is for adding a normative assertion to the spec stating (to the effect of): A Service must not send an input question to a Reading System when A Reading System has not declared support for any input types in its readingSystemAttributes that are listed in the inputTypes element of the inputQuestion.

This would also cover the case where a Reading System posts an empty supportedInputTypes element in its readingSystemAttributes.

Geoff:  We already have a recommendation to that effect.

Dominik: Do we have a category for devices limited to 4 arrows with no numerical keypad?

geoff: We don't.  I was under the impression that such a device would only be able to handle multipleChoiceQuestions, so you'd indicate such by not putting anything at all under supportedInputTypes.  Section 4.7.1. Support says, "A Service should not send any question which requires an input type not supported by the Reading System."

Kenny: Thanks Geoff. I did not spot that recommendation initially. The recommendation is at:
http://www.daisy.org/projects/daisy-online-delivery/drafts/20090927/do-spec-20090927.html#fundamentals_dynamic_menus_qtypes

I think this recommendation is enough to clarify the ambiguity.

Thoughts all?

(Consensus: Group decided to state explicitly in the spec that no input questions should be sent to a Reading System that require an input type not supported on the Reading System.)

### What is the role of readingSystemAttributes/config/supportsMultipleSelections in this iteration of the spec? ###

Geoff: it states that the Reading System supports a user choosing multiple choices for  a multiple choice question.

Johan: What would happen if I sent a multiple choice question, that accepts the selection of more than one choice as an answer, to a Reading System that does not support multiple selections?

Geoff: A Service should not send a multiple choice question that allows multiple selections, to a Reading System that does not support multiple selections. For example, the following question:
What Language do you want your books in?
option 1: En
Option 2: gb
Option 3: fr

could be broken down by a service into a series of questions i.e.:
Do you want your books in English?
option 1: Yes
Option 2: No.

...

(Consensus: Group decided to keep it as is in the spec.)

### General ###

#### Format of key names ####

Johan: Should the key names be in a particular format?

Geoff: No particular format is required by the PDTB2 spec.

Nick: Should key names not be unique?

Geoff: They should be universally unique.

George: The committee for defining a key name scheme was not approved. daisy.countryCode.organisationCode ... was developed for unique book number, but did not go anywhere.

#### KXOs ####

Geoff: I have a question for Mark on creating KXOs.

Simon: Will let Mark know.

Johan: I have implemented the required KXOs. I now need to add sample content. I will be making available three KXOs per Reading System.

Geoff: I will be making available one KXO per  manufacturer.

### Test suite Progress review ###

#### [Test Suite](http://code.google.com/p/daisy-online-delivery/wiki/tsg_test_suite) ####

  * Should we include spec recommendations in the conformance testing document and introduce the concept of optional assertions? (ref: johan's comments on the conformance testing page)

geoff: this muddies the waters.

johan: I think this spec is quite long. You will have to read it two to three times to understand the recommendations.

geoff: I have no problems with providing the optional assertions in a separate document, but not in the conformance testing document.

kenny: Lets create a separate page with the same categories to record the optional assertions.

(Consensus: Group decided to move forward with a separate page that records all the recommendations and the corresponding test cases. This page will be called "Summary of recommendations.")

  * are the assertions sufficient in the RS and Service conformance areas?

Kenny: I don't think we are going to be ready by feb 15.

geoff: I am fine with deferring this to later. If we defer it to march, would that be sufficient time?

johan: When we talk about test cases in the conformance testing document, are the assertions test cases or do we have to come up with the test cases?

Kenny: We have to come up with test cases.

geoff: I don't think we can get the conformance testing document done by the end of march if we were to define test cases for all the underlying technologies i.e. support http/https ...

Nick: Do we need this document before we submit the spec to the board?

george: We need to say to the board that the spec is workable. We have four services and four RS implementations.

nick: Is the systems testing document not the important one for interoperability?

geoff: Our Conformance Ttesting document is like a validator for implementations.

nick: If we only supply the systems testing document, is that sufficient?

george: What is the purpose of the systems testing document? Will a Reading System use it to claim support for the protocol?

> nick: The systems testing document connects the implementations to the spec to the requirements.

george: Board would want to know if the spec is ready for them to start ordering products with.

kenny: A board member would want to know the conformance of  a reading system, and the extra features he/she is interested in.

Nick: It sounds like we need the conformance testing document for the board.

kenny: Ideally, we should have this document accompanied with a classification scheme. I don't think we have time for a classification scheme though.

george: I don't think we need to define test cases for underlying technologies i.e. http, https ...

nick: This may not be the scientific method, but a pragmatic method.

geoff: Other specs like ws-i basic profile don't have test suites. It would take a long time to describe the test cases. There's about 40-50 assertions in both RS and Service conformance areas.

Nick: I propose we spend effort on the test cases for the spec, and not for underlying technologies.

kenny: I agree.

george: I agree.

kenny: what kind of test cases do we need to define for supporting operations?

geoff: If an operation fails, we should check if a proper fault is thrown.

Nick: Do we need to define each and every test case for an assertion.

geoff: Only edge cases and representative cases.

(Consensus: Group decided to move forward with not defining test cases for underlying technologies. The test cases in the conformance testing document will only target spec features.)

george: Comments received in the public review phase need to be addressed.

george: substantive comments pertaining to the spec need to be recorded and answered.

Kenny: If we receive substantive comments, lets record them in the issue tracker.

  * definition of test cases.

(Group to aim for the definition of most of the test cases for the conformance testing document by 28 Feb)

  * Can we meet the feb 15 timeline?

(document deferred to 28 Feb)

#### [Systems Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolSystemTestingTestCases) ####

> ### Spec update review ###

#### Timelines going forward ####

  1. documentation including the wsdl and xsd files. (have been made available for the public review phase)
  1. Primer. (has been made available for the public review phase)
  1. systems testing and Conformance Testing documents. (in progress. Not made available in the public review phase)
  1. Conformance Testing Conformance Report (Deferred to end March)
  1. Systems Testing Conformance report (deferred to end March)

## Related Wiki Pages ##

### [Change Log](http://code.google.com/p/daisy-online-delivery/wiki/ChangeLog) ###

### [PDTB2 Description for Daisy Online Implementers](http://code.google.com/p/daisy-online-delivery/wiki/pdtb2_description) ###

### [WSDL and XSD Tweaks for Daisy Online Implementers](http://code.google.com/p/daisy-online-delivery/wiki/WSDLAndXSDTweaks) ###