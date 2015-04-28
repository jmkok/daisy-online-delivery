Present: George, Simon, Geoff, Johan, Hiro, Markus and Kenny

Regrets: Nick

scribe: Kenny

## Action Item Summary ##

### New Action Items ###

  * Kenny, Nick and Simon to verify that the relative values specified for soap action in the wsdl (in the svn) eliminates the particular issue in the Microsoft platform, and close [Issue 190](https://code.google.com/p/daisy-online-delivery/issues/detail?id=190).
  * Geoff ensure that @xml:lang and @dir are both defined for Label, and close [Issue 93](https://code.google.com/p/daisy-online-delivery/issues/detail?id=93). {done}
  * George talk to pdtb2 folks about modifying their version of kxo.xsd.
  * After the pdtb2 folks have fixed their version of kxo.xsd, kenny to change xsds to their canonical uris, and close [issue 128](https://code.google.com/p/daisy-online-delivery/issues/detail?id=128) and [Issue 144](https://code.google.com/p/daisy-online-delivery/issues/detail?id=144).
  * Geoff change "canonical identifier..." in the supportedUplinkAudioCodecs portion of serviceAttributes to mime type in the documentation, and close [issue 177](https://code.google.com/p/daisy-online-delivery/issues/detail?id=177). {done}
  * Geoff implement the importing normative wsdl into a published concrete wsdl suggestion, and close [issue 189](https://code.google.com/p/daisy-online-delivery/issues/detail?id=189). {done}
  * Geoff to add @lastModifiedDate to resources, and close [Issue 192](https://code.google.com/p/daisy-online-delivery/issues/detail?id=192).
  * Geoff to allow empty supportedContentFormats and supportedMimeTypes elements, add the verbiage to the documentation suggesting the implication, and close [Issue 193](https://code.google.com/p/daisy-online-delivery/issues/detail?id=193).
  * kenny close [Issue 197](https://code.google.com/p/daisy-online-delivery/issues/detail?id=197). {done}
  * kenny contact Nick to find out if RNIB will support the test cases defined in the Systems Testing document. {done}
  * All to review the Systems Testing document and determine if the test cases are sufficient for their organisation. We will visit the sufficiency of the test cases and what organisations will participate in these tests on the next telecon.

### Previous Unfinished Action Items ###

  * Kenny modify the bookmark xsd to eliminate empty complex types. [Issue 188](https://code.google.com/p/daisy-online-delivery/issues/detail?id=188) should be kept open until the group has reviewed the xsd.
  * Geoff and Kenny start work on the Test suite. (In progress)
  * Geoff and Kenny start work on the Systems Testing document (in progress)
  * Markus fix the &apos; entity problem. (outstanding; bug in IE.) (Markus will fix this when ready to publish.)

### Group Action Items ###

#### Action items for the public review period commencing February 15, 2010 ####

  * All issues should be resolved or formally deferred.
  * Any updates to the spec need to be completed and proof read.
  * The primer should be proof read.
  * The Test suite, The Systems testing document and the Test Implementations Conformance report should be made available.
  * Create an area where implementers can post information about the additional features that they have implemented on top of the spec, and that the community at large may be interested in.

#### Action items for formal recommendation to the Board on April 5, 2010 ####

  * Deliver Final version of the spec.
  * Provide Information on comments Received, and how they were addressed.
  * Make available the Test Implementations Conformance Report.
  * make available the systems testing  document.
  * Make a formal Recommendation to the board for approval.

## Agenda/Minutes ##

### Issues ###

#### [Issue 128](https://code.google.com/p/daisy-online-delivery/issues/detail?id=128) ####

markus: IBMs WS-I Validator says:

The errors below were detected when validating the file "kxo.xsd" via the
file "do-wsdl-10.wsdl".  In most cases these errors can be detected by
validating "kxo.xsd" directly.  However it is possible that errors will
only occur when kxo.xsd is validated in the context of do-wsdl-10.wsdl.

```
Line 63: InvalidRegex: Pattern value
'([A-Za-z0-9-_:])+(\.([A-Za-z0-9-_:])+)*' is not a valid regular
expression. The reported error was: ''-' is an invalid character range.
Write '\-'.'.
```

markus: Matt fixed this in the local version. Need to report to PDTB2 folks.

markus on behalf of Matt:  That aside, there's a bad regex in the schema:
```
<xs:pattern value="([A-Za-z0-9-_:])+(\.([A-Za-z0-9-_:])+)*" />
```
As I'm sure you know, dashes delimit character ranges in character sets unless they
are the first character, so the above should be:
```
<xs:pattern value="([-A-Za-z0-9_:])+(\.([-A-Za-z0-9_:])+)*" />
```
markus: The PDTB folks have been informed. We want to reference kxo.xsd in its canonical
location in the final release, but depend on this to be fixed there first.

Resolution: Keep this issue open until the PDTB2 folks resolve the issue in their version of kxo.xsd. George will have a word with the PDTb2 folks to affect this change.

#### [Issue 144](https://code.google.com/p/daisy-online-delivery/issues/detail?id=144) ####

Markus: xml.xsd, dc.xsd, kxo.xsd are all examples of schemas that have canonical
URIs associated with them. Once development is done, we should revert to
using those URIs instead of local copies.

Resolution: Keep this issue open until the pdtb2 folks have fixed their version of kxo.xsd (i.e. [Issue 128](https://code.google.com/p/daisy-online-delivery/issues/detail?id=128))

#### [Issue 177](https://code.google.com/p/daisy-online-delivery/issues/detail?id=177) ####

Geoff: In the supportedUplinkAudioCodecs part of the serviceAttributes, the
individual codecs are identified by "The codec's canonical identifier
string as dictated by its specification."

http://www.daisy.org/projects/daisy-online-delivery/drafts/20090910/do-spec-20090910.html#tp_codec

This is problematic, since many specs don't dictate a "canonical identifier
string".  Perhaps MIME type would be better, or else dc:Format.

jelle: Should we enumerate mime types? Mime types if not enumerated may be quite open.

geoff: Services can already say what they support.

jelle: Not enumerating mime types may cause interoperability issues.

Kenny: Although a more full-proof idea, we don't have a lot of time left before the public review period. Could we perhaps look at enumerating mime types in the next version of the spec?

Geoff: I suggest we keep mime types open as is the case right now because they are going to be defined by the Service.

Markus: Can a Service require a particular mime type?

Geoff: There is a default wav mime type. userResponse.data specifies this value.

Resolution: Geoff to change "canonical identifier" to mime type in the documentation.

> #### [Issue 189](https://code.google.com/p/daisy-online-delivery/issues/detail?id=189) ####

Geoff: Appendix A states, "Service implementors must publish a concrete WSDL
document at some URI. The [INFOSET](INFOSET.md) of the concrete WSDL document must be
identical to the do-wsdl-10.wsdl document with the exception of the WSDL
service element, which defines the locally supported ports."

It should either be allowed or required that, rather than creating a
nearly-identical document to serve as a Service's concrete WSDL, that the
concrete WSDL imports do-wsdl-10.wsdl.  For example:

example.wsdl:
```
<?xml version="1.0" encoding="utf-8"?>
<definitions xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
xmlns:tns="http://www.daisy.org/ns/daisy-online/"
targetNamespace="http://www.daisy.org/ns/daisy-online/"
xmlns="http://schemas.xmlsoap.org/wsdl/">

  <import namespace="http://www.daisy.org/ns/daisy-online/"
location="http://www.daisy.org/projects/daisy-online-delivery/do-wsdl-10.wsdl"/>
  
  <service name="example">
    <document>
      Example DAISY Online Service
    </document>

    <port name="examplePort" binding="tns:DaisyOnlineService">
      <soap:address location="http://example.com/daisy-online/"/>
    </port>
  </service>
</definitions>
```

Resolution: Geoff's suggestion is the most well-engineered solution available, so it should be adopted. Geoff to make the necessary change to the spec.

#### [Issue 192](https://code.google.com/p/daisy-online-delivery/issues/detail?id=192) ####

geoff: We currently have the lastModifiedDate for a Content item displayed only in
the `<contentItem>` element within a contentList.  Suppose you already have
some Content and want to check whether it has been updated.  Do you have to
find a contentList that the contentItem might be in to check it?  This
isn't a big problem for out-of-band selection, since there are only a few
lists to choose from, but what about browse selection?

Geoff: I'm thinking we should add lastModifiedDate to the contentMetadata.  Another place
might be the contentResources, except we've already decided that Services can limit
the number of calls to getContentResources.

Geoff: Also, the documentation for contentList/contentItem@lastModifiedDate says that this
should equal the last modified time of the most recently modified resource of the
Content.  However, there is the edge case where a resource has been removed, so even
though the Content has been updated, the lastModifiedDate is no later than it was
before the resource was deleted, when it should reflect the last change to the Content.

Resolution: @lastModifiedDate to be added to resources. Geoff to make the change.

#### [Issue 193](https://code.google.com/p/daisy-online-delivery/issues/detail?id=193) ####

Geoff: How does a Reading System notify a Service that it supports all Content
formats and MIME types?  For instance, say it's a proxy downloader that
doesn't actually know what formats are supported on the playback device,
and the Service shouldn't filter by format.

Resolution: Allow empty supportedContentFormats and supportedMimeTypes. If these elements are empty, they will imply that the Reading System is not saying anything about the supported content formats or mime types, and thus can accept any value.

#### [Issue 197](https://code.google.com/p/daisy-online-delivery/issues/detail?id=197) ####

Kenny on behalf of Jelle: If the getBookmark and setBookmark operations were to be replaced by
getBlob and setBlob operations, and instead of posting and retrieving a
bookmarkset type, a Reading System could post any string or perhaps a
binary blob, would this be a more expedient approach to handling bookmarks
in the spec?

Resolution: This is out of scope for this version of the spec.

### Test suite Progress ###

#### [Test Suite](http://code.google.com/p/daisy-online-delivery/wiki/tsg_test_suite) ####

#### [Systems Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolSystemTestingTestCases) ####

geoff: two things I wannt to find out:
  1. Are the test cases in the systems testing document sufficient for the organisations?
  1. What organisations will participate in these tests?

Simon: I will look at the Systems Testing document this week.

Kenny: We will participate in Humanware and Plextor's endeavours to run these test cases from our Service's perspective. I will also look at both the documents this week.

Johan: We will make our Service Available for these tests. Our Service is already available.

Geoff: Most of the Services are already available.

## [Change Log](http://code.google.com/p/daisy-online-delivery/wiki/ChangeLog) ##

Next telecon at 1900 UTC on 13 January 2010.