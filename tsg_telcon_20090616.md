

Present: George, Kenny, Geoff, Simon, Dominic, Matt, Hiro, Markus (scribe)

## Action Item Summary ##
### New Action Items ###
  * markus contact Jelle and Peter/Steve for F2F confirmation
### Previous Unfinished Action Items ###
  * Geoff and Kenny to reorganise the requirements. ONGOING
  * Nick to go through the wiki and add comments based on the historical discussions of the group.
  * Kenny to add the https vs getResource issue to the tracker.
  * Geoff to go through James e-mail and add any additional issues to the tracker. DONE
  * Markus to provide a sample rebuild of the specification.
  * Geoff to provide some alternative dates for a face-to-face meeting. DONE
  * @markus put all classic TSG req docs on SVN
  * @kenny enter atomic issues reported so far to google code tracker DONE
  * @markus, @kenny draft one or several hypotheses on spec documents reorganization


## F2F July 20th - July 23d ##
Confirmed: Nick, Simon, Hiro, Kenny, Markus

Outstanding: Jelle, Peter/Steve; @markus contact them

## New Telcon Time: 13:00 UTC ##
Suggestion: one hour earlier than current time.

All in favor.

## MTOM ##

Kenny posted scripts for non-MTOM testing. Hiro as successfully downloaded using this.

Kenny: the complete query string is in the content metadata fragment.

Kenny: is it possible for a reading system to resume a download?

Hiro: I think we need to modify implementation to do this, but it should work.

Jelle seems to be having trouble getting byte offsets.

Geoff: the headers are sent to the webserver as a request. Inspect the request object for the range header.

Kenny: in IIS you can register extensions, perhaps that's the way to do it there.

Kenny: I could modify my script to return the headers that Jelle requested. A very simple setup using an ASP.NET script. Do we need more time?

Kenny: if we drop MTOM, this will impact approx 8 types.

Geoff: yes, all these types would need to be changed.

Kenny: URIs will need to be supplied instead of embedding binary content.

_The Group intends to close this issue on the 23d, after input from Jelle and Nick_

## Geoff's Requirements document and user stories document ##
Geoff: now on Wiki. The user stories are a near verbatim transcription. The requirements are divided in in-scope, and satisfied/duplicated. Organized by categories.

... so now is the time to start clarifying and expanding the requirements.

Kenny: will work with Geoff to take this further.

Geoff: we need to start dealing with req issues, and clarifying the reqs where we all know what it means but the wording is vague.

_Target: by 23d have it in a state to present it to the working group_

## Markus' spec documentation restructure work ##
Markus: will try to have something by next weeks call.