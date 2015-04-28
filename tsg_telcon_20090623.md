

Present: Markus, Geoff, Kenny, Simon, Dominic, Jelle

## Action Item Summary ##
### New Action Items ###
  * Kenny drop storage-specific info from readingSystemAttributes
  * Geoff: drop 13, 16, 22, ignore 37 45, and rewrite 7 and 16 (4) as suggested in the issue.
  * Geoff Add new user story for #25, based on profile subscription use case.

### Previous Unfinished Action Items ###
  * Geoff and Kenny to reorganize the requirements. ONGOING
  * Nick to go through the wiki and add comments based on the historical discussions of the group.
  * Kenny to add the https vs getResource issue to the tracker. DONE (88)
  * Markus put all classic TSG req docs on SVN
  * Markus, Kenny draft one or several hypotheses on spec documents reorganization ONGOING

## Agenda/Minutes ##

### [issue 20](http://code.google.com/p/daisy-online-delivery/issues/detail?id=20) ###
Geoff: were identified as not compatible with client-server model.

Kenny: agree with Geoff's suggestions for the first two. However, we have setContentStatus, which might be a droppable function.

Simon: the reason was that the player can report available storage size, and server can prepare a content list for automatic download that doesn't exceed available storage.

Dominic: the use case is to support profile subscriptions.

Geoff: in a client-server model like ours, the client should be making all the decisions.

Kenny: I was wrong, setContentStatus is about conveying information about whether download has completed etc.

Geoff: the available space report is in readingSystemAttributes, in the config subelement.

Dominic reiterates the profile subscription use case. It implies a push model. All agree its a valid use case.

Geoff, but it can be achieved in the client-server model; via having the player synchronize with a list provided by the server.

Dominic: this satisfies the profile subscription use case.

_@Kenny drop storage-specific info from readingSystemAttributes_

Geoff: 37 and 45 not an issue anymore; they are recognized as dupes.

_@Geoff: drop 13, 16, 22, ignore 37 45, and rewrite 7 and 16 (4) as suggested in the issue._


### [issue 11](http://code.google.com/p/daisy-online-delivery/issues/detail?id=11) ###
All in favor of changing the req as suggested in 11

Geoff: its a service model where users does not select books themselves; the server makes content available to the user, without the user having to explicitly select it through the protocol.

_Decision to drop req 25 and user story, too vague. @Geoff Add new user story, based on profile subscription use case._

### [issue 17](http://code.google.com/p/daisy-online-delivery/issues/detail?id=17) ###

Geoff: need to elaborate more on this. James posted basic flow of events, which is how a player is supposed to operate.

Markus: we should ask James at the list.

Dominic: the idea is to have the protocol support key exchange.

### [Face to face](http://code.google.com/p/daisy-online-delivery/wiki/TorontoF2F2009) ###
All in favor of doing the face to face at the suggested place and time.

### getResource vs https ###
Kenny: certain degree of nervousness around security when serving content via a DMZ backed by a SAN. Can I talk to network experts at CNIB?

Geoff: not sure CNIB is very different from IAccess. Will set something up.

Kenny: we need to become convinced that https is as secure as getResource.

Simon tested the VA script, was not able to forward and rewind. The script itself needs modification, Kenny will notify Simon when done for a new test.

Kenny: dropping MTOM entirely means that we would never embed audio in the soap packages.

Jelle: PDTB2 keys; might we need MTOM for them?

Geoff: no.

_Target to resolve getResource at next call_

## Next Issues ##

Geoff: suggest requirements-related issues to tackle next on the list.