

# Introduction #

This report summarizes the system testing of the protocol, that is, the demonstration of how well the specification fulfils the requirements and expectations.  The requirements come from the modified RequirementsDocument.

Note that this is not conformance testing.  Some of these test will not be met even by some conformant Reading Systems and Services.  Rather, they are proofs-of-concept, demonstrations that the protocol can support a particular function.  For example, test 14.3 "Pre-requisite book" states:

> Search for the second or third book of a series, where the previous book was never issued. The Service should, in the dynamic menus, inform the user of the previous book.

This only applies to Services that support dynamic menus, searching and have the optional function of tracking a User's previous selections and making suggestions.  Not all Services are expected to do this.

# Requirements #

## 1. Efficient use of bandwidth ##

**Partially fulfilled**

[Requirement](RequirementsDocument#Efficient_use_of_bandwidth.md)

Content transfer usually takes place over HTTP, which is sufficient for transfer of data over the World Wide Web.  The Service creates minimal overhead.

Transfer of audio from the Reading System to the Service takes place over SOAP without MTOM, which adds roughly 37% more to transmission time.

  1. **Download content**: Use a Service to find and download an entire Content item.  Ensure that the Content is downloaded in a reasonable amount of time.
  1. **Protocol overhead**: In a typical session, measure the ratio of bytes transferred for messages (i.e., over SOAP) vs. bytes transferred for Content (i.e., over plain HTTP/HTTPS).
  1. **Audio response**: Send an audio response to a dynamic menu item that supports it.  Ensure that the audio is uploaded in a reasonable amount of time.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 1.1 | CNIB | CNIB | **Success** | Transfer of data was at an acceptable rate.  A 45.7 MB book was downloaded in 10 minutes. |
| 1.1 | CNIB | Vision Australia | **Success** | Transfer of data was at an acceptable rate.  A 21.4 MB book was downloaded in 4 minutes. |
| 1.1 | HumanWare | CNIB | **Success** | Transfer of data was at an acceptable rate.  A 10 MB book was downloaded in 2:35 minutes. |
| 1.1 | HumanWare | Vision Australia | **Success** | Transfer of data was at an acceptable rate.  A 74 MB book was downloaded in 9:34 minutes. |
| 1.2 | CNIB | Vision Australia | **Success** | Issued and downloaded a Content item of approx. 58 MB. SOAP messages were approx. 16 KB, or a 0.03% overhead ratio. |
| 1.2 | CNIB | Solutions Radio | **Success** | Issued and downloaded a Content item of approx. 139 MB.  SOAP messages were approx. 51 KB, or a 0.04% overhead ratio. |
| 1.3 | HumanWare | Solutions Radio | **Success** | Uploaded 152 KB in 2.4 seconds. |
| 1.3 | HumanWare | Vision Australia | **Success** | Uploaded 40 KB in 2.3 seconds. |
| 1.3 | PlexTalk | Solutions Radio | **Success** |  |
| 1.3 | PlexTalk | Vision Australia | **Success** |  |

## 2. Key authorization ##

**Partially fulfilled**

[Requirement](RequirementsDocument#Key_authorization.md)

Authorization occurs by User, not by Reading System; credentials are user names and passwords, not encryption keys. Service Providers intending to authorize Content by individual Reading System will need to use some other mechanism, such as PDTB2.

  1. **Connect with authorization**: Initialize a session with a Service using correct user credentials.
  1. **Deny incorrect authorization**: Attempt to initialize a session with a Service using a valid user name, but an incorrect password.  The Service must respond `false` to the `logOn` operation, and return a `NoActiveSession` fault to subsequent operation calls.
  1. **Allow content download with correct credentials**: Download a resource with basic authentication credentials provided by the Service.
  1. **Deny content download with incorrect credentials**: Attempt to download a resource with incorrect basic authentication credentials.  The file server must respond with an HTTP status of "401 Unauthorized".

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 2.1 | CNIB | PratSam | **Success** | Logged on with username "tsg". |
| 2.1 | CNIB | Vision Australia | **Success** | Logged on with username "cnib". |
| 2.1 | HumanWare | PratSam | **Success** | Session was successfully initialized. |
| 2.1 | HumanWare | Vision Australia | **Success** | Session was successfully initialized. |
| 2.2 | CNIB | CNIB | **Success** | Attempted to connect with username "cnib", password "invalid". Service returned the correct responses. |
| 2.2 | CNIB | PratSam | **Success** | Attempted to connect with username "tsg", password "invalid". Service returned the correct responses. |
| 2.2 | Solutions Radio | CNIB | **Success** | Service returned the correct responses. |
| 2.2 | Solutions Radio | Vision Australia | **Success** | Service returned the correct responses. |
| 2.3 | CNIB | CNIB | **Success** | Downloaded "DC00003". |
| 2.3 | CNIB | PratSam | **Success** | Downloaded parts of "pub\_2". |
| 2.3 | HumanWare | CNIB | **Success** | Resources were downloaded with basic authentication credentials. |
| 2.3 | HumanWare | PratSam | **Success** | Resources were downloaded with basic authentication credentials. |
| 2.4 | CNIB | PratSam | **Success** |  |
| 2.4 | CNIB | Solutions Radio | **Success** |  |
| 2.4 | HumanWare | PratSam | **Success** | Service responded 401 when using invalid user name or password |
| 2.4 | HumanWare | Solutions Radio | **Success** | Service responded 401 when using invalid user name or password |

## 3. Transmit bookmarks ##

**Partially fulfilled**

[Requirement](RequirementsDocument#Transmit_bookmarks.md)

The protocol does not support bookmarks with audio notes.

Note: Storing user-created bookmarks is covered under requirement #13, Bookmark stored on server.

  1. **Retrieve a service provider-created bookmark**: Use `getBookmarks` to retrieve a list of predefined bookmarks from a Service.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 3.1 | PlexTalk | Solutions Radio | **Success** |  |
| 3.1 | Solutions Radio | Solutions Radio | **Success** |  |

## 4. Return book ##

**Fulfilled**

[Requirement](RequirementsDocument#Return_book.md)

  1. **Return a downloaded book**: Issue and download a Borrowable Content item (i.e. one that requires return) then perform the Reading System's return function.  The Service must return `true`.  Verify that the Content's resources have been removed from the Reading System.
  1. **Return a streamed book**: Issue a Borrowable Content item and stream some part of it, then perform the Reading System's return function.  The Service must return `true`.  Verify that the Content's resources are not present on the Reading System.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.1 | CNIB | CNIB | **Success** | Deleted and returned "EP00001". |
| 4.1 | CNIB | Vision Australia | **Success** | Deleted and returned "Book1". |
| 4.1 | PlexTalk | CNIB | **Success** | Tested with Contents ID = "DC00001" |
| 4.1 | PlexTalk | Vision Australia | **Success** | Tested with Contents ID ="Magazine2" |
| 4.2 | PlexTalk | CNIB | **Success** |  |
| 4.2 | PlexTalk | Solutions Radio | **Success** |  |
| 4.2 | Solutions Radio | CNIB | **Success** | issueContent + Stream + returnContent tested |
| 4.2 | Solutions Radio | Solutions Radio | **Success** | issueContent + Stream + returnContent tested |

## 5. Transmit capabilities ##

**Fulfilled**

[Requirement](RequirementsDocument#Transmit_capabilities.md)

  1. **Set Reading System attributes**: Initialize a session with a Service.  Verify that the Reading System's attributes were sent to the Service.
  1. **Adapt Content to the Reading System's capabilities**: Initialize a session with a Service that provides different Content based on the capabilities of the Reading System.  Ensure that the Content and resources offered by the Service are only in the formats given in the `readingSystemAttributes` provided to the Service.
  1. **Negotiate audio labels**: Initialize a session with a Service that supports text-only and text+audio labels.  Set `readingSystemAttributes/config/requiresAudioLabels` to `true` when calling `setReadingSystemAttributes`.  Ensure that all `label`s have `audio` components.
  1. **Negotiate numeric input**: Initialize a session with a Service that has implemented both numeric and alphanumeric `inputQuestion`s.  Set `readingSystemAttributes/config/supportedInputTypes` to to have one `input` element with a `type` attribute of `TEXT_NUMERIC` when calling `setReadingSystemAttributes`.  Ensure that all `inputQuestion`s allow `TEXT_NUMERIC` input.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 5.1 | HumanWare | CNIB | **Success** | Session was successfully initialized and Reading System attributes were received by the service. |
| 5.1 | HumanWare | Vision Australia | **Success** | Session was successfully initialized and Reading System attributes were received by the service. |
| 5.1 | PlexTalk | CNIB | **Success** |  |
| 5.1 | PlexTalk | Vision Australia | **Success** |  |
| 5.2 | HumanWare | PratSam | **Success** | Session was successfully initialized and Service provided only supported format content. (Note: the test was completed without PDTB2 support because the Service is treating PDTB2 content as a format. This is not the case and should be address.) |
| 5.2 | PlexTalk | PratSam | **Success** |  |
| 5.3 | PlexTalk | Solutions Radio | **Success** | Received audio labels for the "new" content list, the service announcements and the "default" menu. |
| 5.3 | Solutions Radio | Solutions Radio | **Success** |  |
| 5.4 | PlexTalk | Vision Australia | **Success** | Input question allowed both numeric and alphanumeric input. |

## 6. Universal protocol ##

**Fulfilled**

[Requirement](RequirementsDocument#Universal_protocol.md)

  1. **Full session**: Perform a full session, from `logOn` to `logOff`.  (This test should be performed with as many combinations of clients and servers as possible.)

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 6.1 | CNIB | CNIB | **Success** | Operated in automatic mode.  Initialized the session.  Two issued books, "ET00003" and "us-nls-db62465", selected beforehand, were returned.  One book, "ET00004", showed up in the "new" content list; it was issued and downloaded.  The other content was up-to-date, so the Reading System logged off. |
| 6.1 | CNIB | PratSam | **Success** | Operated in automatic mode.  Initialized the session.  No books were returned.  No books showed up in the "new" content list.  One issued book, "pub\_2" had been deleted but not returned, so it was re-downloaded.  The Reading System logged off. |
| 6.1 | CNIB | Solutions Radio | **Success** | Operated in automatic mode.  Initialized the session.  No books were returned.  Several books showed up in the "new" content list; the first three were issued and downloaded.  The other content was up-to-date, so the Reading System logged off. |
| 6.1 | CNIB | Vision Australia | **Success** | Operated in automatic mode.  Initialized the session.  One book was on the "expired" list, "Book1", and was returned.  Several books showed up in the "new" content list; the first three were issued and downloaded.  There was no other content, so the Reading System logged off. |
| 6.1 | HumanWare | CNIB | **Success** | Session initialized. Content issued, downloaded and returned. |
| 6.1 | HumanWare | PratSam | **Success** | Session initialized. Announcements retrieved and marked as read. protected content found. Content issued, downloaded and returned. Used the dynamic menus to search for content, send feedback and download content. Note: Key exchange object operation failed to deserialize response. |
| 6.1 | HumanWare | Solutions Radio | **Success** | Session initialized. Announcements retrieved and marked as read. Content issued, downloaded and returned. Used the dynamic menus to search for content, send feedback and download content. Note: No protected content found. Key exchange object operation not tested. |
| 6.1 | HumanWare | Vision Australia | **Success** | Session initialized. Announcements retrieved and marked as read. Content issued, downloaded and returned. Used the dynamic menus to search for content and answer a survey. |
| 6.1 | PlexTalk | CNIB | **Success** | Tested with Contents ID = "DC00001" |
| 6.1 | PlexTalk | PratSam | **Success** | Searched by "A light Man" and confirmed playback with "Contents ID = 2". Announcement is tested with ID = 2. |
| 6.1 | PlexTalk | Solutions Radio | **Success** | Tested with Contents ID = "de1ce83964e001c1ff2ff28e286b511accf13132" |
| 6.1 | PlexTalk | Vision Australia | **Success** | Tested with Contents ID = "Magazine2". Announcement is tested with ID = "downtime" |
| 6.1 | Solutions Radio | CNIB | **Success** | No problems detected using basic tests. Announcements, bookmarks, menus and kxo not implemented |
| 6.1 | Solutions Radio | PratSam | **Success** | No problems detected using basic tests |
| 6.1 | Solutions Radio | Solutions Radio | **Success** | No problems detected using basic tests |
| 6.1 | Solutions Radio | Vision Australia | **Success** | No problems detected using basic tests. Kxo not implemented. Service is a bit slow. |

## 7. Player stores contact information ##

**N/A**

[Requirement](RequirementsDocument#Player_stores_contact_information.md)

The requirement states that the Reading System must store the Service's contact information.  This is not a requirement as much as it is a declaration that Service Discovery is out of scope.

## 8. Content at different location ##

**Fulfilled**

[Requirement](RequirementsDocument#Content_at_different_location.md)

  1. **Public remote content**: Issue a Content item which is hosted on a public server that is not affiliated with the Service Provider and does not require authentication.  Download the Content.
  1. **Private remote content**: Issue a Content item which is hosted on a public server that is not  at the same host as the Service and requires basic authentication.  Download the Content.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 8.1 | CNIB | CNIB | **Success** | Retrieved "ext2", an MP3 file hosted at Song Fight. |
| 8.1 | HumanWare | CNIB | **Success** | Content issued and downloaded. |
| 8.2 | CNIB | CNIB | **Success** | Retrieved "ext1", a web page hosted at Cornell University with basic authentication. |
| 8.2 | HumanWare | CNIB | **Success** | Content issued and downloaded. |
| 8.2 | HumanWare | Solutions Radio | **Success** | Content issued and downloaded. |

## 9. Time interrogation ##

**Partially fulfilled**

[Requirement](RequirementsDocument#Time_interrogation.md)

The ability for Reading Systems to query the Service for the current time was not included in the protocol.  The protocol can provide a due date for Content, and can provide a list of expired Content.

  1. **Due date**: Retrieve a Content item with a "return by" attribute.  Ensure the date is rendered to the User.
  1. **Expired content**: Request the Service to cause some borrowed Content to expire.  Ensure that it is present on the `expired` Content list.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 9.1 | CNIB | Solutions Radio | **Success** | Got the resources for "2bdb2598e04fc91aa132b003d4e9045869cbc02b", which was due back at Tue Mar 30 16:40:16 2010. |
| 9.1 | CNIB | Vision Australia | **Success** | Issued "Book1".  Due date is Sun Jan 17 22:20:17 2010. |
| 9.1 | Solutions Radio | Solutions Radio | **Success** | returnBy present and correct format |
| 9.1 | Solutions Radio | Vision Australia | **Success** | returnBy present and correct format |
| 9.2 | CNIB | PratSam | **Success** | "expired" list had two items: "pub\_1" and "pub\_4".  Returned "pub\_1" and it was removed from the list. |
| 9.2 | CNIB | Solutions Radio | **Success** | Four items had expired, one of which was downloaded.  All four items were returned, and they went off the "expired" list. |
| 9.2 | PlexTalk | PratSam | **Success** |  |

## 10. Download and streaming ##

**Fulfilled**

[Requirement](RequirementsDocument#Download_and_streaming.md)

  1. **Download content**: Issue and download a Content item.
  1. **Stream content**: Issue a Content item and stream some part of it.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 10.1 | CNIB | CNIB | **Success** | Issued and downloaded "DC00003", a DAISY book. |
| 10.1 | CNIB | Solutions Radio | **Success** | Issued and downloaded "e3ccc1534fdff5b6b5a9001353cb40da7bbe0c2c", a DAISY book. |
| 10.1 | PlexTalk | CNIB | **Success** | Tested with Contents ID = "DC00001" |
| 10.1 | PlexTalk | Solutions Radio | **Success** | Tested with the title, "DANI0916" |
| 10.2 | PlexTalk | CNIB | **Success** |  |
| 10.2 | PlexTalk | Vision Australia | **Success** | Tested with Contents ID = "Magazine2" |
| 10.2 | Solutions Radio | CNIB | **Success** | Files are streamable. |

## 11. Key delivery ##

**Fulfilled**

[Requirement](RequirementsDocument#Key_delivery.md)

  1. **Identify protected Content**: Find a Protected DTB on the Service.  Get the DTB's metadata.  There must be a meta element with a name attribute of "`pdtb2:specVersion`" and a content attribute of "`2005-1`".
  1. **Get a key**: Issue and download a Protected DTB.  Request a Key Exchange Object (KXO) for the decryption key from the Service using `getKeyExchangeObject`.  Render the DTB.
  1. **Deny a key**: Issue and download a Protected DTB.  Request a KXO for the decryption key from the Service using `getKeyExchangeObject`, but do not provide an authorized key in the `keyRing` element of the `readingSystemAttributes`.  The Service must reply with an `invalidParameter` fault.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 11.1 | CNIB | PratSam | **Success** | Got the metadata for "pub\_6", which was listed as PDTB2-protected. |
| 11.1 | CNIB | CNIB | **Success** | Got the metadata for "us-nls-db62465", which was listed as PDTB2-protected. |
| 11.1 | HumanWare | PratSam | **Success** | Protected content found. |
| 11.2 | HumanWare | PratSam | **Partial success** | Able to retrieve a valid KXO through the Service.  Client framework was unable to extract the KXO.  Was able to parse KXO manually and decrypt the book. |
| 11.2 | PlexTalk | PratSam | **Partial success** | Able to retrieve a valid KXO through the Service. Unable to decrypt the book. |
| 11.3 | HumanWare | PratSam | **Success** | Protected content issued and downloaded. Service returned invalidParameter fault at operation getKeyExchangeObject (using empty key ring) |

## 12. Same book, different player ##

**Fulfilled**

[Requirement](RequirementsDocument#Same_book,_different_player.md)

  1. **Multiple downloads**: Issue and download a Content item from a Service that allows multiple downloads of the same Content.  Download the same Content item onto another Reading System.
  1. **Pick up where you left off**: Issue and download a Content item.  Render the Content up to some point, create a bookmark there and transmit it to the Service.  Return the Content item.  Download the same Content item onto another Reading System.  Get the bookmarks for the Content item.  Start rendering the Content at the point where the bookmark was set earlier.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 12.1 | CNIB | PratSam | **Success** | Downloaded parts of "pub\_2" to home and work computers. |
| 12.1 | CNIB | Vision Australia | **Success** | Downloaded "Book1" to work and home computers. |
| 12.1 | Solutions Radio | PratSam | **Success** |  |
| 12.1 | Solutions Radio | Vision Australia | **Success** |  |
| 12.2 | Solutions Radio | PratSam | **Success** | Able to continue after logOff (bookmarks verified) |

## 13. Bookmark stored on server ##

**Partially fulfilled**

[Requirement](RequirementsDocument#Bookmark_stored_on_server.md)

The protocol does not support bookmarks with audio notes.

  1. **Store and retrieve a user-created bookmark**: Create a bookmark for a Content item.  Use `setBookmarks` to transmit the bookmark to a Service.  Use `getBookmarks` to retrieve the bookmark from the Service.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 13.1 | Solutions Radio | PratSam | **Success** |  |
| 13.1 | Solutions Radio | Solutions Radio | **Success** |  |

## 14. Issue content ##

**Fulfilled**

[Requirement](RequirementsDocument#Issue_content.md)

  1. **Issue a book**: Request a Content item from a Service using `issueContent`.  The Service must return `true`.  Get the list of resources using `getContentResources`.
  1. **Deny a book**: Request a Content item from a Service using `issueContent`.  The Service must return `false` or a fault.  Try to get the list of resources using `getContentResources`.  The Service must return an `invalidParameter` fault.
  1. **Pre-requisite book**: Search for the second or third book of a series, where the previous book was never issued.  The Service should, in the dynamic menus, inform the user of the previous book.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 14.1 | HumanWare | Solutions Radio | **Success** | issueContent returned true and the list of resources was retrieved. |
| 14.1 | HumanWare | Vision Australia | **Success** | issueContent returned true and the list of resources was retrieved. |
| 14.1 | PlexTalk | Solutions Radio | **Success** |  |
| 14.1 | PlexTalk | Vision Australia | **Success** |  |
| 14.2 | CNIB | CNIB | **Success** | Tried to issue and download "DC00001" but was not allowed.  `getContentResources` threw a fault. |
| 14.2 | CNIB | PratSam | **Success** | Tried to issue "pub\_1" after returning, and was denied. `getContentResources` threw a fault. |
| 14.2 | Solutions Radio | CNIB | **Success** |  |
| 14.2 | Solutions Radio | PratSam | **Success** | issueContent threw an invalidParameterFault. |
| 14.3 | HumanWare | Solutions Radio | **Success** | Searched for 'Harry Potter and the Goblet of Fire'. A list of all Harry Potter titles was returned. |
| 14.3 | Solutions Radio | Solutions Radio | **Success** | getQuestions with questionID "daisy-test.1920" and value "goblet" returns a list of Harry Potter books |

## 15. Audio and text annotation ##

**Fulfilled**

[Requirement](RequirementsDocument#Audio_and_text_annotation.md)

  1. **Annotated Content list**: Retrieve a Content list with several items from a Service using `getContentList`.  Each item must have a label with both text and audio.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 15.1 | HumanWare | PratSam | **Success** | All items have audio and text in there label. |
| 15.1 | HumanWare | Solutions Radio | **Success** | All items have audio and text in there label |
| 15.1 | Solutions Radio | PratSam | **Success** | All items have audio and text in there label |
| 15.1 | Solutions Radio | Solutions Radio | **Success** | All items have audio and text in there label |

## 16. Stop and resume download ##

**Fulfilled**

[Requirement](RequirementsDocument#Stop_and_resume_download.md)

  1. **Stop and resume**: Issue a Content item from a Service and get its resource list.  Download part of one file, then stop.  Drop the HTTP connection, then reconnect.  Resume the download, using the HTTP Range header to download only the remaining part of the file.  Download the same file in its entirety and verify that they match.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 16.1 | CNIB | CNIB | **Success** | Downloaded 200 bytes of "bagw0014.mp3". Resumed download and completed. |
| 16.1 | CNIB | Solutions Radio | **Success** | Downloaded 1097728 bytes of "0055-Artikel6.mp3". Resumed download and completed. |
| 16.1 | PlexTalk | CNIB | **Success** | Tested with Contents ID = "DC00001" |
| 16.1 | PlexTalk | Vision Australia | **Success** | Tested with Contents ID = "Magazine2" |

## 17. Dynamic menus ##

**Fulfilled**

[Requirement](RequirementsDocument#Dynamic_menus.md)

  1. **Search for content**: Use the dynamic menus to search for a Content item.
  1. **Browse for content**: Use the dynamic menus to browse the Service's collection by categories provided by the Service.
  1. **Survey**: Use the dynamic menus to answer a survey form provided by the Service.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 17.1 | HumanWare | Vision Australia | **Success** | Searched for 'J.K.Rowling'. A list of 3 Harry Potter titles was returned. |
| 17.1 | PlexTalk | Vision Australia | **Success** | Searched by "J.K.Rowling" |
| 17.2 | HumanWare | Solutions Radio | **Success** | Content selected and downloaded from dynamic menus. |
| 17.2 | PlexTalk | Solutions Radio | **Success** | Browsed "HarryPotter" collection |
| 17.3 | HumanWare | PratSam | **Success** | Successfully answered a survey. |
| 17.3 | HumanWare | Vision Australia | **Success** | Successfully answered a survey. |
| 17.3 | PlexTalk | PratSam | **Success** |  |
| 17.3 | PlexTalk | Vision Australia | **Success** |  |

## 18. Noninteractive session ##

**Fulfilled**

[Requirement](RequirementsDocument#Noninteractive_session.md)

  1. **Synchronize downloaded content**: Verify the following can be done as a single Reading System function without user interaction between steps:
    * Return a list of Content items selected by the User.
    * Return the Content items in the "expired" Content list.
    * Issue and download all the items in the "new" Content list.
    * Download all Content in the "issued" Content list that is not already on the Reading System.
  1. **Synchronize streaming content**: Verify the following can be done as a single Reading System function without user interaction between steps:
    * Return a list of Content items selected by the User.
    * Return the Content items in the "expired" Content list.
    * Issue all the items in the "new" Content list.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 18.1 | CNIB | PratSam | **Success** |  |
| 18.1 | CNIB | Vision Australia | **Success** |  |
| 18.1 | Solutions Radio | PratSam | **Success** | missing lastModifiedDate field which might be needed for synchronization |
| 18.1 | Solutions Radio | Vision Australia | **Success** |  |
| 18.2 | HumanWare | CNIB | **Success** | Returned user selected content. Returned expired content. Issued all new content. |
| 18.2 | HumanWare | Solutions Radio | **Success** | Returned user selected content. Returned expired content. Issued all new content. |
| 18.2 | Solutions Radio | CNIB | **Success** |  |
| 18.2 | Solutions Radio | Solutions Radio | **Success** |  |

## 19. Prioritize order of files ##

**Fulfilled**

[Requirement](RequirementsDocument#Prioritize_order_of_files.md)

  1. **Play a book while downloading**: Issue a DAISY 2.02 or Z39.86 book that includes audio from the Service.  Identify and download the XML files, then identify and download the audio in play order.  Begin playback of audio before it has fully downloaded.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 19.1 | Solutions Radio | CNIB | **Success** | Content was correctly available for this purpose (DC00003) |
| 19.1 | Solutions Radio | PratSam | **Success** | Content was correctly available for this purpose (pub\_6) |

## 20. Interact with content ##

**Fulfilled**

[Requirement](RequirementsDocument#Interact_with_content.md)

Note that actually interacting with the Content without downloading all of its resources is covered under 10.2 Stream content.  The user story "Review content before selection" is tested here.

  1. **Sample content**: Download the sample of a Content item without issuing the Content.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 20.1 | CNIB | PratSam | **Success** | Sample for "pub\_3", a single file from the book was downloaded. |
| 20.1 | CNIB | Solutions Radio | **Success** | Retrieved synthetic speech sample for "9bc373bc75575632f42ca09d306b9ebc". |
| 20.1 | Solutions Radio | PratSam | **Success** | Sample was offered and tested (sam\_5 / pub\_5)  |
| 20.1 | Solutions Radio | Solutions Radio | **Success** | Sample was offered and tested |

## 21. Report firmware version ##

**Fulfilled**

[Requirement](RequirementsDocument#Report_firmware_version.md)

  1. **Report firmware version**: Initialize a session with a Service.  Verify that the Reading System's firmware version was sent to the Service.  (Note: this is a subset of test 5.1 Set Reading System attributes.)

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 21.1 | CNIB | CNIB | **Success** |  |
| 21.1 | HumanWare | CNIB| **Success** |  |
| 21.1 | PlexTalk | CNIB | **Success** |  |
| 21.1 | PlexTalk | Vision Australia | **Success** |  |

## 22. Report download activity ##

**Unfulfilled**

[Requirement](RequirementsDocument#Report_download_activity.md)

The capability for a Reading System to report its own download activity to the Service was not included in the protocol.  Service Providers may track this information for local Content by monitoring their own file servers (see test 28.1), and may need to require Service Delegates to report download activity.

## 23. Report player errors ##

**Unfulfilled**

[Requirement](RequirementsDocument#Report_player_errors.md)

The capability for a Reading System to report errors to the Service was not included in the protocol.

## 24. Report which server is in control ##

**Unfulfilled**

[Requirement](RequirementsDocument#Report_which_server_is_in_control.md)

The capability to report which server is in control was not included in the protocol.

## 25. Protect user privacy ##

**Fulfilled**

[Requirement](RequirementsDocument#Protect_user_privacy.md)

  1. **Invalidate session IDs on logOff**: Initialize a session, then log off.  Call some operations (other than `logOn`); the Service must respond with a `NoActiveSession` fault.
  1. **Secure Service**: Initialize a session with a Service over HTTPS.
  1. **Secure Content**: Retrieve Content resources over HTTPS.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 25.1 | CNIB | CNIB | **Success** | Called `getServiceAttributes` after logOff and got a `noActiveSession` fault. |
| 25.1 | CNIB | PratSam | **Success** | Called `getServiceAttributes` after logOff and got a `noActiveSession` fault. |
| 25.1 | PlexTalk | CNIB | **Success** |  |
| 25.1 | PlexTalk | PratSam | **Success** |  |
| 25.2 | CNIB | CNIB | **Success**  | Session was successfully initialized. |
| 25.2 | CNIB | PratSam | **Success**  | Session was successfully initialized. |
| 25.2 | HumanWare | CNIB | **Success**  | Session was successfully initialized. |
| 25.2 | HumanWare | PratSam | **Success**  | Session was successfully initialized. |
| 25.3 | CNIB | CNIB | **Success** | Downloaded "DC00003" over HTTPS. |
| 25.3 | CNIB | PratSam | **Success** | Downloaded "pub\_2" over HTTPS. |
| 25.3 | PlexTalk | CNIB | **Success** |  |

## 26. Localized, plain language error messages ##

**Fulfilled**

[Requirement](RequirementsDocument#Localized,_plain_language_error_messages.md)

  1. **Localized error messages**: Deliberately cause a fault (such as trying to get resources for a Content item that is not issued).  Ensure that the error rendered by the Reading System is localized to the User's language and is plainly explained.  (Note: This test should be repeated by causing the same fault, but with different localizations.)

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 26.1 | CNIB | CNIB | **Success** | Attempted to get metadata for a non-existent content ID.  Fault was rendered in French. |
| 26.1 | CNIB | PratSam | **Success** |  Attempted to get metadata for a non-existent content ID.  Fault was rendered in French. |
| 26.1 | Solutions Radio | CNIB | **Success** | Fault is rendered to the user in its language (RS uses its own text and audio) |
| 26.1 | Solutions Radio | PratSam | **Success** | Fault is rendered to the user in its language (RS uses its own text and audio) |

# Expectations #

## 27. Audio feedback ##

**Fulfilled**

[Requirement](RequirementsDocument#Requires_some_player_functionality.md) (never formally moved back in scope)

Sending audio from the Reading System to the Service was originally in scope, then declared out of scope, then was brought back into the specification.

  1. **Audio feedback**: Transmit audio as a response to a dynamic menu item that accepts it.  Verify that the audio was received by the Service.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 27.1 | HumanWare | PratSam | **Success** | Audio data was successfully uploaded (76 KB in 2 seconds). |
| 27.1 | HumanWare | Vision Australia | **Success** | Audio data was successfully uploaded (40 KB in 2.3 seconds). |

## 28. Download tracking ##

**Fulfilled**

Although reporting download activity is not part of the protocol, certain organizations still need to track it.  This can usually be done on the file server, using standard logging tools.

  1. **Track downloads**: Connect to a Service, then issue and download a Content item.  Verify that file downloads were logged by the Service Provider.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 28.1 | HumanWare | Solutions Radio | **Success** | Content was downloaded and logged by the service. |
| 28.1 | Solutions Radio | Solutions Radio | **Success** | Downloads are logged by the webserver |

## 29. Service announcements ##

**Fulfilled**

The ability to retrieve short announcements for such things as service interruptions and overdue reminders was dropped from the formal requirements, but is still part of the specification.

  1. **Get announcements**: Connect to a Service, then get a list of announcements using the `getServiceAnnouncements` operation and render them.
  1. **Mark as read**: Call the `markAnnouncementsAsRead` operation with the IDs of active announcements.  Call the `getServiceAnnouncements` operation and ensure that the Service has removed them from the list.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 29.1 | HumanWare | PratSam | **Success** | Announcements were successfully retrieved and rendered. |
| 29.1 | HumanWare | Vision Australia | **Success** | Announcements were successfully retrieved and rendered. |
| 29.1 | Solutions Radio | PratSam | **Success** | Announcements were successfully retrieved and rendered. |
| 29.1 | Solutions Radio | Vision Australia | **Success** | Announcements were successfully retrieved and rendered. |
| 29.2 | HumanWare | PratSam | **Success** | First announcement was marked as read and removed from the announcements list. |
| 29.2 | HumanWare | Vision Australia | **Success** | First announcement was marked as read and removed from the announcements list. |
| 29.2 | Solutions Radio | PratSam | **Success** | Announcements were correctly marked as read and removed from the list |
| 29.2 | Solutions Radio | Vision Australia | **Success** | Announcements were correctly marked as read and removed from the list |

## 30. Internationalization ##

**Fulfilled**

This expands on requirement 26, "Localized, plain language error messages".

  1. **Localized announcements**: Connect to a multilingual Service.  Specify in `readingSystemAttributes/config/preferredUILanguage` one of the languages supported by the Service.  Retrieve announcements with `getServiceAnnouncements`.  Check that all `label`s have the same language in their `xml:lang` attributes and that the text and audio are in that language.
  1. **Localized menus**: Connect to a multilingual Service.  Specify in `readingSystemAttributes/config/preferredUILanguage` one of the languages supported by the Service.  Browse the menu structure using `getQuestions`.  Check that all `label`s have the same language in their `xml:lang` attributes and that the text and audio are in that language.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 30.1 | CNIB | PratSam | **Success** | Announcements retrieved both in English and Finnish |
| 30.1 | PlexTalk | PratSam | **Success** | Finnish language requested.  Announcement came back in Finnish. |
| 30.2 | PlexTalk | PratSam | **Success** | Finnish language requested.  Menu came back in Finnish. |
| 30.2 | Solutions Radio | PratSam | **Success** | Default menu available in English and Finnish |

# Conclusion #

Of the 30 in-scope requirements and expectations, 27 have been fulfilled, 5 have been partially fulfilled and 3 have not been fulfilled.
> 27 tests have full coverage, 5 have 75% coverage, 14 have 50% coverage and 3 have 25% coverage.  Even though some tests had only one or two pairs of implementations, more than one team was involved in each test, so the Technical Subgroup is confident that all required functionality is sufficiently specified to be interoperable.  One test was only partially successful.