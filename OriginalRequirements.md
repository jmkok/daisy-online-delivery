


---


# In-scope #

## Content Management ##

### Efficient use of bandwidth ###
Protocol to support efficient use of bandwidth. _(Original requirement 2 (1). User Story: [Authorization of content (server)](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Authorization_of_content_(server)))_

### Key authorization ###
Protocol to support efficient key authorisation checking. _(Original requirement 2 (2). User Story: [Authorization of content (server)](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Authorization_of_content_(server)))_

### Errors must be communicated to server ###
Transmission/download errors must be tracked and communicated to the server. Protocol must deliver error codes to the system. _(Original requirements 7 and 52. User Stories: [Tell server download failed](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Tell_server_download_failed) and [Error code knowledge base](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Error_code_knowledge_base))_

### Return book ###
System is notified that the book has been returned (deleted from the players). _(Original requirement 8. User Story: [Return book](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Return_book))_

### Report number of books ###
Players must notify how may books the user has on them. _(Original requirement 9. User Story: [Maximum entries in a bookshelf](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Maximum_entries_in_a_bookshelf))_

### Transmit capabilities ###
The protocol must be able to support the transmission of the class and capabilities (storage) of the player. _(Original requirement 12. User Story: [Determine player capabilities](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Determine_player_capabilities))_

### Ping servers ###
The players must periodically ping the servers and report its status. _(Original requirement 13. User Story: [Know if player is online](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Know_if_player_is_online))_

### Universal protocol ###
The protocol must be the same between organisations. _(Original requirement 15 (1). User Story: [Access content from different organizations](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Access_content_from_different_organizations))_

### Player stores contact information ###
Player must store contact information for each service/organisation. _(Original requirement 15 (2). User Story: [Access content from different organizations](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Access_content_from_different_organizations))_

### Content at different location ###
The protocol must support content being at different location to the user information. _(Original requirement 17 (1). User Story: [Centralized authentication](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Centralized_authentication))_

### Suggest mirrors ###
Protocol must support the server suggesting mirror sites to download the content from. _(Original requirement 17 (2). User Story: [Centralized authentication](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Centralized_authentication))_

### Trace routing ###
Trace routing must be supported. _(Original requirement 17 (3). User Story: [Centralized authentication](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Centralized_authentication))_

### Time interrogation ###
Protocol must allow the interrogation of time by the player. _(Original requirement 21. User Story: [Expiration date for content](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Expiration_date_for_content))_

### Transmit storage space ###
The protocol must support the transmission of the storage available on the player from the player to the server. _(Original requirement 22. User Story: [Enough space to store content (server)](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Enough_space_to_store_content_(server)))_

### Initial transaction ###
Initial transaction between when a player is first turned on and the server. _(Original requirement 27. User Story: [Content provider discovery](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Content_provider_discovery))_

### Download and streaming ###
The protocol must support both downloading and streaming. _(Original requirement 62. User Story: [Provide content](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Provide_content))_


---


## User Control ##

### Same book, different player ###
A single user may download the same book but to a different player. _(Original requirement 3 (1). User Story: [Different devices, same content](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Different_devices,_same_content))_

### Bookmark stored on server ###
The reading history (bookmark) of each book is stored on the server as well as the client. _(Original requirement 3 (2). User Story: [Different devices, same content](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Different_devices,_same_content))_

### Transmit confirmation message ###
The protocol must transmit a confirmation message from the player. _(Original requirement 10. User Story: [Confirm user wants book](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Confirm_user_wants_book))_

### Audio and text annotation ###
Transmission of lists supports audio and text annotation. _(Original requirement 14. User Story: [Choose book from narrative](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Choose_book_from_narrative))_

### Stop and resume download ###
The protocol must support stop/resume of the download. _(Original requirement 18. User Story: [Interact with a download](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Interact_with_a_download))_

### Requires some player functionality ###
Requires some player functionality as well. _(Original requirement 19. User Story: [Give feedback](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Give_feedback))_

### Identify and transfer service provider ###
The protocol must support identification and transference of the primary service provider. _(Original requirement 60. User Story: [Switch primary content provider](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Switch_primary_content_provider))_

### User preferences stored on server ###
The user preferences are stored on the server so that remote access from different terminals can automatically be adjusted. _(Original requirement 61. User Story: [Player settings](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Player_settings))_


---


## Preview ##

### Prioritize order of files ###
Protocol needs to prioritise order of files for each content so it can be played. _(Original requirement 4. User Story: [Ability to play before download is complete](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Ability_to_play_before_download_is_complete))_

### Interact with content ###
The protocol supports interaction with the content. _(Original requirement 5. User Story: [Review content before selection](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Review_content_before_selection))_


---


## Information Management ##

### Transmit bookmarks ###
Protocol must allow the transmission of bookmarks as a separate entity to the book. Protocol should recognise bookmarks as non book content and a player can transmit bookmarks back to the server and vice versa. Protocol must allow the transmission of bookmarks as a separate entity to the book (within DAISY ISO 2005 standard there is no attribute that identifies a bookmark as private/shared). _(Original requirements 6, 33 and 36. User Stories: [Keep bookmarks](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Keep_bookmarks), [Bookmark content](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Bookmark_content) and [Preset bookmarks](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Preset_bookmarks))_

### Variety of system messages ###
Protocol must allow to transmit a variety of system messages. _(Original requirement 11. User Story: [Push system messages](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Push_system_messages))_

### Report player's status ###
Protocol must report players status. _(Original requirement 16 (1). User Story: [Diagnose player status](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Diagnose_player_status))_

### Report firmware version ###
Protocol has to report firmware version of the player. _(Original requirement 16 (2). User Story: [Diagnose player status](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Diagnose_player_status))_

### Report download activity ###
Protocol has to report download activity. _(Original requirement 16 (3). User Story: [Diagnose player status](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Diagnose_player_status))_

### Report player errors ###
Protocol must report player system errors. _(Original requirement 16 (4). User Story: [Diagnose player status](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Diagnose_player_status))_

### Report which server is in control ###
Protocol must report which server is in control. _(Original requirement 16 (5). User Story: [Diagnose player status](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Diagnose_player_status))_

### Protect user privacy ###
The protocol must ensure protection of a users privacy. _(Original requirement 20. User Story: [No personal information](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#No_personal_information))_

### Localized, plain language error messages ###
Error messages must be easily modified to provide meaningful information in plain language of the user. _(Original requirement 24. User Story: [Meaningful error messages](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Meaningful_error_messages))_


---


## Organization Control ##

### Without user interaction ###
The protocol supports the background communication without user interaction as much as possible. _(Original requirement 25. User Story: [Unobtrusive service](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Unobtrusive_service))_

### Expose transactions ###
The protocol must be able to expose, to the player, the transactions. _(Original requirement 26. User Story: [Level of support services](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Level_of_support_services))_

### New service registration ###
The protocol has to support the registration with a new service provider. _(Original requirement 28. User Story: [Subscribe to services](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Subscribe_to_services))_


---


## Development ##

### Not Invented Here ###
Work group to review and use existing standards and tool wherever possible. _(Original requirement 23. User Story: [Existing standards and toolkits](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Existing_standards_and_toolkits))_


---


# Duplicates #

These requirements were marked "satisfied by requirement", indicating that they were considered to be redundant, based on the existing in-scope requirements above.

## Content Management ##

### Select a book ###
Transmitting a list of options and a response or selection and then system delivers the content. _(Original requirements 29 and 31. User Stories: [Select a book](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Select_a_book) and [Accept or reject items](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Accept_or_reject_items))_

### Be aware of size ###
Protocol needs to be aware of the size of the item in question. _(Original requirement 32. User Story: [Enough space to store content (client)](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Enough_space_to_store_content_(client)))_

### Report download status ###
Protocol must report the download status. _(Original requirement 34. User Story: [Ensure download](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Ensure_download))_

### Send lists ###
Protocol supports the sending of lists. _(Original requirement 35. User Story: [Recommend similar books](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Recommend_similar_books))_

### Need file size ###
Need to have size of file. _(Original requirement 40. User Story: [Download progress](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Download_progress))_

### Resumability ###
Protocol must be resumable. _(Original requirement 41. User Story: [Resume download](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Resume_download))_

### Support outage messages ###
Protocol must support messages prior to service outage. _(Original requirement 42. User Story: [Suspend content](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Suspend_content))_

### Send list of options ###
Transmitting a list of options and a response or selection and then system delivers the content. _(Original requirement 47. User Story: [Re-download](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Re-download))_

### Time out and return and authorization of content ###
Timing out of books/returning of books/is this book allowed to go to the player. _(Original requirement 48. User Story: [Control number of copies](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Control_number_of_copies))_

### Streaming is full DAISY experience and controlled download ###
The streaming is a full DAISY experience + the download could be controlled by the player. _(Original requirement 49. User Story: [Return to the same place](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Return_to_the_same_place))_

### Management of lists ###
Management of lists and versions/revs. _(Original requirement 50. User Story: [Set a preference for when there isn't enough space](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Set_a_preference_for_when_there_isn't_enough_space))_

### PDTB2 and partial transmission ###
Protocol has to support secure transmission such as encryption (PDTB) + sending parts of the book then sending an update. _(Original requirements 56, 58 and 59. User Stories: [Authorization of content (system)](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Authorization_of_content_(system)), [Embedded authorization and rights](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Embedded_authorization_and_rights) and [Key delivery](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Key_delivery))_

### Download of book without access rights ###
Download of book without access rights until the release date of the book even for players without a real time clock. _(Original requirement 57. User Story: [Time service](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Time_service))_


---


## Preview ##

### Partial transmission ###
The protocol must support, understand and communicate around partial, incremental and revised download. _(Original requirement 30. User Story: [Information as soon as it is ready](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Information_as_soon_as_it_is_ready))_


---


## Information Management ##

### Secure transmission ###
Transmission must be secure. _(Original requirement 38. User Story: [No sniffing](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#No_sniffing))_

### Meaningful messages ###
Meaningful messages. _(Original requirements 39, 53 and 54. User Stories: [Request failure notification](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Request_failure_notification), [Error codes](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Error_codes) and [Check firmware version](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Check_firmware_version))_

### Different classes of messages ###
Protocol will support different classes of messages. _(Original requirements 43, 44 and 55. User Stories: [Suppress system messages](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Suppress_system_messages), [Compulsory messages](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Compulsory_messages) and [Push player upgrades](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Push_player_upgrades))_


---


## Organization Control ##

### User preferences separate ###
Protocol must allow the transmission of user preference as a separate entity to the book. _(Original requirement 37. User Story: [Customize client UI from server](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Customize_client_UI_from_server))_

### System messages and unique device ID ###
System messages + unique id of device. _(Original requirements 45 and 46. User Story: [Stop player from functioning](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Stop_player_from_functioning) and [Change player status](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Change_player_status))_

### System messages ###
System messages. _(Original requirement 51. User Story: [Get paid](http://code.google.com/p/daisy-online-delivery/wiki/OriginalUserStories#Get_paid))_


---

