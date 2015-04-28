# From the Final Draft to Proposed Recommendation #

This is an aggregation of all the changes to the protocol made since the Final ([r907](https://code.google.com/p/daisy-online-delivery/source/detail?r=907)) was released 17 February 2010.

## API ##

Changes to `do-wsdl-10.wsdl`:

  * Noted that the `issueContent` operation must return `true` if the Content item is already issued.
  * Noted that the `returnContent` operation must return `true` if the Content item has already been returned.
  * Clarified the use of Content Identifiers for operations `getContentMetadata` and  `getContentResources`.
  * Removed `noActiveSession` fault for the signature of `logOff`.
  * Noted that the `getContentList` operation must return an empty list with the value of `totalItems` set to the total number of items in the entire list if the `firstItem` or `lastItem` parameter is invalid.

## Types ##

Changes to `do-types-10.xsd`:

  * Noted that a Service is not required to send labels containing audio if the Service does not support audio labels and the Reading System requires audio labels. The Reading system must decided whether to continue initializing a session if this scenario.
  * Changed `minOccurs` value from 0 to 1 for element `inputQuestion/inputTypes`.

Changes to `bookmark-2005-1.xsd`:

  * Changed the location of the XML schema to its canonical URL.
  * Added attribute `elementFormDefault="qualified"` to schema.

## Documentation ##

  * Noted that a Service may issue a cookie even if `logOn`operation fails.
  * Noted that a return value of `false` to a call of `markAnnouncementsAsRead` indicates that the announcement has already been marked as read.
  * Noted that the Reading System must call the `markAnnouncementsAsRead` operation sequentially for each announcement, if a prior call to this operation returns fault, when the Reading Systems attempt to mark serveral announcements as read within the same call.
  * Noted that the `logOff` operation can be called within the initialization sequence and that the Service must not throw an `invalidOperation` fault.
  * Noted that a Service must return an `invalidParameter` fault if a Reading Systems calls the `getQuestions` operation with the predefined value `back` when no prior calls to this operation have been made in the active session.
  * Noted that Service must return an `invalidParamter` fault if  Reading Systems calls the `getQuestion` operation with the value set to wither `back` or `search` when these values are not supported by the Service.
  * Added section describing content synchronization.
  * Noted that a Service should allow a Reading System to access resources outside of an active session. However, this is not a requirement.
  * Updated Primer and examples of the Dynamic Menu feature.

# From the Trial Use Draft to Final Draft #

This is an aggregation of all the changes to the protocol made since the Draft for Trial Use ([r566](https://code.google.com/p/daisy-online-delivery/source/detail?r=566)) was released 27 September 2009.

## API ##

Changes to `do-wsdl-10.wsdl`:

  * All `soap:operation`s now have the `soapAction` attribute set to `"/operationName"`.
  * Added note that `returnContent` must never return `false`, only `true` or a fault.
  * Added the `invalidOperation` fault to the signatures of `logOff` and `getContentMetadata`.
  * `keyRing` parameter removed from `getKeyExchangeObject` (moved to ```readingSystemAttributes/config/keyRing``).
  * Calling `getKeyExchangeObject` with unauthorized keys in the `keyRing` results in an `invalidParameter` fault, not `invalidOperation`.
  * Datatype changes:
    * `getContentList/firstItem` changed from `xs:integer` to `xs:int`.
    * `getContentList/id` changed from `xs:ID` to `xs:NMTOKEN`.
    * `getContentList/lastItem` changed from `xs:integer` to `xs:int`.
  * Changed the location of the KXO schema to its canonical URL.

## Types ##

Changes to `do-types-10.xsd`:

  * Moved `contentMetadata@returnBy` to `resources@returnBy`. This means the Reading System does not need to check getContentMetadata both before and after issuance, and that `@returnBy` is not displayed before issuance. Added note that the attribute may not change while the Content is issued.
  * `label@xml:lang` is now required.  Added optional `label@dir` to indicate direction of text.
  * Added optional `resources@lastModifiedDate`.  Changed the definition of `contentItem@lastModifiedDate` to remove reference to most recent resource.
  * Allowed unlimited `contentMetadata/metadata/narrator`s, not just one.
  * Allowed empty `readingSystemAttributes/config/supportedContentFormats`.
  * `readingSystemAttributes/config/keyRing` added (moved from `getKeyExchangeObject`).
  * `serviceAttributes/supportedUplinkAudioCodecs/codec` now refers to MIME types, not "canonical identifier strings".
  * New `input` type created. `readingSystemAttributes/config/supportedInputTypes/input` and `inputQuestion/inputTypes/input` now both refer to it.  The new `input` type does not have an `xml:lang` attribute.
  * Datatype changes:
    * `announcements/announcements/id` changed from `xs:ID` to `xs:NMTOKEN`.
    * `contentList@firstItem` changed from `xs:integer` to `xs:int`.
    * `contentList@id` changed from `xs:ID` to `xs:NMTOKEN`.
    * `contentList@lastItem` changed from `xs:integer` to `xs:int`.
    * `contentList@totalItems` changed from `xs:integer` to `xs:int`.
    * `contentList/contentItem/id` changed from `xs:ID` to `xs:string`.
    * `contentMetadata/metadata/size` changed from `xs:integer` to `xs:long`.
    * `contentMetadata/metadata/meta@name` changed from `unspecified` to `xs:string`.
    * `contentMetadata/metadata/meta@content` changed from `unspecified` to `xs:string`.
    * `contentMetadata@category` changed from `unspecified` to `xs:string`.
    * `inputQuestion@id` changed from `xs:ID` to `xs:NMTOKEN`.
    * `label/audio@rangeBegin` changed from `xs:integer` to `xs:long`.
    * `label/audio@rangeEnd` changed from `xs:integer` to `xs:long`.
    * `label/audio@size` changed from `xs:integer` to `xs:long`.
    * `multipleChoiceQuestion@id` changed from `xs:ID` to `xs:NMTOKEN`.
    * `multipleChoiceQuestion/choices/choice@id` changed from `xs:ID` to `xs:NMTOKEN`.
    * `questions/contentListRef` changed from `xs:ID` to `xs:NMTOKEN`.
    * `resource@size` changed from `xs:integer` to `xs:long`.
    * `serviceAttributes/service@id` changed from `xs:string` to `xs:NMTOKEN`.
    * `serviceAttributes/serviceProvider@id` changed from `xs:string` to `xs:NMTOKEN`.
  * Changed the location of the XML, DC and KXO schemata to their canonical URLs.

Changes to `bookmark-2005-1.xsd`:

  * Changed the following types from empty complex types to `xs:string`s:
    * `uid`
    * `timeOffset`
    * `text`
  * Changed `ncxRef` from empty complex type to `xs:anyURI`
  * Changed `charOffset` from empty complex type to `xs:long`
  * Put the following groups (marked with curly braces `{}`) inside `<xs:sequence>` (does not change the syntax, but allows some XSD parsers to work):
    * `lastmark/{bookmarkContent}`
    * `hilite/hiliteStart/{hiliteContent}`
    * `hilite/hiliteEnd/{hiliteContent}`
  * Removed attribute `lastmark@label`

## Documentation ##

  * Changed WSDL publishing requirements in Appendix A to have the published WSDL import the provided WSDL, rather than be a modified copy.
  * Added recommendation that menu state be retained for the duration of the session.
  * Added note that says that audio notes are not supported at all.  (Previously it had only mentioned it in setting bookmarks.)
  * Noted that the `keyRing` should only contain names of key pairs, not symmetric keys.
  * Removed recommendation that `markAnnouncementsAsRead` be called immediately after each announcement is read.
  * Updated examples and Primer to the latest changes.