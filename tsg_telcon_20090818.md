

Present: George, Markus, Kenny, Geoff, Simon, Jelle, Markus (scribe), Nick

Regrets: Hiro



## Action Item Summary ##

### New Action Items ###
  * Markus push WDL version of WSDL to SVN, then notify group. Make sure that all recent WSDL edits are pushed to the new version.
  * Geoff: Talk to Hiro about getContentList: two or three IDs (see notes below)
  * Markus: implement changes are per [Issue 114](https://code.google.com/p/daisy-online-delivery/issues/detail?id=114) discussion below
  * Kenny modify dynamic menu usage scenarios to reflect [Issue 114](https://code.google.com/p/daisy-online-delivery/issues/detail?id=114) changes.
  * Markus: 115 to "keyRing"
  * Markus: make returnContent optional
  * Jelle: propose resolution to [Issue 118](https://code.google.com/p/daisy-online-delivery/issues/detail?id=118)


### Previous Unfinished Action Items ###
  * Kenny inform daisy-online group headsup, review starting 28th {DONE}
  * Geoff and Markus analyze RequirementsDocument vs current API. {ONGOING}
  * Kenny check whether .NET supports RPC-Literal. {done. WCF does support RPC-Literal. Wrapped Document Literal is the default in wcf. Older versions of .net do not support RPC-Literal.}
  * Markus look for RPC-Literal support in other platforms.
  * Geoff add documentation to @borrowed.
  * Geoff to summarize the getContentList(borrowed/default) discussion and sent to list. See Nick's suggestion below {DONE}
  * Markus replace contentMetadata/contentStandard with contentMetadata/metadata/dc:format. {DONE}
  * Markus close [Issue 97](https://code.google.com/p/daisy-online-delivery/issues/detail?id=97) {DONE}
  * Geoff to add rights expression language example to PDTB section, then close [Issue 105](https://code.google.com/p/daisy-online-delivery/issues/detail?id=105)
  * Geoff label [Issue 94](https://code.google.com/p/daisy-online-delivery/issues/detail?id=94) as an enhancement, leave open but leave out of spec
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
  * markus/kenny: Add a required lastModifiedDate attribute (or element) to each contentItem element in the contentList type (the lastModifiedDate of a contentItem element is the last modified date of the most recently modified resource in the publication being represented by the particular contentItem element). A required lastModifiedDate attribute also needs to be added to the resource element in the contentmetadata type.
  * markus/kenny: add a pointer to HTTP return codes specified in Section 10 in RFC 2615 in the documentation for situations where a uri to a resource is not valid for some reason. (refers to [issue 106](https://code.google.com/p/daisy-online-delivery/issues/detail?id=106))
  * Nick prepare sample instances of the Daisy Online types. {DONE}
  * Peter/Markus/Kenny: Board Recommendations paper.

## Agenda/Minutes ##

### Wrapped Document Literal Style ###

  * Wrapped Document Literal Style support in various platforms?
  * WSDL results?
  * Decision: RPC-Literal or Wrapped Document Literal?

  * **Suggestion: Go for Wrapped Document Literal in the Draft release**

Group decides to go for WDL

@Markus will push new version to SVN, then notify group. Make sure that all recent WSDL edits are pushed to the new version.


### This weeks issues ###

#### getContentList(default/borrowed/expired) ####
  * is "borrowed" still required?

Geoff:

> After discussion on the telecon this morning, I think there is need for
> only two defined  content lists: "expired" and "available".  "available"
> would contain a list of all the content available to the user, whether
> borrowed, purchased, or given without charge (such as the latest edition
> of a free periodical subscription).  "expired" would contain a list of
> the content on loan from the service that the service providers wish
> to take away from the user.

> I think this may clear up some of the confusion between the "default"
> and "borrowed" lists.  I don't think we need an explicit "borrowed"
> list, since the contentMetadata for each item has a "borrowed" attribute
> to say whether the material is on loan or not.  At that point, it's a
> reading system function to keep track of it being borrowed.  Hiro, or
> anyone else, please let us know if there's another reason to have a
> "borrowed" content list.

Kenny:

> I am not as yet able to fathom the implications of a getContentList("available").
> does this mean that in our scenario, as described above, we would need to return
> all back-issues of all newspapers and magazines, that the user has subscribed to,
> and that the user has downloaded since her subscription?

**Suggestion: three exclusive lists**
  * "expired" is clear: a list of issued content that must be returned/deleted
  * "issued" is a list of all content that has been issued, whether it has been downloaded or not, and whether or not the content is borrowed, free, or bought
  * "new" is a list of content that has not yet been issued that the user may choose to have issued

  * The spec should note that service providers may remove items from the "issued" list
    * when content gets outdated or otherwise becomes irrelevant
    * based on an [undefined](undefined.md) measure of the content having been accessed.

Note: Maybe contentMetadata/@borrowed needs a name change

Geoff: note that these would only be used in automatic transfer model: here having issued and new as separate IDs isnt necessary.

#### [Issue 113](https://code.google.com/p/daisy-online-delivery/issues/detail?id=113) ####
**Suggestion: See below ([issue 114](https://code.google.com/p/daisy-online-delivery/issues/detail?id=114))**

#### [Issue 114](https://code.google.com/p/daisy-online-delivery/issues/detail?id=114) ####

**Suggestion:**
  * require issueContent to have been called before getContentMetadata (regardless of borrowed, bought or free)
  * move the sample element to the contentList type
  * (note: sample can have multiple labels, label/audio has rangeBegin, rangeEnd and size attributes)
  * make clear that Services must allow one, but may several calls to getContentMetadata after issuance over several sessions

Kenny: should we change the content model of sample to "resources" (eg allow the sample to be a DTB). **Decision to change sample content type.** Geoff: we could use a format attribute on resources.

Geoff:
One core problem is that metadata+sample and resources are in the same type

Kenny:
How about splitting up like this:
  * getContentList
  * {optionally call} getContentMetadata (gives metadata and sample(s))
  * issueContent returns boolean
  * getContentResources returns resources

Simon: suggest that samples are provided as an id, instead of resources inline

@markus do changes as above
@Kenny modify dynamic menu usage scenarios to reflect the above.

#### [Issue 115](https://code.google.com/p/daisy-online-delivery/issues/detail?id=115) ####
Already an action item on @Markus. New name is "keyRing".

#### [Issue 116](https://code.google.com/p/daisy-online-delivery/issues/detail?id=116) ####
@markus make returnContent optional

#### [Issue 117](https://code.google.com/p/daisy-online-delivery/issues/detail?id=117) ####
Geoff: suggesting that rather than using the URL scheme (we are using userInfo in a nonstandard way), have an explicit attribute (user:colon scheme).

Jelle: I dont see the problem.

Nick: I dont mind either way.

Geoff: I think I misread the http spec. @Geoff: Mark this issue as invalid.

#### [Issue 118](https://code.google.com/p/daisy-online-delivery/issues/detail?id=118) ####
Need to be clear that http session and protocol session are not the same thing. The question is: do you set the cookie immediately or after logOn?

Geoff: suggest that we make http session and protocol session the same thing.

@Jelle propose where we should be going with 118.