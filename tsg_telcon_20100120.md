Present: Simon, Geoff, Nick, Markus, Kenny, Jelle and Johan.

Regrets: George and Dominik.

scribe: Kenny

## Action Item Summary ##

### New Action Items ###

  * Kenny to remove the Sample PDTB2 content from the SVN, and pass an alternative url to the group members. **done**
  * Kenny to verify sample pdtb2 package content with Neale.
  * Kenny inform Hiro about the public key requirement.
  * Simon, Jelle and Hiro to supply the service implementers their public key.
  * Geoff, Kenny and Johan to create the RS specific KXOs and share them with all service implementers.
  * Simon, Geoff and Johan to post their observations on running the latest version of the bookmark XSD against their tools.
  * kenny and Simon to verify that the issue that svcutil had with empty soap action values is now resolved with the implemented solution. If yes, close [Issue 190](https://code.google.com/p/daisy-online-delivery/issues/detail?id=190).
  * Johan to add Announcements specific test cases to the [Conformance Testing](tsg_test_suite.md) document.
  * Geoff to add test cases for announcements and i18n to the ProtocolSystemTesting document. **Done**
  * Geoff to add a note to section 4.7.6 as per [Issue 200](https://code.google.com/p/daisy-online-delivery/issues/detail?id=200). **Done**
  * Geoff to make the verbiage consistent across Section 4.3.1 and 4.3.2 as per Kenny's suggestion. **Done**
  * Kenny to reflect all the changes recorded in the change log in the Dynamic Menus Primer.
  * Geoff to make the Systems Testing document ready for sign off by the next telecon.
  * Kenny to make sure that the Conformance Testing document has all the assertions defined by the next telecon.

### Previous Unfinished Action Items ###

  * Geoff, Johan, Simon, Hiro and Kenny to build PDTB2 support in their test implementations by Feb 15 using the sample content provided by Neale.
  * James and Neale fix the kxo.xsd issue in the PDTB2 spec by 5 Feb.
  * After the pdtb2 folks have fixed their version of kxo.xsd, kenny to change XSDs to their canonical URIs, and close [issue 128](https://code.google.com/p/daisy-online-delivery/issues/detail?id=128) and [Issue 144](https://code.google.com/p/daisy-online-delivery/issues/detail?id=144).
  * All review the bookmark XSD and confirm whether the empty complex type problem has been resolved. If yes, close [Issue 188](https://code.google.com/p/daisy-online-delivery/issues/detail?id=188).
  * All to review the Systems Testing document and determine if the test cases are sufficient for their organization. We will visit the sufficiency of the test cases and what organizations will participate in these tests on the next telecon.
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

### Sample PDTB2 Content ###

Nick: What keys are included with the package?

Kenny: My understanding is that Neale has included a public/private key pair with the package to unlock the authorization object. The AO contains the symmetric keys to unlock the audio and text media types in the daisy fileset. The KXO has been skipped in this package as a KXO is used to transfer the public/private key pair used to lock the AO, a pair that Neale has provided us with the package. For the test implementations, we will need a KXO for the getKeyExchangeObject operation which would contain the public/private key pair that Neale provided, encrypted/locked with the public key of the Reading System. Should we generate a public/private key pair to be used to lock the KXO across all the implementations?

Geoff: I would be more comfortable if we used public keys supplied by manufacturers.

Kenny: I am concerned that this may create more work for service implementers.

Geoff: If we do it this way, we can share the KXOs for each RS implementer.

(The group agreed to create a KXO for each RS implementer. Jelle, Simon and Hiro will supply the service implementers with their public keys that will then be used to secure the KXO. This KXO will be shared among service implementers to reduce redundancy of effort)

Johan: For the Test Implementation phase, are RS implementers required to be able to render pdtb2 content to prove pdtb2 support in their implementation?

Geoff: As per the Systems testing document, Yes.

### Suggestion for an addition of a note to Section 4.7.6 ###

Nick: Should we add a note to section 4.7.6 explaining that support for the three reserved question ids should be declared in serviceAttributes - supportsServerSideBack, supportsSearch and supportedOptionalOperations | operation | DYNAMIC\_MENUS

(the group accepted Nick's suggestion. Geoff to fix this in the spec.)

> ### Suggestion for a cosmetic change to section 4.3.2 ###

Kenny: Section 4.3.2 (Browse content selection method) reads:
"...declares support for the Browse Content Selection Method in the supportedContentSelectionMethods service attribute..."

and Section 4.3.1 (Out-of-band selection method) reads:
"...declares support for the Out-of-band Content Selection Method in the supportedContentSelectionMethods element of its serviceAttributes..."

Although cosmetic, I propose we make the verbiage consistent across both sections.

(The group accepted Kenny's suggestion. Geoff to fix this in the spec.)

### Proposed changes to the Dynamic Menus Primer ###

Simon:
  * At the end of "2. Retrieving the Main Menu", change XSD ID to NMTOKEN in "These IDs are defined in WSDL as the XSD ID type (see XSD Datatypes), and ..."

  * In section "3. Performing a Search of the Service's Content Collection", input type should be `TEXT_ALPHANUMERIC`:
```
  <questions xmlns="http://www.daisy.org/ns/daisy-online/">

      <inputQuestion id="q2-1">

          <inputTypes>

              <input type="TEXT_NUMERIC"/>

          </inputTypes>

          <label xml:lang="en">

              <text>Please enter the name of the Author.</text>

          </label>

      </inputQuestion>

  </questions>
```
  * Same thing in "5. Taking a Survey (with audio responses)"
```
    <inputQuestion id="q4-1">

        <inputTypes>

            <input type="TEXT_NUMERIC"/>

        </inputTypes>

        <label xml:lang="en">

            <text>What is your favourite feature in the Service?</text>

        </label>

    </inputQuestion>
```
  * Fix `&apos;`

(The group decided that all the pertinent changes recorded in the change log needed to be reflected in the Dynamic Menus Primer. Kenny to reflect all these changes in the Primer. The `&apos;` entity problem will be fixed as a part of Markus's action item to fix this problem across the spec.)

### Timelines going forward ###

Geoff: The Systems Testing document should be made available before the spec is submitted for approval by the board.

Kenny: We should have the Conformance Testing and conformance report documents ready before the formal submission too. I don't think these documents need to be made available before the public review period commencing on Feb 15.

Nick: I am not very clear about the purpose of the conformance and systems testing documents.

Kenny: The conformance testing document (called tsg\_test\_suite in the wiki) lists the test cases for Services and Reading Systems to claim conformance to the spec. The Systems Testing document (called ProtocolSystemTesting in the wiki) is a report on how well the spec satisfies the requirements and expectations gathered in the requirements gathering phase.

Nick: Who will run the test cases in the Systems Testing document?

Geoff: Some test cases in the Systems Testing document will need to be run by Service implementers. The rest will need to be run by RS implementers.

Markus: We need two independent implementations that prove conformance to the spec.

Kenny: In terms of the test cases, we need two implementations per test case.

Geoff: George indicated that it would be possible for certain features to get away with one implementation. Ideally, we should have two server, and two client implementations.

Kenny: Lets define the time frames for the two documents.

Geoff: The systems Testing document should be ready for sign off by the next telecon.

Kenny: All the assertions in the Conformance Testing document should be ready by next telecon.

### Test suite Progress ###

#### [Test Suite](http://code.google.com/p/daisy-online-delivery/wiki/tsg_test_suite) ####

#### [Systems Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolSystemTestingTestCases) ####

Geoff: two things I want to find out:
  1. Are the test cases in the systems testing document sufficient for the organizations?
  1. What organizations will participate in these tests?

Johan: We don't mention anything about announcements in the Systems Testing document.

Geoff: Good point.

Johan: We also need more tests for sessions e.g. what happens if an operation is called after a session has ended ...

## [Change Log](http://code.google.com/p/daisy-online-delivery/wiki/ChangeLog) ##

Next telecon at 2100 UTC on Wednesday, 27 January 2010.