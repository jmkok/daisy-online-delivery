

# Monday July 20 #

## Terms ##

**Agreed**: Namespace uri not to contain doml – eg ns/daisyonline#

**Agreed**: interface, function, parameter and fault mapped to wsdl equivalents in the terminology section.

**Agreed**: use Content except for reference to the Daisy spec PublicationID.

**Agreed**: Download / Stream - streaming implies not storing the content on disc.

**Action: Markus** – spec requires support of range headers on http / https requests. A compliant service provider must support range header. Third parties should support range headers. Reading systems must support responses that do not support range headers.

Third party content provider: needs definition.

**Ongoing**: rename issueContent and returnContent functions.

**Ongoing**: define Dynamic menu generations

Basic vs Advanced (Core vs Optional)

**Proposed**:

  1. wdsl with one port type (interface) where all operations that are optional allow the OperationNotSupported fault.
  1. In the spec we have required operations and we possible have groups of optional operations.
  1. We introduce a new operation by which the reading system can discover which optional operations the service implements – this allows non-implemented operations to be removed from the reading systems ui.

## PDTB2 ##

**Agreed**: we introduct a new operation

getKeyExchangeObject(String supportedPublicKeyNames, String RequestedKeyName )

which returns a Key Exchange Object xml fragment.

This operation is optional.

**Action**: to decide if the contentMetaData fragment needs to define the use or not of PDTB2.

**Action**: to define an xml type for an array of string (sequence).

## Dynamic menus ##

**Proposed**:

Replace the following functions:

  1. `getUserChoices`
  1. `getUserInput`
  1. `getGroupedQuestions`
  1. `getUserAnnouncement`
  1. `postUserResponses`

with

  1. `getMultipleChoiceQuestion(id)`
  1. `getQuestion(id)`
  1. `getGroupedQuestions(gid)`
  1. `getMessage(mid)`
  1. `setUserResponses(UserResponses)`

All the "`get`" functions would take an ID only.  All user responses would be sent with the `setUserResponses` function, which would return the `nextOperation`, i.e. the next operation to call in sequence.

Alternatively, the function definitions would remain the same; only the names would change.

These functions could be unified into a single `postUserResponses` function if it is possible to have a complex return type that encapsulates multiple choice, text entry, grouped questions, and user announcements.

## [Issue 34](https://code.google.com/p/daisy-online-delivery/issues/detail?id=34) ##

Might be relevant for DAISY 2.02.

**Action - Markus**: Look up the portable bookmark spec.

## [Issue 38](https://code.google.com/p/daisy-online-delivery/issues/detail?id=38) ##

**Agreed**: menu and content list IDs should not be expected to be held for longer than one session.  IDs may be held for less a period of time, depending on the server.

Will Reading Systems be caching dynamic menus and content lists?

The content list was intended to be an endpoint; the Reading System would have to start from the "home" menu once it reaches a content list.

**Parked**

## Define a session ##

**Agreed**: The web service session should be separate from the content transfer session.

**Agreed**: The start of a session is a successful `logOn`.  The end of a session is either a `logOut` or a timeout.  WS sessions can span multiple HTTP sessions.

## [Issue 40](https://code.google.com/p/daisy-online-delivery/issues/detail?id=40) ##

**Agreed**: Drop the VB examples; keep the Java/C# examples in an appendix.

## [Issue 42](https://code.google.com/p/daisy-online-delivery/issues/detail?id=42) ##

**Agreed**: Mark invalid

## [Issue 44](https://code.google.com/p/daisy-online-delivery/issues/detail?id=44) ##

**Agreed**: Drop sequence numbers from `userChoices`, `groupedQuestions`, `announcements` and `contentList`.

**Agreed**: `markAnnouncementsAsRead` should take a list of announcement IDs, not a range.

**Action - Markus**: Should IDs be simple Strings or XML Names?

**Agreed**: `contentList` should grow `rangeBegin`, `rangeEnd` and `totalItems` attributes, to allow for downloading parts of the content list.

## Tomorrow ##

**Action - Markus**:
  * Keep WSDL and XSD up to date all the time.
  * Prioritize issues so ones with heavier impact are dealt with earlier.

# Tuesday July 21 #

## Group Session 1 Group 1 ##
### [Issue 45](https://code.google.com/p/daisy-online-delivery/issues/detail?id=45) ###
getDelayPeriod should be removed from the spec.
action: remove this function.

### [Issue 46](https://code.google.com/p/daisy-online-delivery/issues/detail?id=46) ###
why is setmessageMimetypes separate from setReadingsystemAttributes
action: remove this function.

larger issue:
a. Should the spec say anything about a compliant service provider supporting reading systems without a tts.

b. should the service provider be required to always send the textual representation of a message. (this is not the case right now in the spec)

c. should the setreadingsystemattributes be allowed to be called multiple times in a session to change server characteristics
(matt)

### [Issue 47](https://code.google.com/p/daisy-online-delivery/issues/detail?id=47) ###
sequence of setMessageMimetypes is not clear.
action: irrelevant. closed.

### [Issue 48](https://code.google.com/p/daisy-online-delivery/issues/detail?id=48) ###
setKeyPress should be removed.
action: drop the function.

### [Issue 50](https://code.google.com/p/daisy-online-delivery/issues/detail?id=50) ###
setError should be removed.
action: out of scope for v1.0. should be looked at in v2.0 or some custom extension to daisy online.

### [Issue 51](https://code.google.com/p/daisy-online-delivery/issues/detail?id=51) ###
should logOff function be removed?
action: keep the logoff function.

### [Issue 53](https://code.google.com/p/daisy-online-delivery/issues/detail?id=53) ###
getcontentStatus function should be removed
action: drop getcontentstatus and setcontentstatus as the same affect can be achieved by logging on the server.

### [Issue 57](https://code.google.com/p/daisy-online-delivery/issues/detail?id=57) ###
deletion of content.
action: keep the returnContent function but state that a compliant reading system should delete content when the returnContent is called. there is no way to enforce this but  this is no different from lending a physical cd.

### [Issue 59](https://code.google.com/p/daisy-online-delivery/issues/detail?id=59) ###
remove braillecode attribute from the spec
action: drop it from inputTypes.

larger issue:; the resourcces' uris should not be required
a. is braillecode required for mimetypes.

b. how do we deal with mimeTyps? what does the spec say about support of mimeTypes when sent to the service.

c. should we say in the spec that the announcements should always be text and audio, and dynamic menus always require a reading system with tts.
(message type needs to be looked at.)

### [Issue 78](https://code.google.com/p/daisy-online-delivery/issues/detail?id=78) ###
contentMetadata
action: not applicable. (uri should be required as mtom has been dropped)



## Group Session 1 Group 2 ##
### [Issue 61](https://code.google.com/p/daisy-online-delivery/issues/detail?id=61) ###
Proposed Resolution:
  * keep manufacturer and model required
  * make serialNumber optional
  * rename firmwareVersion to version and remains required
  * make supportedProtocols optional, and make clear that only additional protocols than the ones mandate by the spec
  * change name of supportedProtocols to additionalTransferProtocols
  * referredLanguage rename to preferredUILanguage, keep required

### [Issue 62](https://code.google.com/p/daisy-online-delivery/issues/detail?id=62) ###
Proposed Resolution: supported protocol version information is redundant; handled at the WSDL level.

### [Issue 63](https://code.google.com/p/daisy-online-delivery/issues/detail?id=63) ###
Proposed resolution: no enumeration. Add prose that makes clear this follows the dc:format convention.

Add informative URIs to daisy2.02 spec and zed specs and epub spec where those particular strings are defined.

### [Issue 64](https://code.google.com/p/daisy-online-delivery/issues/detail?id=64) ###
Proposed Resolution: rename to supportedMimeTypes, clarify that this related to MIME types of both service messages/announcements AND content.

### [Issue 65](https://code.google.com/p/daisy-online-delivery/issues/detail?id=65) ###
Proposed Resolution: rename to supportedInputTypes, change enum to TEXT\_NUMERIC, TEXT\_ALPHANUMERIC (for now). Revisit audio posting on thursday if we have time.
(Note: discussion about dropping notion of braille entirely in protocol)

### [Issue 66](https://code.google.com/p/daisy-online-delivery/issues/detail?id=66) ###
Already resolved. availableMemory is removed.

### [Issue 67](https://code.google.com/p/daisy-online-delivery/issues/detail?id=67) ###
Already resolved. In mondays notes.

### [Issue 68](https://code.google.com/p/daisy-online-delivery/issues/detail?id=68) ###
Resolved in XSD.

### [Issue 69](https://code.google.com/p/daisy-online-delivery/issues/detail?id=69) ###
Proposed Resolution: make bandwith optional, see clarifying doc in xsd.

### [Issue 70](https://code.google.com/p/daisy-online-delivery/issues/detail?id=70) ###
Proposed Resolution: rename message to label

## Group Session 2: Group 1+2 (issues 79 and forward) ##
### [Issue 79](https://code.google.com/p/daisy-online-delivery/issues/detail?id=79) ###
The type is a hint to the content.
Just leave it for the time being as it is optional.
Rename type to category as it type is too confusing.
It is an extensible enumeration. Like book, magazine or ....

### [Issue 80](https://code.google.com/p/daisy-online-delivery/issues/detail?id=80) + 81 ###
Define strings somewhere - the strings are actually IDs
They are used internally only
Should we set the fault text to the fault name ?
The text is never shown to the user, so it does not matter how the text looks.

### [Issue 82](https://code.google.com/p/daisy-online-delivery/issues/detail?id=82) ###
Is implemented as "Operation not implemented"

### [Issue 83](https://code.google.com/p/daisy-online-delivery/issues/detail?id=83) ###
Later discussion

### [Issue 84](https://code.google.com/p/daisy-online-delivery/issues/detail?id=84) ###
Removed

### [Issue 87](https://code.google.com/p/daisy-online-delivery/issues/detail?id=87) ###
Not dealling with now

### [Issue 88](https://code.google.com/p/daisy-online-delivery/issues/detail?id=88) ###
Not relevant anynmore: getResource is removed

### [Issue 91](https://code.google.com/p/daisy-online-delivery/issues/detail?id=91) ###
Element: "SupportedContentProtectionStandards" is added
Element is required but may be empty.
Currently only value can be "PDTB2" (or empty)

### [Issue 92](https://code.google.com/p/daisy-online-delivery/issues/detail?id=92) ###
Removed as the server uses http/https which is usable for both streaming and downloading
Should we implement a "Do not store" flag in the content ? No way...
A reading device should be able to download the content again (if lost) or it might not be returnable.
Note that PDTB2 can be used without encryption, but expritation dates are defined.

### Issue & Return content ###
The player would like to know if it is permantetly owned or borrowed.
Add a "mustBeReturned" attribute to the content meta data
Add a "borrowed" attribute to the getContentList.
This way a reading system could know of lost content and/or revoked content.
Service announcements can be used to inform the user of overdue content.
Discuss further...

### Search ###
Drop everything regarding search.
Use getMultipleChoiceQuestion instead
"default" should be used for getMultipleChoice to define the top layer
And serach should be used "search" should be used to define the search menu.
A possible refinement to search so the availability can be detected by the reading system

------ messy below -----

### MIME types ###

What are mime types and how are they used ?
SupportedFormats does resolve some capabilities
dc:format can use mime-types
It can be used that the UI may be rendered using the correct "content"
Are there any default mime-types defined ?
Pure download devices might download anything they are presented.
Mime types as mentioned in the reader system might/will be used to filter the search / responses
The service could sent a OpNotSupported if the mime-types mismatch.

### TTS ###

Menus need to know if the reading device can render the audio.
The dynamic menu might contain very/too many items which should be rendered into audio
Announcements can be very dynamic and might require TTS (eg. books 1,6,34,122 are overdue)
The service could filter if you cannot TTS the text
The service is required to have text and is strongly advised to have audio for the labels.
A reading system might not be comptibel with a service (both do not have a TTS engines) "buy another player"
When a service detects this incompatibility it might mention this in the menu.
A service will not be filtered, it should be filtered by the reading system.
Note: don't use the term TTS, but name it "rendering text"
A download device will not men tion it will require audo
We cannot require from every content provider to have all items spoken (or via tts).
A service provider SHOULD provide text and audio
A service provider can send the reading system a different menu structure if an audio mismatch might occur.

Geoff has a decription for the label items.


# Wednesday 22 JULY #

## AM SESSION ##

Action: markus to update the issue tracker, there are a lot of issues that can now be closed.

Action: markus to add outstanding issues from previous day discussions to the tracker.


Markus summarised previously agreed changes already implemented in the documentation.

Kenny: we created an id for the get content list for borrowed.  Content metadata and get content list should both have this. Markus confirmed this has been included (line 154).

XSD line 773, new code to be examined by the group.

Arrays 821 in XSD, is this a sensible way to handle the issue?  All to examine.

Still to do: XSD documentation;
protocol operations where the meat of the spec will be in terms of human oriented  prose;
terminology defined at the head of the spec;
associated the xslt as all it currently does is renders a heading per type;
finalisation of the spec; who does what; what do we mean with test and reference implementation.

Focus of today:
Rest of API;
Clean up the issue tracker.


### Dynamic menus ###



Kenny illustrates what the change will actually mean. 5 functions from the dynamic menus.  When you call function one and the user has responded, you can go direct to function 2 or as a parameter in to any of the other functions.  Post user responses, the sole purpose is to take you outside this set of functions.  Get service announcement does not take a response - there is no range etc.

If you called function 1 (multiple choice) and one of the options was get service announcements, you could not get it directly.  You have to call function 5 first.

The approach seems over complicated.  Simplification has a cost, that being one extra function call. Initiate dynamic menus get multiple choice, gives you  set of options, update profile (example) posted straight to the post user responses function which would then call the next function.  We put in one extra function call to the post user responses function - everything else takes a parameter and returns a question.

Why do we have 4 functions to get things.  Could be simplified if we put everything in to the post user responses function.  This would send a set of user responses and would return the next question in the sequence. To initiate this, you could send a default or empty user responses fragment, or use one of the pre-defined ID. There is an issue where post user responses function might return something outside the dynamic menus (get content list).

The reason for having post user responses came up because of search, content list and announcements.  Search has been removed. Get content list seems to be the remaining issue. All the call back functions have to have the same signature as currently defined.

Concern that changing this may limit the extensibility of the dynamic menu.

Is there a collision of menus and forms in this discussion? Putting responses back in to a menu seems challenging.  User choices and user input frame how interaction is currently managed, hesitant about equating these things to forms as this may over-complicate user interaction. There are user choice (multiple choice drop down) user input (text box) content list (special significance).

To summarise, there are three approaches:  originally conceived in the spec as it stands, proposal (in these notes), amalgamating all functions in to one.

The single function creates a tooling difficulty, it would be more complicated and error prone than it needs to be. There is a tension between those who wish to improve the architecture and those who wish to enable programming efficiency.

There is general agreement that one function is elegant but there is concern about how to develop subsequent tools.

In the revised proposal giving us a user responses function, all the other functions only take an ID. The entry point will always be multiple choice.

Proposal: get questions; set responses.  Get questions takes an ID and, at the moment, returns a grouped question. Set responses signature returns a next operation type. Why isn't the next operation type a call back, agreed it is.  It makes everything a two step function, so not efficient. We do need to create an efficient protocol. Benefit seems to be clarity, also a generalisation. Concern that this is less elegant that a single function with single step. The two-call proposal probably has the benefit of easier extensibility, but that this is not desirable.

Grouped question currently does not have anything about content list in it, this would need to be modified in the light of this proposal. The ids in get content list are different in that they relate to get content metadata, this is reason enough to retain the separation.

Entry pints to the menu.  At the top (user defined), or at search. The protocol should not define how the default entry point works, this may be a reading system characteristic.  Agreed that the definition of "home" should be considered as a separate issue, but it is a service design issue.

Why is announcement part of group question.  Agreed it should be deleted.

Do you need a call back attribute? Agreed it should be dropped.

Content list needs to be included in group questions.  If you have a content list as a direct descendent of group questions  you cannot have anything else. You can have 10 multiple choice questions and 3 text, but not a content list in this example.  Whatever is rendered should be in the order of the xml, no sequence ids.

Question type renamed to  question and multiple choice question.

Remove reference to call backs in multiple choice question.

API updated to reflect the decision to simplify number of functions, all agreed a more elegant solution.

Agreed that group questions should be renamed to questions.

Agreed that label should be included in the outer choices.

Note: there is a considerable amount of documentation to be completed associated with this function.


Should we have back?  What conditions would you call this operation? Disagreement on whether it is a player function or server. If it is a player function we need to require the server to retain ids.

There are a couple of places where we have an end point. In dynamic menus, there is no clear way of getting back, back could be a request for the previous id.
Suggestion that we have a id called back, when developing a dynamic menu you need to consider what the most logical back would be.  If we don't provide this implementations may find a way of simulating it.

Proposal 1:  allow the special case of id back (default search back), suggest that people don't make assumptions about ids being valid.
Proposal 2: Each question or multiple choice question should come with a flag/attribute  to indicate whether this is a legal point to go back to, there could then be a default.  The reading system could store the ids.

Which of the above proposals is most efficient?

Question of where the complexity should be, reading system or server.

Agreed not to have server side back and agreed not to have a back button linked to a back function on the server.  As a server you could have a back action associated with everything. Casching ids and user responses is possible.



## Posting Audio ##

### Requirement ###
Facilitate interaction with clients through uploading of feedback in an audio format.

### Issues ###
  * Potentially very expensive on server.
  * Recording audio generates wav, so players may also need to be encoders.
  * Need to compress audio would require codecs; potential cost for player developers.
  * Limiting the size and length of uploads.
  * Is the audio transmitted by soap / through the web service.

### Benefits ###
  * Easy for clients to report issues/problems.
  * Easy for clients to send requests/ask for information.


### Discussion Points ###
  * Ability to upload audio must be optional because of requirements on players.
  * Files should be posted so that a script can process and avoid soap overhead.
  * Files should go through soap to keep within the protocol and not have separate post functions outside the protocol.
  * Audio cannot be sent as part of question response; only for feedback.
  * Can only be done through the dynamic menus.

### Possible Solutions ###

#### POST ####
  * readingServiceAttributes - set @inputType=audio
  * question will require two additional attributes: requiresAudio and the postURI/postAudioURI
  * getQuestion(UserResponse(id)) with type=audio value=ignored
  * use basic authentication if required

#### SOAP ####
  * readingServiceAttributes - set @inputType=audio
  * current implementation method:
    * userResponse - @type=audio, @data=contain the audio
    * userResponse - @type=text, @value=text value
  * @data should be changed to an element because we don’t want huge audio data in it;
  * either the value attribute or data element must be present, but not both;
  * drop @type;
  * data as an element cannot be used for both because it requires base64 encoded data.


##### MTOM #####
  * Is it needed to reduce any overhead on SOAP, or more costly than it’s worth?
  * Cannot be negotiated per transaction, so either MTOM or text method must be specified.
  * Resolved that MTOM is not necessary; text (Base64) will be used (see action item below).

##### Encoding #####
  * Player may need to support a huge variety of formats to accommodate servers.
  * Should we specify WAV as a default format, using low bitrate to keep size down?
  * Should an open source codec be specified for compression? What is development cost and what support?
  * Preferable to specify a small set: WAV, MP3, MP4 AAC.
  * Add note to the specification indicating what “good behaviour” is regarding file and soap message size.

### Resolution ###
Embedding within SOAP is preferred because of the complexity of a separate post action and to keep the functionality within the current framework.

### Action item ###
Markus to note the discussion that occurred around MTOM and that it is being excluded because of potential problems with support, but that it has the ability to reduce some overhead and speed requests up and could be reviewed later.

### Question ###
getServerCharacteristics - is there a need for a function to return information about the what audio/codecs the service is capable of handling

# Thursday July 23 #

**Agreed**: drop getDateTime from API

## Scenarios ##

### Sessions and content management ###
Geoff, Jelle Martijn, Hiro

  * Session start
  * Unattended/automatic/noninteractive content transfer
  * Content transfer
  * Issue and Return

### Interactive menus ###
Nick, Kenny, Simon

  * Search
  * Interactive content selection
  * Update profile
  * Survey (Send audio/text)
  * Purchase


---


## Post-meeting action items ##
  * Matt: overall edit/review/proofing (starting a couple of weeks from now)
  * Geoff: terminology section
  * Markus/Kenny: sequence snippets: initial spec inclusion
  * ALL: Further src authoring, new snippets (eg Installments)
  * Matt: Further work on the XSD XSLT
  * Markus/Kenny: XSD and WSDL inline doc
  * Peter/Markus/Kenny: Board Recommendations paper.