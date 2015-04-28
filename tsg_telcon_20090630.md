

Present: Nick, Simon, Geoff, George, Kenny, Markus (scribe)

Regrets: Hiro

## Action Item Summary ##
### New Action Items ###
  * Kenny add (or append to) issue to tracker re dropping storage-specific info from readingSystemAttributes
  * kenny check with Hiro whether he still needs announcement/getUserChoices range requests,
  * kenny collect all impacts of dropping MTOM and post to list
  * ALL review 5-15 except 11, use of the comments function on the issue tracker.
  * (and issue tracker items for Geoff, sprinkled below)
### Previous Unfinished Action Items ###
  * Geoff: drop 13, 16, 22, ignore 37 45, and rewrite 7 and 16 (4) as suggested in the issue. DONE
  * Geoff Add new user story for #25, based on profile subscription use case.
  * Geoff and Kenny to reorganize the requirements. ONGOING
  * Nick to go through the wiki and add comments based on the historical discussions of the group. ONGOING
  * Markus put all classic TSG req docs on SVN ONGOING
  * Markus, Kenny draft one or several hypotheses on spec documents reorganization ONGOING

## Agenda/Minutes ##

### [Issue 1](http://code.google.com/p/daisy-online-delivery/issues/detail?id=1) requirement 5 (Interact with content) requires clarification. ###

Geoff: think I was referring to the implementation of the requirement; it may not actually be an issue with the requirement.

Kenny: Now that we don't use MTOM anymore, this would be a pointer to the sample instead.

_Conclusion: close the issue_ @Geoff

### [Issue 2](http://code.google.com/p/daisy-online-delivery/issues/detail?id=2) Requirement 8 (return book) might need to be out of scope. ###

Geoff: another one where the wording is a little bit off what the protocol requirements would be. Can we enforce this in the protocol? Badly intentioned player can skip the actual delete, which is out of scope of the protocol. Its still a business requirement of any library.

Dominic: you will never be sure that the user has made a copy, etc.

Geoff: the only way to control this is via PDTB. Propose an edit to make it clearer what the protocol implications are.

Kenny: Geoff; are you fine with the returnContent function?

Geoff: Makes sense in a library context. May be an optional function of a webservice, in a purchasing model, any attempt to return content would either return an error or be ignored.

Nick: the function needs to be there, cant see what optional here.

Kenny: could throw a NotSupportedException when a service does not support returns...

_Conclusion:@Geoff: propose verbiage_


### [Issue 3](http://code.google.com/p/daisy-online-delivery/issues/detail?id=3) requirement 9 (report number of books) should be out of scope. ###

Geoff: not sure what the use of this is. Understood that it means "how many books from a particular service". Lets say the player has removable storage...

_Conclusion: drop the requirement_ @Geoff


### [Issue 4](http://code.google.com/p/daisy-online-delivery/issues/detail?id=4) Requirement 10 (transmit confirmation message) should be out of scope. ###

Nick: I thought; at some point you need to decide that you actually want the book. A "point of sale" thing.

Geoff: but if you're going to be doing that through the protocol, does it need separate functionality from dynamic menus?

Kenny: we have the issueContent function, indicating that the content should be downloaded.

_Conclusion: rewrite to reference issueContent_ @Geoff


### MTOM and the getResource function (Is the group ready to make a decision?) ###

ref: Geoff, Jelle and Kenny's emails to the list. last week we put forward a hypothesis to drop MTOM and the getResource function; are we ready to make a decision?

Nick: does dropping MTOM mean also dropping audioData fragment?

Kenny: yes, no binary content in the SOAP packages.

Geoff: some of the details of the implications need to worked out. I am ready to abandon those things.

Kenny: don't see problem in dropping MTOM from a service provider POV. But userInput side of things; when receiving audio from user, would have to be transmitted via SOAP.

Markus: whats the user story for user audio feedback?

Geoff: Idea was for users to provide feedback on content (something wrong, user ratings, etc). Ron Stewart's user story.

George: could content issues be flagged some other way?

Geoff: CNIB uses phone or email for this already.

Geoff: propose drop allowing the user to transmit binary stuff to the service.

Kenny: only way to do this is through dynamic menus at this time. Function getUserInput has an audio parameter.

_Conclusion: @Kenny drop this req in this version of the protocol, remove the audio option from the getUserInput function._

Nick: do we now need announcement ranges any more?

@kenny check with Hiro whether he still needs announcement/getUserChoices range requests,

Nick: associated metadata functions might not be needed anymore either.

@kenny collect all impacts of dropping MTOM and post to list

### Spec rebuild ###
Markus: commit to SVN of a skeleton made today, will compose small sample