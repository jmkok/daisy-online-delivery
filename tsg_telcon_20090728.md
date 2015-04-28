Present: Kenny, Hiro, Jelle, Geoff, Domonic, Nick

Regrets: markus

## Action Item Summary ##

### New Action Items ###

Kenny to check whether WSI Basic Profile supports MTOM.

Goeff to modify the scenarios.

Goeff to post [issue 94](https://code.google.com/p/daisy-online-delivery/issues/detail?id=94) to the list.

Markus to update the xsd.

### Previous Unfinished Action Items ###
  * Markus check with george/board on whether service provider discovery req remains for this version

### Actions items from face to face meeting ###

Goeff has done some work on the terminology section

Kenny has done dynamic menu usage scenarios – in src folder on svn as Kenny\_dynamic\_menus.txt

Jelle has done some work on a Client and has posted some amendment to the WSDL to Markus. WSI Basic Profile 1.1 does not allow Soap binding for MTOM.

Nick has done some work on example xml message fragments.

## Agenda/Minutes ##

### This weeks issues ###

#### [Issue 94](http://code.google.com/p/daisy-online-delivery/issues/detail?id=94) ####

Goeff suggested this issue be referred to the wider group. The scenario is that there may be a limit to the numbers being issued for download but not for streaming.

Kenny noted that we dropped the AccessMode element from contenMetaData.

#### [Issue 95](http://code.google.com/p/daisy-online-delivery/issues/detail?id=95) ####

Hiro outlined the issue. The service staff need to be able to remove an item from the customers bookshelf and have it automatically removed from the reading system and that the service would need some evidence that the item has been returned.

The group proposed to add Expired as a pre-defined ID for getContentList and that the Automatic Content Selection scenario is updated to include a call to getContentList ( Expired ).

#### [Issue 98](http://code.google.com/p/daisy-online-delivery/issues/detail?id=98) ####

Jelle expressed a preference to a separate function and that logon should return a Boolean.

Kenny agreed with Jelle.

The group proposed to leave the situation as is.

This issue is resolved.

#### [Issue 102](http://code.google.com/p/daisy-online-delivery/issues/detail?id=102) ####

Goeff proposed to add a required LastModifiedDate attribute to each resource element in contentMetadata and also to add a required attribute to each ContentItem in ContentList.

The group agreed.

#### [Issue 106](http://code.google.com/p/daisy-online-delivery/issues/detail?id=106) ####

Goeff proposed using HTTP return codes specified in Section 10 in RFC 2615.

Jelle suggested that the reading system would only render a generic error message to the user.

The group agreed to refer this discussion to the discussion of the diagnostics issue.

This issue is resolved.