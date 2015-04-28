Present: George, Kenny, Markus, Jelle, Geoff, Simon, Nick

Regrets: Matt

## Action Item Summary ##

### New Action Items ###
  * Kenny create sample WSDL using WDL style, send to group for testing.
  * Markus get rid of RPC arrays in XSD.
  * Geoff check whether PDTB2 allows rights expression without requiring encryption.
  * Nick propose closing [issue 97](https://code.google.com/p/daisy-online-delivery/issues/detail?id=97) to list with associated argumentation
  * Markus add label inside metadata, change to dublin core.
  * Markus add contentID param to setBookmarks
  * Markus get rid of href in favor if "uri".


### Previous Unfinished Action Items ###

  * Kenny to check whether WSI Basic Profile supports MTOM. (done. ws-i basic profile 1.1 does not support mtom; ws-i basic profile 1.2 does.)
  * Geoff to modify the scenarios.
  * Geoff to post [issue 94](https://code.google.com/p/daisy-online-delivery/issues/detail?id=94) to the list.
    * Markus check with george/board on whether service provider discovery req remains for this version
  * Matt: overall edit/review/proofing
  * Geoff: terminology section (geoff has started work on the terminology section)
  * Markus/Kenny: sequence snippets: initial spec inclusion (usage scenarios for the dynamic menus are done with the exception of the Back Usage Scenario. these scenarios can be found in the scn-temp folder in the src folder on the svn in a file called kenny-dynamic-menus.txt)
  * ALL: Further src authoring, new snippets (eg Installments)
  * Matt: Further work on the XSD XSLT (matt has almost finished work on the xsd xslt; only the final touches are left)
  * Markus/Kenny: XSD and WSDL inline doc
  * markus/kenny: Add "expired," "borrowed" and "default" as the three possible parameter values to the getContentList function in the documentation.
  * Markus/kenny: Define the logOn function in the wsdl to return a boolean. a separate function called getServiceAttributes needs to be kept in the wsdl to return the attributes of a service.
  * markus/kenny: Add a required lastModifiedDate attribute (or element) to each contentItem element in the contentList type (the lastModifiedDate of a contentItem element is the last modified date of the most recently modified resource in the publication being represented by the particular contentItem element). A required lastModifiedDate attribute also needs to be added to the resource element in the contentmetadata type.
  * markus/kenny: add a pointer to HTTP return codes specified in Section 10 in RFC 2615 in the documentation for situations where a uri to a resource is not valid for some reason. (refers to [issue 106](https://code.google.com/p/daisy-online-delivery/issues/detail?id=106))
  * Nick prepare sample instances of the Daisy Online types. (nick has begun work on this)
  * Peter/Markus/Kenny: Board Recommendations paper.

## Agenda/Minutes ##

### Timelines going forward ###
| start final Edit/Proofing (Matt) | August 28? |
|:---------------------------------|:-----------|
| delivered to board | **September 10** |


### This weeks issues ###

#### [Issue 93](https://code.google.com/p/daisy-online-delivery/issues/detail?id=93) ####
Suggesting that we procrastinate until all other issues are resolved.

#### [Issue 97](https://code.google.com/p/daisy-online-delivery/issues/detail?id=97) ####
Geoff: Doesnt seem that serialNumber plays an actual part in the key exchange.
Nick: Only requirement is that there is an instance key of some kind.
@Nick propose closing [issue 97](https://code.google.com/p/daisy-online-delivery/issues/detail?id=97) to list with associated argumentation

#### [Issue 100](https://code.google.com/p/daisy-online-delivery/issues/detail?id=100) ####
Decision to use DC terms where applicable.

#### [Issue 101](https://code.google.com/p/daisy-online-delivery/issues/detail?id=101) ####
Decision to use labels inside metadata. Markus to implement.

#### [Issue 105](https://code.google.com/p/daisy-online-delivery/issues/detail?id=105) ####
Geoff check whether PDTB2 allows rights expression without requiring encryption.

#### [Issue 107](https://code.google.com/p/daisy-online-delivery/issues/detail?id=107) ####
Decision to add a second parameter to setBookmarks which is String:contentID

#### [Issue 108](https://code.google.com/p/daisy-online-delivery/issues/detail?id=108) ####
Decision to get rid href name in favor of "uri".

#### [Issue 109](https://code.google.com/p/daisy-online-delivery/issues/detail?id=109) ####
Kenny: The different styles apply to the soap body element. Microsoft only supports "wrapped document literal". Kenny commented that in the document literal style you dont have the operation name which is  a problem when soap stacks dispatch the content of the soap body to an operation. the wrapped document literal style solves this problem by including the operation name in the soap body.

Markus: do we have to mandate one of these styles or can we leave it open? Kenny: we would need multiple WSDLs, and would likely run into interop problems. Kenny suggests that we mandate the use of one style.

Note: The WDL style is essentially the dl style and thus is permitted by ws-i basic profile 1.1, along with the rpc literal style.

Kenny: if we go for WDL, the messages in the WSDL, as it stands right now, will need to change.

### Service Provider Discovery ###
Group concludes that SPD should be published as a separate document.