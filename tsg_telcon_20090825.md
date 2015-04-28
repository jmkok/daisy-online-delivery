

Present: Markus (scribe), Geoff, Dominic, Kenny, Hiro, Nick, George, Jelle, Simon, Matt

Regrets:

## Action Item Summary ##

### New Action Items ###
  * Kenny: write prose for **4.4 Dynamic Menus** (informative intro with samples)
  * Kenny: find all WSDL remark elements pertaining to dynamic menus and add prose etc
  * Kenny: add a pointer to HTTP return codes specified in Section 10 in RFC 2615 in the documentation for situations where a uri to a resource is not valid for some reason. (then close [issue 106](https://code.google.com/p/daisy-online-delivery/issues/detail?id=106)). Note: this could actually go into Jelle's section: Kenny: send stuff to Jelle.
  * Jelle: write prose for **5.1.1 http(s) authentication**
  * Geoff: write prose for **5.3.3. Downloading and streaming of content**
  * Geoff: write prose on how installments work in section 5, then close [Issue 102](https://code.google.com/p/daisy-online-delivery/issues/detail?id=102).
  * Nick: write prose for **5.6. Bookmarks and Last Reading Position, inc samples**
  * Nick, in writing the prose and producing a bookmark sample, solve [Issue 34](https://code.google.com/p/daisy-online-delivery/issues/detail?id=34) and [Issue 119](https://code.google.com/p/daisy-online-delivery/issues/detail?id=119)
  * Markus: implement all issue resolutions below except that for [Issue 106](https://code.google.com/p/daisy-online-delivery/issues/detail?id=106).

### Previous Unfinished Action Items ###
  * Jelle: propose resolution to [Issue 118](https://code.google.com/p/daisy-online-delivery/issues/detail?id=118)
  * Kenny modify dynamic menu usage scenarios to reflect [Issue 114](https://code.google.com/p/daisy-online-delivery/issues/detail?id=114) changes. {done}
  * Geoff and Markus analyze RequirementsDocument vs current API. {ONGOING}
  * Geoff label [Issue 94](https://code.google.com/p/daisy-online-delivery/issues/detail?id=94) as an enhancement, leave open but leave out of spec
  * markus/kenny: Add a required lastModifiedDate attribute (or element) to each contentItem element in the contentList type (the lastModifiedDate of a contentItem element is the last modified date of the most recently modified resource in the publication being represented by the particular contentItem element). A required lastModifiedDate attribute also needs to be added to the resource element in the contentmetadata type. {Think DONE, but spec prose on installments is not} See also [Issue 140](https://code.google.com/p/daisy-online-delivery/issues/detail?id=140).
  * kenny: add a pointer to HTTP return codes specified in Section 10 in RFC 2615 in the documentation for situations where a uri to a resource is not valid for some reason. (refers to [issue 106](https://code.google.com/p/daisy-online-delivery/issues/detail?id=106))


## Agenda/Minutes ##

### Call on friday ###
Another call on friday to deal with any remaining issues, handover to Matt, identify work to be done concurrently with Matt (such as CSS and [Issue 129](https://code.google.com/p/daisy-online-delivery/issues/detail?id=129))

### sample production aids ###
The build now outputs ./build/temp-extracted.xsd, which is the XSD island in the WSDL. With this, one can author samples using a schema-aware editor.

### Major spec sections remaining to be written ###

Assign responsible names to:
  * 4.4 Dynamic Menus (informative intro with samples) (@Kenny)
  * 5.1.1 http(s) authentication (@Jelle)
  * 5.3.3. Downloading and streaming of content "Geoff
  * 5.6. Bookmarks and Last Reading Position, inc samples and solving [Issue 34](https://code.google.com/p/daisy-online-delivery/issues/detail?id=34) and solving [Issue 119](https://code.google.com/p/daisy-online-delivery/issues/detail?id=119) @Nick
  * WSDL remark elements (all pertaining to dynamic menus) @Kenny

### Issues ###
#### [Issue 135](https://code.google.com/p/daisy-online-delivery/issues/detail?id=135) ####
Should all Services be required to support out-of-band content selection?

**Resolution**: add prose to the effect of **recommending** that Services support out-of-band CS. Explain that a RS that doesnt support dynamic menus would "fall back" to out-of-band.

#### [Issue 132](https://code.google.com/p/daisy-online-delivery/issues/detail?id=132) ####
Move @borrowed to contentItem? Good counter-argument in tracker. change name to requiresReturn either case.

**Resolution**: retain on metadata, change name to requiresReturn, require getContentmetdata in the sequence

#### [Issue 120](https://code.google.com/p/daisy-online-delivery/issues/detail?id=120) ####
Think this one is solved: yes, it needs to support arbitrary IDs to support segmented contentLists returned from dynamic menu sessions.

**Resolution**: allow arbitrary IDs. questions should be changed to a contentList reference instead of type.

#### [Issue 119](https://code.google.com/p/daisy-online-delivery/issues/detail?id=119) ####
Nick is addressing this.

#### [Issue 133](https://code.google.com/p/daisy-online-delivery/issues/detail?id=133) ####
Nick: the URL may point to a script, may not contain the file name.
**Resolution**: specify that its relative Content root directory, and that must be a valid relative URI.

#### [Issue 139](https://code.google.com/p/daisy-online-delivery/issues/detail?id=139) ####
**Resolution**: move both to serviceAttributes, make clear that provider is serviceProvider

#### [Issue 140](https://code.google.com/p/daisy-online-delivery/issues/detail?id=140) ####
**Resolution**: Make attributes optional

#### [Issue 131](https://code.google.com/p/daisy-online-delivery/issues/detail?id=131) ####
**Resolution**: make required

#### [Issue 106](https://code.google.com/p/daisy-online-delivery/issues/detail?id=106) ####
**Resolution**: kenny: add a pointer to HTTP return codes specified in Section 10 in RFC 2615 in the documentation for situations where a uri to a resource is not valid for some reason. (refers to [issue 106](https://code.google.com/p/daisy-online-delivery/issues/detail?id=106)).

### [Issue 79](https://code.google.com/p/daisy-online-delivery/issues/detail?id=79) ###
Making an extensible enum here is still marked as a TODO in the XSD.
**Resolution**: make clear that its extensible, either through XSD or spec prose


### Commit 300 ###
Discussion around [r300](https://code.google.com/p/daisy-online-delivery/source/detail?r=300), the commit comment of which is replicated below:

This commit is a first stab at clarifying and defining targeted constraints on the interaction variation matrix constituted by
  * whether content is borrowed or "one way"
  * whether content is selected "noninteractively" (getContentList(new)) or interactively (via dynamic menus)

We introduce two new high-level concepts:
  * "Service Types" which are two: library-type (requiring content return) and shop-type (not requiring content return)
  * "Content Provision Models", which are two: 'out-of-band' (aka telephone or separate webform content selection) and 'browse'(aka "dynamic menus" selection). This refers to which process is used when the two parties negotiate and select content items to request issuance of.  (The actual terms "out-of-band" and "browse" can be replaced by better name alternatives)

It is pointed out that these styles and models are not exclusive - that they **may** be combined:
  * A service may have some content it borrows, some it sells, and some it offers for free. This means that the Service is both library-type and shop-type
  * In a given session, a Reading System may request a precomposed contentlist (via getContentList(new)), and it may also use dynamic menus to create contentlists via, say, search. This means that both the 'out-of-band' and 'browse' content provision models can be used during the same session.

Consequences in API are mostly declarative:
1. A service must declare in serviceAttributes whether it supports the content provision out-of-band model (and if it does, it must support getContentList(new)).[1](1.md)

2. A service must declare in serviceAttributes whether it supports the content provision BROWSE model (and if it does, it must support getQuestion()).[2](2.md)
Note - getQuestion may be supported by a Service for reasons other than to support the browse provision model. Therefore, supportedOptionalOperations/DYNAMIC\_MENUS remains and can be true while support for browse provision mode is false, but not vice versa.

3. Because a service may choose to only support the browse model, getContentList is made an optional operation, but by means of spec prose it is stated that a service must support at least one of getContentList(new) and getQuestion. (This is stated by requiring a service to declare either or both of OUT\_OF\_BAND and BROWSE in [1](1.md),[2](2.md))(at least one required by the schema)

4. A service mustn't really declare whether it is "library-style" (eg borrowing content), because this can be said to be implied by @borrowed in the individual contentMetadatas, but it doesn't hurt with an upfront declaration of this in serviceAttributes. Same goes for the shop-style. [3](3.md),[4](4.md) (at least one required by the schema)

5. If a Service is of the library-style type (eg supports borrow), it must support getContentList(expired) and getContentList(issued)

Note - If a Service is exclusively of the shop-style type (eg supports only purchased or free content), it doesnt really have to support any getContentList, except if it allows Out-of-band content provision, in which case it must support getContentList(new)). Shop-style Services **may** support getContentList(issued) (eg "this is all the stuff you ever bought from us") if they want to.

{1} serviceAttributes/supportedContentProvisionModels/provisionModel/OUT\_OF\_BAND

{2} serviceAttributes/supportedContentProvisionModels/provisionModel/BROWSE

{3} serviceAttributes/supportedServiceTypes/serviceType/LIBRARY

{4} serviceAttributes/supportedServiceTypes/serviceType/SHOP

### Previous Finished Action Items ###

  * Markus push WDL version of WSDL to SVN, then notify group. Make sure that all recent WSDL edits are pushed to the new version.
  * Geoff: Talk to Hiro about getContentList: two or three IDs (see notes below)
  * Markus: 115 to "keyRing"
  * Markus: make returnContent optional
  * Markus: implement changes are per [Issue 114](https://code.google.com/p/daisy-online-delivery/issues/detail?id=114) discussion below
  * Kenny inform daisy-online group headsup, review starting 28th {DONE}
  * Geoff and Markus analyze RequirementsDocument vs current API. {ONGOING}
  * Kenny check whether .NET supports RPC-Literal. {done. WCF does support RPC-Literal. Wrapped Document Literal is the default in wcf. Older versions of .net do not support RPC-Literal.}
  * Markus look for RPC-Literal support in other platforms.
  * Geoff add documentation to @borrowed.
  * Geoff to summarize the getContentList(borrowed/default) discussion and sent to list. See Nick's suggestion below {DONE}
  * Markus replace contentMetadata/contentStandard with contentMetadata/metadata/dc:format. {DONE}
  * Geoff to add rights expression language example to PDTB section, then close [Issue 105](https://code.google.com/p/daisy-online-delivery/issues/detail?id=105)

  * Markus close [Issue 97](https://code.google.com/p/daisy-online-delivery/issues/detail?id=97) {DONE}
  * Kenny close [Issue 112](https://code.google.com/p/daisy-online-delivery/issues/detail?id=112) {DONE}
  * Markus: implement change as in [Issue 115](https://code.google.com/p/daisy-online-delivery/issues/detail?id=115), then close {DONE}
  * Markus make finite enumeration of getContentList(id), once we know whether to keep "borrowed"
  * Kenny create sample WSDL using WDL style, send to group for testing. {DONE}
  * Markus get rid of RPC arrays in XSD. {DONE}
  * Geoff check whether PDTB2 allows rights expression without requiring encryption. {DONE. PDTB2 does allow Rights Expression language without encryption.}
  * Nick propose closing [issue 97](https://code.google.com/p/daisy-online-delivery/issues/detail?id=97) to list with associated argumentation {DONE}
  * Markus add label inside metadata
  * Markus change metadata to dublin core {DONE}
  * Markus add contentID param to setBookmarks {DONE}
  * Markus get rid of href in favor if "uri". {DONE}
  * Kenny to check whether WSI Basic Profile supports MTOM. {DONE. ws-i basic profile 1.1 does not support mtom; ws-i basic profile 1.2 does.}
  * Geoff to modify the scenarios.
  * Geoff to post [issue 94](https://code.google.com/p/daisy-online-delivery/issues/detail?id=94) to the list. {DONE}
  * Markus check with george/board on whether service provider discovery req remains for this version {DONE}
  * Matt: overall edit/review/proofing
  * Geoff: terminology section {geoff has started work on the terminology section}
  * Markus/Kenny: sequence snippets: initial spec inclusion {usage scenarios for the dynamic menus are done. these scenarios can be found in the scn-temp folder in the src folder on the svn in a file called "Dynamic Menu Usage Scenarios.txt"}
  * ALL: Further src authoring, new snippets (eg Installments)
  * Matt: Further work on the XSD XSLT {matt has almost finished work on the xsd xslt; only the final touches are left}
  * Markus/Kenny: XSD and WSDL inline doc
  * markus/kenny: Add "expired," "borrowed" and "default" as the three possible parameter values to the getContentList function in the documentation. {ON AGENDA}
  * Markus/kenny: Define the logOn function in the wsdl to return a boolean. a separate function called getServiceAttributes needs to be kept in the wsdl to return the attributes of a service. {DONE}
  * Nick prepare sample instances of the Daisy Online types. {DONE}
  * Peter/Markus/Kenny: Board Recommendations paper.