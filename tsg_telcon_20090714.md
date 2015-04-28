Present:

Regrets: kenny

## Action Item Summary ##
### New Action Items ###
  * Markus check with george/board on whether service provider discovery req remains for this version
  * Geoff send remaining req issues one by one to list for discussion prior to next weeks telcon (done)
### Previous Unfinished Action Items ###
  * Kenny add (or append to) issue to tracker re dropping storage-specific info from readingSystemAttributes
  * kenny check with Hiro whether he still needs announcement/getUserChoices range requests,
  * kenny collect all impacts of dropping MTOM and post to list
  * Geoff and Kenny to reorganize the requirements. ONGOING
  * Nick to go through the wiki and add comments based on the historical discussions of the group. ONGOING
  * Markus put all classic TSG req docs on SVN ONGOING
  * Markus, Kenny draft one or several hypotheses on spec documents reorganization ONGOING

## Agenda/Minutes ##

### F2F Agenda and Deliverables ###

See [TorontoF2F2009](TorontoF2F2009.md)

### This weeks issues ###

#### [Issue 16](http://code.google.com/p/daisy-online-delivery/issues/detail?id=16) ####
**Resolution; Mark as resolved, satisfied by requirement.**

#### [Issue 17](http://code.google.com/p/daisy-online-delivery/issues/detail?id=17) ####
Geoff added [daisy-online-delivery/wiki/RequirementsDocument#Key\_delivery]

Note: need to confirm the above during requirements repub announcement

Nick: would like this part of the API not be bound to PDTB2, but more general.

Jelle: do we specifically need a function call for this?

Nick: if the object are binary then it could be used in the general content transfer API.

Geoff: they are XML documents. Rationale for a separate function is that so you can request them by name instead of filename. "Heres the content key I need, and here are the private keys that I have. Please package this up in a key exchange object and send it to me."

**Resolution: Leave open, wait for confirmation from James et al.**

#### [Issue 18](http://code.google.com/p/daisy-online-delivery/issues/detail?id=18) ####
Geoff: I argue that this is not a protocol function, but a reading system function.

Nick: currently, the protocol says presumes that you have the URL to the services provider.

Jelle: this is a client issue; shouldnt be described in the specification.

George: Agree that its out of scope for the specification. Players have to be designed to allow for connections to a variety of service providers.

**Resolution: Resolved as out of scope.**

#### [Issue 19](http://code.google.com/p/daisy-online-delivery/issues/detail?id=19) ####
Geoff is suggesting removal.

Nick: its not automatic, intended to be done only where user explicitly requests the download of settings.

Markus: what about preferred language? Nick: in ReadingSystemAttributes.

**Resolution: Resolved as out of scope for this version. Public given opportunity to protest during review.**

#### [Issue 90](http://code.google.com/p/daisy-online-delivery/issues/detail?id=90) ####
Nick: For a non-interactive download, you could just call the getContentList
Geoff: think there needs to be a service negotiation step. The server requests what level of service it wants, and the server replies whether it can support that.

Nick: theres only 20 functions: why not just have one interface and use NotSupportedFault from the Service side, and at the reader side the function will just not be called.

Geoff: there has to be a clear way of providing only the basic service.

**Resolution: Remove Negotiation and Levels without Negotiation, but leave in dynamic menus and noninteractive session proposals.**

### Requirements Reformulation: finalization ###
  * Communications to wider group
  * Change Log

@Geoff: let group know when Wiki doc is done.