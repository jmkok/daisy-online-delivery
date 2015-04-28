Present: George, James, Neale, Geoff, Simon, Hiro, Johan and Kenny.

Regrets: Jelle, Markus and Nick.

scribe: Kenny

## Action Item Summary ##

### New Action Items ###

  * Neale provide sample content with the public/private key pair by 22 January.
  * Geoff, Johan, Simon, Hiro and Kenny to build PDTB2 support in their test implementations by Feb 15 using the sample content provided by Neale.
  * Kenny ask Nick about support for PDTB2 in his test implementation.
  * James post to the PDTB2 list proposing Ole's suggestion, and asking for any other issues with the spec.
  * James and Neale fix the kxo.xsd issue in the PDTB2 spec by 5 Feb.
  * Geoff change xs:id to xs:nmTOKEN for the getContentList operation xml serialisation definition in the types section of the wsdl file. **Done**
  * All review the bookmark xsd and confirm whether the empty complex type problem has been resolved. If yes, close [Issue 188](https://code.google.com/p/daisy-online-delivery/issues/detail?id=188).

### Previous Unfinished Action Items ###

  * Kenny, Nick and Simon to verify that the relative values specified for soap action in the wsdl (in the svn) eliminates the particular issue in the Microsoft platform, and close [Issue 190](https://code.google.com/p/daisy-online-delivery/issues/detail?id=190).
  * Geoff ensure that @xml:lang and @dir are both defined for Label, and close [Issue 93](https://code.google.com/p/daisy-online-delivery/issues/detail?id=93). **Done**
  * George talk to pdtb2 folks about modifying their version of kxo.xsd.
  * After the pdtb2 folks have fixed their version of kxo.xsd, kenny to change xsds to their canonical uris, and close [issue 128](https://code.google.com/p/daisy-online-delivery/issues/detail?id=128) and [Issue 144](https://code.google.com/p/daisy-online-delivery/issues/detail?id=144).
  * Geoff change "canonical identifier..." in the supportedUplinkAudioCodecs portion of serviceAttributes to mime type in the documentation, and close [issue 177](https://code.google.com/p/daisy-online-delivery/issues/detail?id=177). **Done**
  * Geoff implement the importing normative wsdl into a published concrete wsdl suggestion, and close [issue 189](https://code.google.com/p/daisy-online-delivery/issues/detail?id=189). **Done**
  * Geoff to add @lastModifiedDate to resources, and close [Issue 192](https://code.google.com/p/daisy-online-delivery/issues/detail?id=192). **Done**
  * Geoff to allow empty supportedContentFormats and supportedMimeTypes elements, add the verbiage to the documentation suggesting the implication, and close [Issue 193](https://code.google.com/p/daisy-online-delivery/issues/detail?id=193). **Done**
  * kenny close [Issue 197](https://code.google.com/p/daisy-online-delivery/issues/detail?id=197). **Done**
  * kenny contact Nick to find out if RNIB will support the test cases defined in the Systems Testing document. {**Done**
  * All to review the Systems Testing document and determine if the test cases are sufficient for their organisation. We will visit the sufficiency of the test cases and what organisations will participate in these tests on the next telecon.
  * Kenny modify the bookmark xsd to eliminate empty complex types. [Issue 188](https://code.google.com/p/daisy-online-delivery/issues/detail?id=188) should be kept open until the group has reviewed the xsd. **Done**
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

### Welcome PDTB2 folks ###

#### # PDTB2 support in the Daisy Online spec ####

George: We want to have at least two Daisy Online test implementations with PDTB2 support.

Geoff: We need to answer the question whether the getKeyExchangeObject operation is required in the spec.

Neale: We have an expansive implementation of the PDTB2 spec in NLS.

Kenny: When the PDTB2 spec was designed, were web services considered as a distribution mechanism for the key exchange object? I remember reading in the spec that web services were one of the distribution mechanisms envisaged. Is my understanding correct?

James: Yes. We looked at what such a web service could look like.

James: In terms of the way we currently distribute the key exchange object in RFB&D, our clients log on to our E-Commerce site, choose the model of the Reading System being used by specifying the serial number of their Reading System, and our servers then generate the key exchange object, offering it as a downloadable file. This file then has to be manually downloaded and transfered on to the Reading system by a client.

Kenny: My understanding of the PDTb2 spec is that a public and private key pair is used to secure the transmission of the key exchange object. The key exchange object contains the key to unlock the authorisation object. The authorisation object contains the key to unlock the actual Daisy file set. We do not have a mechanism in the Daisy Online spec to authorise Reading Systems (i.e. A Reading System cannot pass its public key to the Service for securing the transmission of the key exchange object). The authorisation of a Reading System has to happen through an out-of-band mechanism. This deals with the Rogue Reading System scenario, as a Service has to trust a reading System out-of-band before the key exchange object and the actual daisy file set with the authorisation object is transfered.

George: The exchange of the Reading System's public key with NLS is out-of-band with your Service too, James?

James: Currently, we get the public keys for the Reading Systems directly from the manufacturers. Ideally, we would like a Web Service to transfer these public keys, but this is out of scope for now.

James: Does the Working group require some sample and keys?

Geoff: Yes.

Neale: Send us a public/private key pair. We will encrypt some public content and send it across.

Kenny: If we were to send you a public/private key pair, how long would it take you to give us some encrypted content?

Neale: I need to find out what kind of content we can lend without copyright implications.

George: You could pick up some Daisy content from the Daisy Consortium website. This would eliminate the copyright issue.

Kenny: Would it be possible then for you to generate the public and private key pair too along with encrypting the sample content, Neale? I think this may be the most expedient approach.

Neale: (graciously agrees to generate the public/private key pair, encrypt the sample content with it, and give us the lot in a week's time.)

(Thank you Neale.)

Kenny: Who intends to build pdtb2 support in their test implementation using this sample content from Neale?

(Geoff, Johan, Hiro, Simon and kenny will all endeavour to build this support in their test implementations before Feb 15)

#### Modifying kxo.xsd ####

James: We currently have the xso.xsd schema like other schemas inline in the spec. Ole suggested that we move all the schemas out of the spec into separate files, and reference them from the spec. We will do this, make the change, and record the change in the errata.

Neale: Michael from NLS has pointed out a few additional things that need fixing in the PDTB2 spec.

James: I will post to the PDTB2 list proposing that Ole's suggestion be implementted, and that group members come forth with any issues that they would like fixed with the spec.

Kenny: We need kxo.xsd fixed in the PDTB2 spec before Feb 15 to meet our timelines.

Geoff: If kxo.xsd is not fixed in the PDTB2 spec, we cannot close [Issue 144](https://code.google.com/p/daisy-online-delivery/issues/detail?id=144) that requires schemas to be refered to using their canonical identifiers.

Kenny: James and Neale, would you be able to fix the issue with kxo.xsd by the first week of February?

James and Neale: Yes.

### Should the ID data type be changed to the String or NMTOKEN data type in the xsds ###

Simon: Should we change all instances of xs:id in the xsds and wsdl to nmTOKEN?

Geoff: I think the IDs used in the Question type may be a good candidate for this change.

Kenny: We spotted a case sensitivity issue with the nmTOKEN type when consumed by svcutil. Did it work for you Simon?

Simon: No it did not. When I got the case right, svcutil created the construct as a String, which is the same as changing xs:nmTOKEN to xs:string.

Kenny: This issue with svcutil and xs:id only happens with the getContentList operation definition in the types section of the wsdl file, right?

Simon: Yes.

Kenny: Given that svcutil only has an issue with this instance of the xs:id type declaration, should we change just this instance to xs:nmTOKEN?

Resolution: Only change the instance of xs:id in the getContentList operation xml serialisation definition to xs:nmTOKEN. Leave all other instances as is.

## Items for Next week ##

### Spec update progress ###

  1. documentation including the wsdl and xsd files.
  1. systems testing and test suite documents.
  1. conformance report.

### Test implementation update ###

Where are we at?

### Timelines going forward ###

### Test suite Progress ###

#### [Test Suite](http://code.google.com/p/daisy-online-delivery/wiki/tsg_test_suite) ####

#### [Systems Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolSystemTestingTestCases) ####

geoff: two things I wannt to find out:
  1. Are the test cases in the systems testing document sufficient for the organisations?
  1. What organisations will participate in these tests?

## [Change Log](http://code.google.com/p/daisy-online-delivery/wiki/ChangeLog) ##

Next telecon at 21:00 UTC on 20 January, 2010.