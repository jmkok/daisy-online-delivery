


---


# In-scope #

## Content Management ##

### Efficient use of bandwidth ###
The protocol must support efficient use of bandwidth. _(Original requirement 2 (1). User Story: [Authorization of content (server)](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Authorization_of_content_(server)))_

### Key authorization ###
The protocol must support efficient key authorization checking. _(Original requirement 2 (2). User Story: [Authorization of content (server)](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Authorization_of_content_(server)))_

### Transmit bookmarks ###
The protocol must allow the transmission of bookmarks as separately from the associated content. The protocol should recognize bookmarks as non-book content. _(Original requirements 6, 33 and 36. User Stories: [Keep bookmarks](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Keep_bookmarks), [Bookmark content](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Bookmark_content) and [Preset bookmarks](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Preset_bookmarks))_

### Return book ###
The Reading System must be able to notify the Service that content has been deleted (e.g. for a limited lending programme where a user may only have a certain number of books withdrawn at one time). _(Original requirement 8 (modified). User Story: [Return book](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Return_book))_

### Transmit capabilities ###
The protocol must be support the transmission of the class and capabilities of the Reading System to the Service. _(Original requirement 12. User Story: [Determine player capabilities](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Determine_player_capabilities))_

### Universal protocol ###
The protocol must be the same between organizations. _(Original requirement 15 (1). User Story: [Access content from different organizations](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Access_content_from_different_organizations))_

### Player stores contact information ###
The Reading System must store contact information for each service/organization. _(Original requirement 15 (2). User Story: [Access content from different organizations](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Access_content_from_different_organizations))_

### Content at different location ###
The protocol must support content being at different location to the user information. _(Original requirement 17 (1). User Story: [Centralized authentication](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Centralized_authentication))_

### Time interrogation ###
The protocol must allow the interrogation of time by the Reading System. _(Original requirement 21. User Story: [Expiration date for content](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Expiration_date_for_content))_

### Download and streaming ###
The protocol must support both downloading and streaming of content. _(Original requirement 62. User Story: [Provide content](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Provide_content))_

### Key delivery ###

The Reading System must be able to request keys for use with PDTB2 by their key identifier and by the identifiers of a set of key pairs, one of which is to be used for encrypting the requested key. The Service must be able to provide a Key Exchange Object to a valid key request, or to reply that the Reading System is not authorized to receive that key. _(New requirement. User Story: [Key delivery](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Key_delivery))_


---


## User Control ##

### Same book, different player ###
The protocol must allow a user to download the same book to multiple Reading Systems. _(Original requirement 3 (1). User Story: [Different devices, same content](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Different_devices,_same_content))_

### Bookmark stored on server ###
The protocol must support transmission of bookmarks to and from the Service. _(Original requirement 3 (2). User Story: [Different devices, same content](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Different_devices,_same_content))_

### Issue content ###
The Reading System must be able to request content.  The Service must be able to approve or deny the request. _(Original requirement 10 (modified). User Story: [Confirm user wants book](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Confirm_user_wants_book))_

### Audio and text annotation ###
The protocol must support audio and text annotation of content lists. _(Original requirement 14. User Story: [Choose book from narrative](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Choose_book_from_narrative))_

### Stop and resume download ###
The Reading System must be able to stop and resume downloads. _(Original requirement 18. User Story: [Interact with a download](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Interact_with_a_download))_

### Dynamic menus ###
The Service must be able to provide an interactive session and a means of selecting content. _(New requirement. User Stories: [Advanced service (server)](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Advanced_service_(server)) and [Advanced service (user)](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Advanced_service_(user)))_

### Noninteractive session ###
The Service must be able to provide a noninteractive session where preselected content is transferred automatically to the Reading System. User Stories: [Basic service (server)](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Basic_service_(server)) and [Basic service (user)](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Basic_service_(user)))


---


## Preview ##

### Prioritize order of files ###
The Service must be able to order the files for each content item. _(Original requirement 4. User Story: [Ability to play before download is complete](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Ability_to_play_before_download_is_complete))_

### Interact with content ###
The protocol must support interaction with the content. _(Original requirement 5. User Story: [Review content before selection](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Review_content_before_selection))_


---


## Information Management ##

### Report firmware version ###
The Reading System must be able to report its vendor, model, instance and version. _(Original requirement 16 (2). User Story: [Diagnose player status](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Diagnose_player_status))_

### Report download activity ###
The protocol must support reporting download activity. _(Original requirement 16 (3). User Story: [Diagnose player status](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Diagnose_player_status))_

### Report player errors ###
The protocol should support transmission of error messages from the Reading System to the Service. _(Original requirement 7 (modified). User Stories: [Diagnose player status](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Diagnose_player_status), [Tell server download failed](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Tell_server_download_failed) and [Error code knowledge base](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Error_code_knowledge_base))_

### Report which server is in control ###
The protocol must report which server is in control. _(Original requirement 16 (5). User Story: [Diagnose player status](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Diagnose_player_status))_

### Protect user privacy ###
The protocol must ensure protection of the user's privacy. _(Original requirement 20. User Story: [No personal information](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#No_personal_information))_

### Localized, plain language error messages ###
Error messages sent from the Service to the Reading System must be easily modified to provide meaningful information in plain language of the user. _(Original requirement 24. User Story: [Meaningful error messages](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Meaningful_error_messages))_


---


# Out-of-scope #

## Content Management ##

### Report number of books ###
The Reading System must be able to notify the Service how may books the user has on it. _(Original requirement 9. User Story: [Maximum entries in a bookshelf](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Maximum_entries_in_a_bookshelf))_

### Ping servers ###
The Reading System must periodically ping the Service and report its status. _(Original requirement 13. User Story: [Know if player is online](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Know_if_player_is_online))_

### Transmit storage space ###
The protocol must support the transmission of the storage available on the Reading System to the Service. _(Original requirement 22. User Story: [Enough space to store content (server)](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Enough_space_to_store_content_(server)))_

### Suggest mirrors ###
The protocol must support the Service suggesting mirror sites to download the content from. _(Original requirement 17 (2). User Story: [Centralized authentication](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Centralized_authentication))_

### Trace routing ###
Trace routing must be supported. _(Original requirement 17 (3). User Story: [Centralized authentication](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Centralized_authentication))_

### Initial transaction ###
Initial transaction between when a Reading System is first turned on and the Service. _(Original requirement 27. User Story: [Content provider discovery](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Content_provider_discovery))_ This was the requirement for Service discoverability.


---


## User Control ##

### Requires some player functionality ###
Requires some Reading System functionality as well. _(Original requirement 19. User Story: [Give feedback](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Give_feedback))_

### Identify and transfer service provider ###
The protocol must support identification and transference of the primary service provider. _(Original requirement 60. User Story: [Switch primary content provider](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Switch_primary_content_provider))_ This was moved out of scope because it is a reading system function.

### User preferences stored on server ###
The Reading System must be able to store and request playback settings on and from the Service. _(Original requirement 61. User Story: [Player settings](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Player_settings))_ The subgroup saw little benefit to this function, but is keeping the issue open for a later version.


---


## Information Management ##

### Report player's status ###
Protocol must report the Reading System's status. _(Original requirement 16 (1). User Story: [Diagnose player status](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Diagnose_player_status))_

### Variety of system messages ###
The protocol must allow transmission of a variety of system messages. _(Original requirement 11. User Story: [Push system messages](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Push_system_messages))_


---


## Organization Control ##

### Without user interaction ###
The protocol must support background communication without user interaction as much as possible. _(Original requirement 25. User Story: [Unobtrusive service](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Unobtrusive_service))_

### New service registration ###
The protocol must support registration with a new service provider. _(Original requirement 28. User Story: [Subscribe to services](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Subscribe_to_services))_

### Expose transactions ###
The protocol must be able to expose, to the Reading System, the transactions. _(Original requirement 26. User Story: [Level of support services](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Level_of_support_services))_


---


## Development ##

### Not Invented Here ###
Work group must review and use existing standards and tools wherever possible. _(Original requirement 23. User Story: [Existing standards and toolkits](http://code.google.com/p/daisy-online-delivery/wiki/UserStories#Existing_standards_and_toolkits))_


---


