

Present: Markus (scribe), Geoff, Matt, Jelle, Dominic, Hiro, Nick, Kenny

Regrets:

## Action Item Summary ##

### New Action Items ###
  * Geoff: lift over underlying protocol topics from to 5.3.3 to 4.3
  * Jelle: and Nick read 4.3 and send thoughts/proposals to Kenny
  * Kenny: modify 4.3, then notify Markus
  * Geoff: work further on 5.3.3 and 5.3.4, then notify Markus
  * Markus: minor mods as below
  * Markus: announce the release before friday is over in Honolulu

### Previous Unfinished Action Items ###
{DONE, but not integrated in spec yet} (then close [issue 106](https://code.google.com/p/daisy-online-delivery/issues/detail?id=106)).
  * Jelle: write prose for **5.1.1 http(s) authentication** {DONE, merged with "underlying protocols}
  * Geoff: write prose for **5.3.3. Downloading and streaming of content** {ONGOING}
  * Geoff: write prose on how installments work in section 5, then close [Issue 102](https://code.google.com/p/daisy-online-delivery/issues/detail?id=102). {ONGOING}
  * Nick: write prose for **5.6. Bookmarks and Last Reading Position, inc samples** {DONE}
  * Nick, in writing the prose and producing a bookmark sample, solve [Issue 34](https://code.google.com/p/daisy-online-delivery/issues/detail?id=34) and [Issue 119](https://code.google.com/p/daisy-online-delivery/issues/detail?id=119) {ONGOING}
  * Markus: implement all issue resolutions below except that for [Issue 106](https://code.google.com/p/daisy-online-delivery/issues/detail?id=106).{DONE}

  * Jelle: propose resolution to [Issue 118](https://code.google.com/p/daisy-online-delivery/issues/detail?id=118)
  * Geoff and Markus analyze RequirementsDocument vs current API. {ONGOING}

## Agenda/Minutes ##
### Unfinished Sections ###
The following sections/items are known to be unfinished:
  * The Introduction
  * 4.3 Underlying protocols (Jelles submission for 5.1.1 "https and authentication" was merged in here. Note that 5.3.3 touches on the same topics, so there is some overlap
  * _Geoff - TODAY_ 5.3.3. Downloading and streaming of content (some more work needed
  * _Geoff - TODAY_ at least a stub of 5.3.4. Publishing content in installments (Geoff) - will add only a brief overview
  * _Markus, add_: No prose/example on how to retrieve samples (do we require issueContent on samples?) **Resolution**: must not do issueContent on samples
  * _Markus, add_: Not yet specified that WAV must be supported by services form for userResponse/audiodata
  * Geoff: lift over 5.3.3 prose to underlying protocols before Kenny wakes up
  * _Markus:_ Edits remain in Appendix B.
  * _Markus:_ make sure all unfinished sections marked as such
  * A few issues marked as defects


### Work Mode during editing phase ###
Matt owns document, minimize merge hell by avoiding that others commit to the main docs. Instead Submit change proposals as issues or on list, or notify Matt that a substantial edits are done to a whole section.

#### Concurrent work ####
  * Who wants to take a stab at the CSS? {@Matt}
  * Pick up the requirements fulfilment analysis thread that Geoff started