

Present: Geoff, George, Dave, Dominic, Leon, Simon, Hiro, Kenny, Jelle, Nick, Markus (scribe), James

Telcon recording audio file name is 20090521

This is the kickoff call for requirements revisit. The bucket is open until the 29th. We expect the list to be used for issues not covered during the cons.

_Markus_: again, this is not a complete new round. First collect without detailed discussion of the individual issues
then present as table at wiki, sort, list pros and cons.

Collection ends at 29th, after which the final analysis and inclusion decision process starts.

## Action Item Summary ##
### New Action Items ###
  * @markus put all classic TSG req docs on SVN
### Previous Unfinished Action Items ###
  * @kenny enter atomic issues reported so far to google code tracker
  * @markus, @kenny draft one or several hypotheses on spec documents reorganization


## Issues raised by participants during the call ##

### Key Delivery ###
_James_: delivery of keys through the service would be a good thing

_George_: having that kind of functionality would be politically help us in copyright initiative

_James_: its on the uses story list

_Nick_: might have been descoped into version 2.

_Kenny_: its user story 59.

_James_: key exchange object in PTDB2, we have XSD et al, so this should be quite straight forward

_James_: encryption information exchange needs to be separate from book data transfer

_Nick_: If we do this, should be as general as possible as to support key exchange under other DRM specs than PDTB2.


### Library to Library exchange ###
_George_: library to library exchange, is this supported?

_Kenny_: No.

_Nick_: what are the differences really?

_Markus_: suggest we look at this for version 2.

### SOAP Overhead ###
Issue also knows as ''getResource vs http/https'',

with a less emphasized subtopic ''embedding audio in soap''

_Hiro_: building client. We could successfully communicate with Nicks implementation. So far, we havent encountered any difficulties.

_Kenny_: Jelle suggests that we drop getResource function, Hiro, whats your experience?

_Hiro_: mechanism works fine, but we worry about implementation on hardware environment.

_Markus_: are you requesting a simpler transfer protocol or simpler SOAP API?

_Jelle_: Yes, getResource works fine. However, why are we doing it the hard way? Could do directly in https. SOAP gives 33% overhead. I do see the benefits of getResource, but may not be the best option for data transfer.

_Nick_: maybe the layered/leveled approach could be a solution to getResource.

_Jelle_: as a client builder, we probably have to implement all levels.

_Markus_: if we do the layer/level solution to the spec, it should be a sub vs superset solution, not presenting alternative ways to do the same thing.

_Geoff_: Hiro, are you saying that you worry about player memory, power requirements and such? _Hiro_: yes. So far no such issues, but if consider future varieties of hardware players, we may.

_Markus_: Hiro, do you see a generic issue with SOAP? _Hiro_: no.

_Nick_: audio transfer happens at part of announcements, but you can specify that you dont want audio. Also happens in book resources.

_Markus_: is this a SOAP vs RESTful debate? _Kenny_: Yes: _Jelle_: I am only suggesting to use http(s) for data transfer.

_Jelle_: thinks integrating audio in soap for messages is a good thing, care most about efficiency of book data.

_Leon_: if http: would it be less secure? Jelle: equal security via https.

_George_: players will have a single TTS engine on board. Probable that people will be getting content in more than one language. Having audio support in SOAP seems like a good idea.


## New time for concall ##

New standard time is 14:00 UTC Tuesdays

## Next concall ##
Next call is the 14:00 UTC the 26th.
