

# Structural changes and copyediting #

Rather than a single spreadsheet, the requirements and user stories were separated into two documents, RequirementsDocument and UserStories.  Each user story and requirement was given a short name, so they can be referenced by something other than number.  Requirements were organized by the categories given in the original document.  Spelling and grammar were fixed where possible, and some wording was changed for clarity and uniformity of language.

The OriginalRequirements document contains the original requirements, sorted by category and with spelling corrected.

# New requirements added #

New requirements were not given numbers.

  * [Key delivery](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Key_delivery) was added to support PDTB2 key exchange.
  * [Dynamic menus](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Dynamic_menus) and [Noninteractive session](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Noninteractive_session) were added to support a basic service profile which is only concerned with content transfer, not selection.

# Old in-scope requirements taken out of scope #

These requirements were considered to be out-of-scope for this project.

  * [Requirement 9; Report number of books](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Report_number_of_books) was considered unnecessary for a client-server model.
  * [Requirement 11; Variety of system messages](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Variety_of_system_messages) was unclear.
  * [Requirement 13; Ping servers](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Ping_servers) was considered unnecessary for a client-server model.
  * [Requirement 16 (1); Report player's status](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Report_player%27s_status) was considered unnecessary for a client-server model.
  * [Requirement 17 (2); Suggest mirrors](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Suggest_mirrors) was considered too ambitious for the first version.
  * [Requirement 17 (3); Trace routing](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Trace_routing) was considered too ambitious for the first version.
  * [Requirement 19; Requires some player functionality](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Requires_some_player_functionality), the requirement for user feedback, was considered too ambitious for the first version.
  * [Requirement 22; Transmit storage space](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Transmit_storage_space) was considered unnecessary for a client-server model.
  * [Requirement 23; Not Invented Here](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Not_Invented_Here) was considered to be an implementation detail.
  * [Requirement 25; Without user interaction](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Without_user_interaction) was unclear, but covered the same ground as [Noninteractive session](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Noninteractive_session).
  * [Requirement 26; Expose transactions](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Expose_transactions) was unclear.
  * [Requirement 27; Initial transaction](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Initial_transaction), the requirement for server discoverability, was considered too ambitious for the first version.
  * [Requirement 28; New service registration](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#New_service_registration) was considered too ambitious for the first version.
  * [Requirement 60; Identify and transfer service provider](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Identify_and_transfer_service_provider) was considered to be a reading system function.
  * [Requirement 61; User preferences stored on server](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#User_preferences_stored_on_server) was considered too ambitious for the first version.

# Existing requirements edited #

  * Report player errors (Requirement 7): [Original](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Report_player_errors), [revision](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Report_player_errors).
  * Return book (Requirement 8): [Original](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Return_book), [revision](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Return_book).
  * Issue content (Requirement 10): [Original](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Transmit_confirmation_message), [revision](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument#Issue_content).

# Duplicates removed #

These requirements were marked as being "satisfied by (another) requirement" in the original document. They have been removed from the new document.

  * [Requirements 29 and 31; Select a book](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Select_a_book)
  * [Requirement 30; Partial transmission](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Partial_transmission)
  * [Requirement 32; Be aware of size](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Be_aware_of_size)
  * [Requirement 34; Report download status](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Report_download_status)
  * [Requirement 35; Send lists](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Send_lists)
  * [Requirement 37; User preferences separate](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#User_preferences_separate)
  * [Requirement 38; Secure transmission](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Secure_transmission)
  * [Requirements 39, 53 and 54; Meaningful messages](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Meaningful_messages)
  * [Requirement 40; Need file size](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Need_file_size)
  * [Requirement 41; Resumability](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Resumability)
  * [Requirement 42; Support outage messages](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Support_outage_messages)
  * [Requirements 43, 44 and 55; Different classes of messages](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Different_classes_of_messages)
  * [Requirements 45 and 46; System messages and unique device ID](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#System_messages_and_unique_device_ID)
  * [Requirement 47; Send list of options](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Send_list_of_options)
  * [Requirement 48; Time out and return and authorization of content](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Time_out_and_return_and_authorization_of_content)
  * [Requirement 49; Streaming is full DAISY experience and controlled download](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Streaming_is_full_DAISY_experience_and_controlled_download)
  * [Requirement 50; Management of lists](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Management_of_lists)
  * [Requirement 51; System messages](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#System_messages)
  * [Requirements 56, 58 and 59; PDTB2 and partial transmission](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#PDTB2_and_partial_transmission) (Note: a new requirement has been written for [PDTB2 support](http://code.google.com/p/daisy-online-delivery/wiki/RequirementsDocument?ts=1247584430&updated=RequirementsDocument#Key_delivery).)
  * [Requirement 57; Download of book without access rights](http://code.google.com/p/daisy-online-delivery/wiki/OriginalRequirements#Download_of_book_without_access_rights)