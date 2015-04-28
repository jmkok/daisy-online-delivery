

Present: Simon, Geoff, Markus, Nick, Dominic, Jelle, Kenny

Regrets:

## Action Item Summary ##
### New Action Items ###
  * Markus check with george/board on whether service provider discovery req remains for this version
  * Geoff send remaining req issues one by one to list for discussion prior to next weeks telcon
### Previous Unfinished Action Items ###
  * Kenny add (or append to) issue to tracker re dropping storage-specific info from readingSystemAttributes
  * kenny check with Hiro whether he still needs announcement/getUserChoices range requests,
  * kenny collect all impacts of dropping MTOM and post to list
  * ALL review 5-15 except 11, use of the comments function on the issue tracker.
  * (and issue tracker items for Geoff, sprinkled below)
  * Geoff Add new user story for #25, based on profile subscription use case. DONE, linked from issue;
  * Geoff and Kenny to reorganize the requirements. ONGOING
  * Nick to go through the wiki and add comments based on the historical discussions of the group. ONGOING
  * Markus put all classic TSG req docs on SVN ONGOING
  * Markus, Kenny draft one or several hypotheses on spec documents reorganization ONGOING

## Agenda/Minutes ##

### F2F - any questions? ###
Roehampton is the prefferred hotel.

The priority today is [issue 6](https://code.google.com/p/daisy-online-delivery/issues/detail?id=6). See section below for Geoff's suggestion on handling 5-15 excluding 6.

### [Issue 6](http://code.google.com/p/daisy-online-delivery/issues/detail?id=6) ###
Geoff: req is that protocol must support transmission of class and capabilities of the player. _Question: is there anything that the server must know about the reading system in order for the protocol to work?_

Nick: Single entry menu, there is no way for the client to request single entry menu.

Geoff: Good point. But I am still suggesting that in a client-server model, the client should be in control.

Nick: imagine I can get a booklist; the server would not put things in a booklist that it knows the client cant handle.

Geoff: is there anybody making a DO player that doesnt support DAISY3? What if you have a client that isnt a reading system?

Nick: Our entire library is still 2.02. A downloading client could just "lie".

Geoff: impact of non-reading clients is that ReadingSystemAttributes doesnt necessarily represent the end user agent.

Nick: allows the service to not present content that the reading cant handle.

Markus: posting supported content via ReadingSystemAttributes is also in support of dynamic content generation at the server side.

Geoff: if we can take ReadingSystemAttributes out entirely, thats a good thing for the simplicity for the API. But - this may also make the API more complicated; in this case filtering results.

Nick: also make model, serial number and firmware revision.

Geoff: And an element called config. Except for model/number/firmware, the others could be seen as session attributes and/or user preferences.

From non-techie user POVs, the might not have skills to figure out firmware version etc. So user agent stuff should probably remain postable.

Kenny: supportsGroupedQuestions/multipleChoices; on the basis on that the service provider creates menus etc.

Geoff: suggest that we go through the ReadingSystemAttributes and see if we can clean up some more.

''Geoff: close [Issue 6](https://code.google.com/p/daisy-online-delivery/issues/detail?id=6) as wontfix.''

''Note - session on F2F further reduction of ReadingSystemAttributes''


### [Issue 5](http://code.google.com/p/daisy-online-delivery/issues/detail?id=5) ###

### [Issue 7](http://code.google.com/p/daisy-online-delivery/issues/detail?id=7) ###

### [Issue 8](http://code.google.com/p/daisy-online-delivery/issues/detail?id=8) ###

### [Issue 9](http://code.google.com/p/daisy-online-delivery/issues/detail?id=9) ###

### [Issue 10](http://code.google.com/p/daisy-online-delivery/issues/detail?id=10) ###

### [Issue 12](http://code.google.com/p/daisy-online-delivery/issues/detail?id=12) ###

### [Issue 13](http://code.google.com/p/daisy-online-delivery/issues/detail?id=13) ###

### [Issue 14](http://code.google.com/p/daisy-online-delivery/issues/detail?id=14) ###

### [Issue 15](http://code.google.com/p/daisy-online-delivery/issues/detail?id=15) ###


### Geoffs suggested actions on 5-15 excl 6 ###

Issues
[7](http://code.google.com/p/daisy-online-delivery/issues/detail?id=7), [8](http://code.google.com/p/daisy-online-delivery/issues/detail?id=8), [9](http://code.google.com/p/daisy-online-delivery/issues/detail?id=9), [10](http://code.google.com/p/daisy-online-delivery/issues/detail?id=10) and [14](http://code.google.com/p/daisy-online-delivery/issues/detail?id=14) have no comments in them and are actionable, so the changes will be adopted.

[Issue 15](http://code.google.com/p/daisy-online-delivery/issues/detail?id=15) states that a requirement that was already marked as a duplicate "may be uneccessary".  This issue will be marked Invalid.


Issues
[5](http://code.google.com/p/daisy-online-delivery/issues/detail?id=5), [12](http://code.google.com/p/daisy-online-delivery/issues/detail?id=12) and [13](http://code.google.com/p/daisy-online-delivery/issues/detail?id=13) are requests for clarification.  Since no one has been able to clarify them, the requirements will be removed.(Markus notes: [issue 13](https://code.google.com/p/daisy-online-delivery/issues/detail?id=13) may be related to content provider discovery)

## Is service provider discovery in or out of scope for this version of the protocol? ##
DAISY is ready to host a service provider directory, but the question remains whether we can live without it in this version.

Jelle: configuration can be done after delivery, online.

Markus: concerns have been raised to allow commercial or free service providers to offer their services and be dynamically hooked up to the "web".

@markus check with george/board on whether this req remains for this version, or if we can postpone. Proposed resolution: it is a player specific feature to allow the user to provide the URLs of new/additional service providers.

## Next concall ##
  * How to use our time best at the F2F
  * Agenda, deliverables
  * 5 requirements issues left (16,17,18,19,90) @Geoff to send issues 1 by 1 to emailing list