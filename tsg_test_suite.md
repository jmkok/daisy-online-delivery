_GGT: I've marked up the Reading System conformance section with some observations. I have two main concerns with it: the "optional" assertions and assertions that aren't about Reading Systems but about Services._

_GGT: Regarding the assertions that are really for Services, an example would be section 8, assertion 1.  Supporting the value of a `serviceAttributes/supportedOptionalOperations/operation` element to be "PDTB2\_KEY\_PROVISION" is already covered in the core functionality (under conforming to the schema). It's not well-defined what "supporting" that value means, other than accepting it as a valid value. The requirement is for the Service to provide that value to the Reading System, not for the Reading System to do anything with it._

kj: I have removed all the optional assertions. As for the Service conformance assertions in the Reading System conformance item, i think the Reading Systems must understand the elements/attributes set forth by these assertions, so I recorded them in the RS conformance area.

_JA: I inserted my comments and updates in both Reading System and Service conformance sections._

_JA: I have one concern with this document: regarding the assertions, we should decide what is required for an assertions to be listed in this document. must it explicitly be mentioned in the specification? can we list things that are obvious but not mentioned in the spec? in the former case we should re-visit the documentation and add more requirements._

kj: thats the reason why I innitially divided assertions into required and optional. My thought process was that any assertions that the spec mandates (must) would fall under the required assertions, and any recommendations would fall under the optional assertions. This would give implementers one place to ensure compliance to the spec + satisfy the suitable recommendations. I have not seen many specs that do this though. Thoughts everyone?

kj: I have removed all assertions that belong to the service conformance area as decided on the  last telecon i.e. support the @returnBy for resources ...

SR: Should we add something about the login and content lending/acquisition sequences?

# Introduction #

The test suite consists of two lists of test cases to verify that a Reading System or Service conforms to the DAISY Online specification.  These test cases are not comprehensive, but represent both normal cases and edge cases.

The test cases in each list are grouped by category, and what assertion they test.

A Reading System or Service must satisfy all test cases for all assertions in a category to claim conformance to the particular category.

At a minimum, a conformant Reading System or Service must satisfy all Assertions in category 1, "Core functionality".

# Reading System conformance #

## 1. Core functionality ##

  1. All programming constructs (i.e. operations, types, faults, namespaces, classes, interfaces) generated conform to the normative WSDL.
  1. Comply with WS-I Basic Profile 1.1.
  1. Support HTTP and HTTPS.
  1. Support HTTP Basic Authentication.
  1. Support HTTP range headers
  1. Support HTTP cookies.
  1. Implement the `logOn` operation.
  1. Implement the  `logOff` operation.
  1. Implement the `setReadingSystemAttributes` operation.
  1. Implement the  `getServiceAttributes` operation.
  1. Implement the  `issueContent` operation.
  1. Implement the `getContentList` operation.
    1. Support the invokation of the `getContentList` operation with the "new" id. _JA: move this to section 4. Not a requirement in an acquisition model kj: this already exists in category 4. should we remove it from here?_
  1. Implement the `getContentMetadata` operation.
  1. Implement the `getContentResources` operation.
  1. Adhere to the session initialization sequence to commence a session with a Service.
  1. Adhere to the Content Retrieval sequence to download/stream content from a Service.
  1. Support one or both of the service models.
    1. Satisfy all assertions in category 2 and/or category 3.
  1. Support one or both of the content selection models:
    1. Satisfy all assertions in category 4 and/or category 5.
  1. Support the `contentMetadata@requiresReturn` attribute to determine whether the content needs to be returned. _JA: move this to section 2 and 3 and make it more explicit_

## 2. Lending service model ##

  1. Implement the `returnContent` operation.
  1. Support the "issued" `contentList`. kj: removed expired.
  1. Must not call `returnContent` for a particular Content item until all local copies of the Content have been removed off its storage.

## 3. Acquisition service model ##

  1. Must not call the `returnContent` operation for any content that has `contentMetadata/@requiresReturn` set to `false`.

## 4. Out-of-band selection model ##

  1. Support the invokation of the `getContentList` operation with the "new" and "issued" id. _JA: and "expired" if we choose to make it required\_kj: On the last call we decided to not make expired required._

_GGT: Neither of these assertions capture what it means to support out-of-band selection. Unfortunately I don't have any suggestions at present._
kj: need to find appropriate verbiage.

## 5. Browse selection model ##

  1. Satisfy the assertions in category 11.

## 6. Updates and installments ##

  1. Support `resources@lastModifiedDate`. _JA: added this\_kj: we decided on the last telecon to not have such assertions that appear in the Service conformance area. this was because the group believed that attributes of this nature are no different from any other xml attribute in the schema._

_GGT: Should add:_ (kj: what would we say for streaming then? Would an RS need to stream if content is updated?) _JA: in streaming mode you always get the most recently updated version, while in download mode the RS should download updates automatically. we don't need an assertion(s) for streaming devices._
  * Download resources when they have been updated. _The wording needs to be worked out._
kj: agreed. need to find suitable verbiage. it is not mandatory for Reading systems to download the latest update when it appears right?

## 7. Rights management ##

  1. Support PDTB2.
  1. Set a `readingSystemAttributes/config/supportedContentProtectionFormats/protectionFormat` element to "PDTB2" in all calls to the `setReadingSystemAttributes` operation.

## 8. Key Exchange ##

# Set value(s) for `readingSystemAttributes/config/keyRing/item` element(s) in all calls to the `setReadingSystemAttributes` operation.
  1. Implement the `getKeyExchangeObject` operation.
  1. Satisfy all assertions in category 7.

## 9. Set bookmarks ##

  1. Support the portable bookmarks and highlights grammar described by the bookmark-2005-1.xsd file and section 9 of the ANSI/NISO Z39.86 specification. _JA: part of implementing the function\_kj: should we remove it then?
  1. Implement the `setBookmarks` operation.
  1. must not submit audio recordings as a part of the setBookmarks operation._GGT: This is not a requirement, it is a limitation of the spec._kj: Reading Systems still need to make sure that they don't allow audio recordings. I think it should be a testable assertion._

## 10. Get bookmarks ##

  1. Support the portable bookmarks and highlights grammar described by the bookmark-2005-1.xsd file and section 9 of the ANSI/NISO Z39.86 specification. _JA: part of implementing the function\_kj: should this be removed then?
  1. Implement the `getBookmarks` operation._

## 11. Dynamic menus ##

  1. Implement the `getQuestions` operation.
  1. The `userResponses` parameter passed to the `getQuestions` operation must contain either a response to a previous question(s) or one of the reserved IDs: "default", "search" or "back".

## 12. Service announcements ##

  1. Implement `getServiceAnnouncements` and `markAnnouncementsAsRead` operations.
  1. After an announcement has been rendered, immediately invoke the markAnnouncementsAsRead operation to inform the Service not to send the announcement again on the next invocation of the getServiceAnnouncements operation. (kj: question about multiple announcement ids being posted through the read type.) kj: now that the recommendation has been removed from the spec, any suggestions for verbiage?

SR: No need to call markAnnouncementsAsRead immediately anymore.

# Service conformance #

## 1. Core functionality ##

  1. The WSDL published by the Service is canonically equivalent to the normative WSDL provided in the specification.
  1. All programming constructs (i.e. operations, types, faults, namespaces, classes, interfaces) generated conform to the normative WSDL.
  1. Comply with WS-I Basic Profile 1.1.
  1. Must be available over http/https.
  1. Support http cookies.
  1. Support http range headers.
    1. Range headers must always be honored in HTTP requests.
  1. Implement the `logOn` operation.
  1. Implement the `logOff` operation.
  1. Implement the `setReadingSystemAttributes` operation.
  1. Implement the `getServiceAttributes` operation.
  1. Implement the `issueContent` operation.
  1. Implement the `getContentList` operation.
  1. Implement the `getContentMetadata` operation.
  1. Implement the `getContentResources` operation.
  1. Enforce the Session Innitialisation sequence as follows:
    1. Before initialization, calling any operation except logOn must return NoActiveSession fault.
    1. During initialization, after a successful `logOn`, calling any operation except `logOn` or `getServiceAttributes` must return an `InvalidOperation` fault.
    1. During initialization, after a successful `getServiceAttributes`, calling any operation except `logOn` or `setReadingSystemAttributes` must return an `InvalidOperation` fault.
    1. After a session has been initialized, calling `getServiceAttributes` or `setReadingSystemAttributes` again must not return a fault.
    1. After a session has been established, calling `logOn` again (with the correct credentials) must return `true`.
    1. If a successful `logOn` is performed in the middle of a session, calling any other operation except `logOn` or `getServiceAttributes` must return an `InvalidOperation` fault.
    1. After a session has been initialized, calling `logOff` must return `true`.
    1. If a `logOff` was successful, calling any other operation except `logOn` must return `NoActiveSessionFault`.
  1. Support one or both of the service models:
    1. Satisfy all assertions in category 2 and/or category 3.
  1. Support one or both of the content selection models:
    1. Satisfy all assertions in category 4 and/or category 5.

## 2. Lending service model ##

  1. Implement the `returnContent` operation.
  1. Offer the "issued" `contentList`.
  1. Must set the `requiresReturn` attribute of the borrowable content's `contentMetadata` type to `true`.
  1. Must set the `returnBy` attribute of the `resources` type, and not change the value of this attribute after the user has downloaded the content.
  1. Issued content must be listed in the user's "issued" `contentList` at all times after issuance and before return.
  1. If the same content is made available through both the Lending and Acquisition content models, it must have a different identifier in both the models.

## 3. Acquisition service model ##

  1. The `requiresReturn` attribute of the content's `contentMetadata` type must be set to `false`.
  1. The `returnBy` attribute of the `resources` type must NOT be set.
  1. If the same content is made available through both the Lending and Acquisition content models, it must have a different identifier in both the models.

## 4. Out-of-band selection model ##

  1. Provide one or more out-of-band mechanisms for the selection/assignment of Content.
  1. Declare support for the Out-of-band content selection method by setting the `method` element set to a value of OUT\_OF\_BAND in the `supportedContentSelectionMethods` element of its `serviceAttributes` type.
  1. Expose the selected Content to the Reading System through the `getContentList` operation when the operation is invoked with the id parameter set to the value `new`.

## 5. Browse selection model ##

  1. Satisfy all assertions for category 11.
  1. Declare support for the Browse Content Selection Method by setting the `method` element set to a value of BROWSE in the `supportedContentSelectionMethods` element of its `serviceAttributes` type.

## 6. Updates and instalments ##

  1. The `lastModifiedDate` attribute of the `contentItem` type must match the content's most recently updated resource's date. (kj: does this need to be updated as per the change log?)
  1. The `lastModifiedDate` attribute of the `resources` type must match the content's most recently updated resource's date. (kj: is this a requirement)
  1. The `lastModifiedDate` attribute of the `resource` type must match the most recently updated resource's date. (kj: is this a requirement)
_JA: change the verbiage and make this a requirement for services that choose to support updates and instalments, otherwise these attributes are useless._

## 7. Rights management ##

  1. Provide pdtb2 content.
  1. Include a meta attribute in the `contentMetadata` for the pdtb2 protected content named pdtb2:specVersion with the value 2005-1.
  1. Set @mimeType for each of the protected resource(s) in `resources` as defined in section 4.1.1, "Package file", of the PDTB2 specification.

## 8. Key provision ##

  1. Declare support for key provision by setting the `operation` element set to a value of PDTB2\_KEY\_PROVISION in the `supportedOptionalOperations` element of its `serviceAttributes` type.
  1. Implement `getKeyExchangeObject` operation.
  1. Keep a list of authorized key names.
  1. Support the keyRing element in `readingSystemAttributes`.

## 9. Set bookmarks ##

  1. Support the portable bookmarks and highlights grammar described by the bookmark-2005-1.xsd file and section 9 of the ANSI/NISO Z39.86 specification. _JA: part of implementing the function\_kj: should we remove it then?
  1. Declare support for uploading of bookmarks by setting the `operation` element set to a value of SET\_BOOKMARKS in the `supportedOptionalOperations` element of its `serviceAttributes` type.
  1. Implement the `setBookmarks` operation._

## 10. Get bookmarks ##

  1. Support the portable bookmarks and highlights grammar described by the bookmark-2005-1.xsd file and section 9 of the ANSI/NISO Z39.86 specification. _JA: part of implementing the function\_kj: should this be removed then?
  1. Declare support for retrieval of bookmarks by setting the `operation` element set to a value of GET\_BOOKMARKS in the `supportedOptionalOperations` element of its `serviceAttributes` type.
  1. Implement the `getBookmarks` operation._

## 11. Dynamic menus ##

  1. Declare support for dynamic menus by setting the `operation` element set to a value of DYNAMIC\_MENUS in the `supportedOptionalOperations` element of its `serviceAttributes` type.
  1. Implement the `getQuestions` operation.
  1. Expose the Main menu to the Reading System through the `getQuestions` operation when the operation is invoked with a `userResponse` parameter where the `questionID` element value is set to `default`.
  1. Don't expose multiple selection questions to the Reading System if it doesn't support multiple selections. (kj: is this a requirement or is this from the last draft?) (_JA: neither, but should be otherwise `readingSystemAttributs/config/supportsMultipleSelection` is completely useless)_kj: lets discuss this on the next call.
  1. Don't expose an input question when the specified input type for the question is not supported by a Reading system.

## 12. Service announcements ##

  1. Declare support for service announcements by setting the `operation` element set to a value of SERVICE\_ANNOUNCEMENTS in the `supportedOptionalOperations` element of its `serviceAttributes` type.
  1. Implement `getServiceAnnouncements` and `markAnnouncementsAsRead` operations.
  1. Don't send announcements to a user that have been declared as read through the invokation of the `markAnnouncementsAsRead` operation.