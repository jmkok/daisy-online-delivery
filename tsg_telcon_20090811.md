Present: Kenny, Nick, Markus, Geoff, Simon, Jelle

Regrets: Dominic, Hiro, George

## Action Item Summary ##

### New Action Items ###
  * Kenny inform daisy-online group headsup, review starting 28th
  * Geoff and Markus analyze RequirementsDocument vs current API.
  * Kenny check whether .NET supports RPC-Literal.
  * Markus look for RPC-Literal support in other platforms.
  * Geoff add documentation to @borrowed.
  * Geoff to summarize the getContentList(borrowed/default) discussion and sent to list. See Nick's suggestion below
  * Markus replace contentMetadata/contentStandard with contentMetadata/metadata/dc:format.
  * Markus close [Issue 97](https://code.google.com/p/daisy-online-delivery/issues/detail?id=97)
  * Geoff to add rights expression langauge example to PDTB section, then close [Issue 105](https://code.google.com/p/daisy-online-delivery/issues/detail?id=105)
  * Geoff label [Issue 94](https://code.google.com/p/daisy-online-delivery/issues/detail?id=94) as an enhancement, leave open but leave out of spec
  * Kenny close [Issue 112](https://code.google.com/p/daisy-online-delivery/issues/detail?id=112)
  * Markus: implement change as in [Issue 115](https://code.google.com/p/daisy-online-delivery/issues/detail?id=115), then close
  * Markus make finite enumeration of getContentList(id), once we know whether to keep "borrowed"

### Previous Unfinished Action Items ###
  * Kenny create sample WSDL using WDL style, send to group for testing. {DONE}
  * Markus get rid of RPC arrays in XSD. {DONE}
  * Geoff check whether PDTB2 allows rights expression without requiring encryption. {ON AGENDA}
  * Nick propose closing [issue 97](https://code.google.com/p/daisy-online-delivery/issues/detail?id=97) to list with associated argumentation {ON AGENDA}
  * Markus add label inside metadata
  * Markus change metadata to dublin core {ON AGENDA}
  * Markus add contentID param to setBookmarks {DONE}
  * Markus get rid of href in favor if "uri". {DONE}
  * Kenny to check whether WSI Basic Profile supports MTOM. {DONE. ws-i basic profile 1.1 does not support mtom; ws-i basic profile 1.2 does.}
  * Geoff to modify the scenarios.
  * Geoff to post [issue 94](https://code.google.com/p/daisy-online-delivery/issues/detail?id=94) to the list. {DONE}
  * Markus check with george/board on whether service provider discovery req remains for this version {DONE}
  * Matt: overall edit/review/proofing
  * Geoff: terminology section (geoff has started work on the terminology section)
  * Markus/Kenny: sequence snippets: initial spec inclusion (usage scenarios for the dynamic menus are done. these scenarios can be found in the scn-temp folder in the src folder on the svn in a file called "Dynamic Menu Usage Scenarios.txt")
  * ALL: Further src authoring, new snippets (eg Installments)
  * Matt: Further work on the XSD XSLT (matt has almost finished work on the xsd xslt; only the final touches are left)
  * Markus/Kenny: XSD and WSDL inline doc
  * markus/kenny: Add "expired," "borrowed" and "default" as the three possible parameter values to the getContentList function in the documentation. {ON AGENDA}
  * Markus/kenny: Define the logOn function in the wsdl to return a boolean. a separate function called getServiceAttributes needs to be kept in the wsdl to return the attributes of a service. {DONE}
  * markus/kenny: Add a required lastModifiedDate attribute (or element) to each contentItem element in the contentList type (the lastModifiedDate of a contentItem element is the last modified date of the most recently modified resource in the publication being represented by the particular contentItem element). A required lastModifiedDate attribute also needs to be added to the resource element in the contentmetadata type.
  * markus/kenny: add a pointer to HTTP return codes specified in Section 10 in RFC 2615 in the documentation for situations where a uri to a resource is not valid for some reason. (refers to [issue 106](https://code.google.com/p/daisy-online-delivery/issues/detail?id=106))
  * Nick prepare sample instances of the Daisy Online types. {DONE}
  * Peter/Markus/Kenny: Board Recommendations paper.

## Agenda/Minutes ##

### Timelines going forward (revisit w Matt) ###
| start final Edit/Proofing (Matt) | August 28 |
|:---------------------------------|:----------|
| review by larger online group | August 28 |
| delivered to board | **September 10** |

Geoff confirms that Matt is available for edit.

@Kenny inform daisy-online group headsup, review starting 28th

@Geoff and @Markus analyze RequirementsDocument vs current API.

### Wrapped Document Literal Style ###

Discussion around the sample sent out by Kenny yesterday.

How do we get to a final decision re use of this style?

Geoff: why dont we use RPC-Literal?

Kenny: WDL is a subset of DL.

Geoff: is our version of it fully specified? I know the style isn't fully specified in general.

Geoff: I think we have two choices: RPC-Literal or WDL. But I dont think we have to worry as long as our messages are fully defined in the WSDL. So the question becomes: are our message fully defined?

@Kenny check whether .NET supports RPC-Literal.
@Markus look for RPC-Literal support in other platforms.

Postponing decision to use the Wrapped Document Literal. **If** we go there, the spec needs prose (in "protocol fundamentals" section) that normatively references SOAP Document Literal with the addition of explaining wrapping is.

### This weeks issues ###

#### getContentList(default/borrowed/expired) ####
As per previos telcon. The following questions need to be answered:
  * Are these three values the only ones that getContentList can take, or do we support arbitrary IDs as well? **Answer: these are the only three allowed values; @markus make enumeration.**
  * is contentMetadata/@borrowed now redundant? (getContentList(borrowed/expired) pushes the task of owning lists to the service; the RS does not need to track this) OTOH, how would a player know that it needs to call getContentList(expired)

@Geoff add documentation to @borrowed. **Keeping borrowed**

Geoff: getContentList(default) and getContentList(expired) are only used during noninteractive session.

  * Are the values default and borrowed sufficiently distinct? Is it clear when which of them should be used?

Geoff: **default**==list of content that the service makes available to the RS, and the RS decides whether its want to download that**. "heres all the stuff that you should have".**

Nick: certainly think there are three list:
  * borrowed: content items which services has on loan to the RS
  * expired: list of content items the service wishes to retract
  * default: the new content items that you could now put on your system

Geoff: So the question is: does borrowed have a use elsewhere?

Kenny: think Hiros use case was the concept of the bookshelf. "Ringing up customer service and have them manage the bookshelf".

**Nick: one suggestion rename "default" to "available" and clarify that this list contains both new content and content that the RS may already have downloaded.**

@Geoff to summarize discussion and send to list (Hiro needs to comment).

#### [Issue 94](https://code.google.com/p/daisy-online-delivery/issues/detail?id=94) ####
Geoff: suggest that its leaved out in the draft, we can add-in later if necessary.

#### [Issue 97](https://code.google.com/p/daisy-online-delivery/issues/detail?id=97) ####
Followup from list discussion. We can close this? **Issue closed**

#### [Issue 100](https://code.google.com/p/daisy-online-delivery/issues/detail?id=100) ####
Done, but suggest replacing contentMetadata/contentStandard with contentMetadata/metadata/dc:format. **All agree @markus to implement.**

#### [Issue 105](https://code.google.com/p/daisy-online-delivery/issues/detail?id=105) ####
Followup, actions?

Geoff: it is possible to use rights expression language without encryption.

Markus: we should add an example to the spec. @Geoff to put that in there.

#### [Issue 112](https://code.google.com/p/daisy-online-delivery/issues/detail?id=112) ####

Kenny: primarily interesting for label inside sample

Not necessary with size attribute on the label element. **Issue closed**

Geoff: size is available in the http header (content-length) anyway

Geoff: on the resource element, the size attribute is there so that RS can make a decision ahead of time

#### [Issue 113](https://code.google.com/p/daisy-online-delivery/issues/detail?id=113) ####
postponed

#### [Issue 114](https://code.google.com/p/daisy-online-delivery/issues/detail?id=114) ####
postponed

#### [Issue 115](https://code.google.com/p/daisy-online-delivery/issues/detail?id=115) ####
@markus: add the change suggested