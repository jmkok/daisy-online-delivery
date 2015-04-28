present: Johan, Hiro, markus, geoff, jelle and kenny.

Regrets: George

scribe: Kenny

## Action Item Summary ##

### New Action Items ###

  * kenny to post suggestion 2 for pdtb2 support to the list as the group's decision going forward, and ask for any objections.
  * Geoff to record an issue in the issue tracker for the setBlob/getBlob operations as suggested by Jelle, and mark this issue as an enhancement for the next version of the spec.
  * Kenny to inform the pdtb2 folks that the documentation of the pdtb2 spec is inconsistent with the KXO xsd, specifically in terms of the definition of the encryptedKey element.
  * kenny to make the required cosmetic change to section 4.4.3, and present it to the group for review.
  * Johan to implement his suggestion for [Issue 203](https://code.google.com/p/daisy-online-delivery/issues/detail?id=203) without the xml:lang attribute to the do-types-10.xsd file, and present it to the group for review. Once the group has reviewed the change, Johan to close [issue 203](https://code.google.com/p/daisy-online-delivery/issues/detail?id=203).
  * Geoff to add Johan's suggested tweak to the bookmark xsd, and present it to the group for review. If no problems are reported, close [Issue 202](https://code.google.com/p/daisy-online-delivery/issues/detail?id=202).
  * kenny check with Simon whether the implemented solution for the correct handling of soap action by svcutil has resolved the particular problem with svcutil. If yes, close [Issue 190](https://code.google.com/p/daisy-online-delivery/issues/detail?id=190).
  * all to review the Systems testing document by next telecon.
  * kenny to complete the service conformance section of the conformance testing document by next telecon.
  * All review the RS conformance section of the conformance testing document by the next telecon.
  * Kenny to close [Issue 188](https://code.google.com/p/daisy-online-delivery/issues/detail?id=188).

### Previous Unfinished Action Items ###

  * Kenny to remove the Sample PDTB2 content from the SVN, and pass an alternative url to the group members. **done**
  * Kenny to verify sample pdtb2 package content with Neale. **done**
  * Kenny inform Hiro about the public key requirement. **pending - awaiting decision on pdtb2 support**
  * Simon, Jelle and Hiro to supply the service implementers their public key. **pending - awaiting decision on pdtb2 support**
  * Geoff, Kenny and Johan to create the RS specific KXOs and share them with all service implementers. **pending - awaiting decision on pdtb2 support**
  * Johan to add Announcements specific test cases to the [Conformance Testing](tsg_test_suite.md) document.  **Done**
  * Geoff to add test cases for announcements and i18n to the ProtocolSystemTesting document. **Done**
  * Geoff to add a note to section 4.7.6 as per [Issue 200](https://code.google.com/p/daisy-online-delivery/issues/detail?id=200). **Done**
  * Geoff to make the verbiage consistent across Section 4.3.1 and 4.3.2 as per Kenny's suggestion. **Done**
  * Kenny to reflect all the changes recorded in the change log in the Dynamic Menus Primer. **tentative: should be done by  next telecon**
  * Geoff, Johan, Simon, Hiro and Kenny to build PDTB2 support in their test implementations by Feb 15 using the sample content provided by Neale.
  * James and Neale fix the kxo.xsd issue in the PDTB2 spec by 5 Feb.
  * After the pdtb2 folks have fixed their version of kxo.xsd, kenny to change XSDs to their canonical URIs, and close [issue 128](https://code.google.com/p/daisy-online-delivery/issues/detail?id=128) and [Issue 144](https://code.google.com/p/daisy-online-delivery/issues/detail?id=144).
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

### PDTB2 support in Daisy Online ###

#### Discussion on the list ####

jelle: In short: I would propose to remove the getKeyExchangeObject. But still have the full PDTB2 functionality available. As far as I can see it has no drawbacks, and simplifies the process of PDTB2 content download.

For this to work, I made the following assumption:
PDTB2 works on a media like CDROM / SD card (and thus the KXO is actually a file).

When reading this above assumption, you might get a feeling where we would like to be going...
So instead of requesting the KXO using a specific function, the KXO would actually be included in the "getContentResources" list. Just like it would be on a CDROM or an SD card.

For this to work, the server still needs to know which keys it might use in the KXO. We should add the keynames to the "setReadingSystemAttributes". This might even be not such a odd choice as the PDTB2 keynames could actually be considered as a reader attribute.

So how would such a typical situation look like:
- soap:logOn
- soap:setReadingSystemAttributes (with the PDTB2 keynames)
- soap:getContentResources => will now additionally contain (one or
more) KXO files.
- download and store (or play)

Advantages:
- Simplification of the protocol
- A downloader need to have very-very little knowledge of the PDTB2 protocol. It just needs to send the keynames to the server.
- We will be able of supporting a future PDTB3 or update PDTB2 without modifying the protocol
- Proof of concept and testing will be much easier (the daisy-online protocol is only responsible for transfering the KXO file).
- The specification of the daisy-only-protocol and PDTB2 will be more separate, which will reduce the chance of any problems.

Disadvatages:
- anyone ?

Geoff: Since the KXOs have to be different for each reading system, I don't think it would be a good idea to store them as resources.  Some services will just be providing files from a regular fileserver; adding a hook to serve a KXO from a script would be a burden on them.

However, it might be a good idea to move the keyRing from the call to getKXO to the readingSystemAttributes.  It's as logical a place, and it makes the operation much simpler.  The only problem is that it would get sent every session, while we're expecting calls to getKXO to be rare.

Mark: I think the key ring belongs to the readingSystemAttributes. For the KXO scenario this does not matter but it does in a dynamic AO scenario. Here is the example:

-Reading system declares it supports PDTB2 and has a KeyRing consisting of ManufacturerA, ModelB, Instance111 and UserKeyLibrary1.
-Reading system requests a PDTB2 book.
-The content provider recognizes a PDTB2 book is requested, selects an approved Key from the KeyRing and generates the necessary AO file before sending the contents.

While reading the section 4.4.4.3 Accessing PDTB2 Content, my first reaction was why isn't there a mechanism to let the user know he will not be able to access the book contents prior to download? It seems to be a waste of bandwidth and time. Also " The key names provided can be some or all of the symmetric keys or public/private keypairs the Reading System supports." I don't believe symmetric keys can be used to encrypt KXOs. The only symmetric keys in PDTB2 are the content (audio/text) keys unique to each book.

Geoff: Are we expecting there to be dynamic AOs as well?  I was working under the assumption that an AO for a book would be effectively static, a part of the fileset.  Otherwise, why would you need KXOs if you're always going to use a key that the reading system already has?

The mechanism to prevent the reading system from downloading a book it cannot access would be to download just the AO, find out the key(s) needed to decrypt it, then call getKXO on the key name(s).  The service can then return either the KXO(s) or a fault.  Or, if the keyRing gets moved to the readingSystemAttributes, the service can choose not to offer content the reading system is not permitted to access (unless the content has already been issued to the user on another reading system).

I'm not sure where it specifies in PDTB2 that KXOs must be encrypted with public keys; is it in one of the referenced specs?  The key exchange procedure should work with either symmetric or asymmetric keys.  I suppose you could use symmetric encryption for everything if you really wanted to.

jelle:You are completely right. This indeed would require a seperate script outside of the soap scope.

So here's an idea:
Why don't we use a getBlob for this purpose...

I'll start a seperate mail thread to discuss this.

kenny: If we remove the getKeyExchangeObject operation, move the KXO into the resources for the protected content, and move the keyring into the readingSystemAttributes type, we save an operation, but we place additional onus on service implementers to dynamically make KXO(s) available through their file servers via some form of a script. Furthermore, the keyring will need to be sent to the Service in each session through the setReadingSystemAttributes operation (as Geoff points out), whereas the retrieval of a KXO is envisaged to be a far more infrequent function of the spec.

My understanding thus far on the nature and purpose of a KXO is:

A. It contains asymmetric key pair(s) used to lock an authorisation object.

B. It is itself locked by the public key portion of an asymmetric key pair that belongs to a Reading System. (manufacturer, model, instance ...)

c. The Reading System unlocks the KXO with its private key, extracts the public/private key pair used to lock the authorisation object, and unlocks the authorisation object. Section 5.2 of the PDTB2 spec states the following:

"

If the reading system has a key identified in the key exchange object, it must be able to use that key to decode and use an authorization object associated with specific content. The reading system should store the key obtained from the key exchange object for subsequent use. Non-networked reading systems need not store the public key portion of the key pair, since they have no further use for it.

"

In terms of a dynamic authorisation object, instead of being encrypted with the public key portion of an asymmetric key pair stored in a KXO, it could very well be encrypted with the public key portion of an asymmetric key pair belonging to a Reading System (bypassing a KXO altogether). The only purpose of a KXO then is to allow  a Service vendor the flexibility to use independent asymmetric key pair(s) to secure the authorisation object.

Neale, Mark and Alex, is the theoretical proposition above correct, or did the PDTB2 wg envisage a purpose for a KXO that I have missed entirely in my rudimentary analysis above?

On the basis of what I have read thus far about symmetric and asymmetric encryption, symmetric encryption is significantly less expensive than asymmetric encryption, and thus is used to secure the actual content, whereas asymmetric encryption is used to secure the symmetric key itself. An example of this principle in action is https (through ssl/tls).

I am not sure how much of my rather theoretical understanding is correct; I will let the expirts decide! My thought process for now is more inclined towards keeping the pdtb2 support as is in the spec i.e.:

a. A getKeyExchangeObject operation to retrieve a KXO on the basis of the key names supplied in the key ring parameter to this operation.

b. An authorisation object bundled with the rest of the resources for a piece of content.

c. As geoff pointed out, if a Reading System downloaded an authorisation object that it could not unlock, it would request a key exchange object containing the asymmetric key pair used to secure the AO through a call to the getKeyExchangeObject operation.

We could always move the retrieval of KXOs to an out-of-band mechanism as we have the exchange of trusted public keys.

#### Suggestions ####

  * Suggestion 1: Get rid of the getKeyExchangeObject operation, move keyring to readingSystemAttributes, and bundle kxo with content resources
  * Suggestion 2: Move keyring to readingSystemAttributes, retain the simplified getKeyExchangeObject operation
  * Suggestion 3: Make the retrieval of KXOs out-of-band, drop the getKeyExchangeObject operation
  * Suggestion 4: Replace the getKeyExchangeObject operation with a getBlob operation
  * Suggestion 5: Leave the pdtb2 support in the spec as is

#### Discussion on the telecon ####

Geoff: According to mark, suggestion 2 is the only way of supporting both key exchange and dynamic authorisation objects.

markus: This is a bug fix then, right?

Geoff: Its more of a feature as it would allow both methods of securing an authorisation object i.e. with keys in a KXO, or keys in an RS's keyring.

Markus: If everyone is happy with this, I suggest we post our decision to move forward with suggestion 2 to the list, and ask for any objections.

(The group decided to move forward with suggestion 2. kenny to post this decision to the list and ask for any objections.)

### Suggestion to replace getKeyExchangeObject, getBookmarks and setBookmarks operations with a generic getBlob operation ###

#### Discussion on the list ####

jelle: I would like to discuss the removal of these three functions, and replace them by the getBlob and setBlob.

I raised this issue in the past, but I would like to open this discussion again.

What are my worries over these 3 functions ?
These functions do actually transport data that is being defined in other specifications.
For this reason we import "http://www.daisy.org/z3986/2005/bookmark/"
and "http://www.daisy.org/DRM/2005/KeyExchange"
These last weeks (or even months) we have been busy updating these specifications so they could be imported correctly and nicely.
I think that we should keep focus on the daisy-online specification and we should not rewrite these specifications.
Although I understand and agree that including these specifications is the most beautiful solution, I think it is not the best.

I foresee problems like:
if the bookmark or pdtb2 working group makes a change to their specification, we could be in for some (serious) problems.
- If they would make an error in the spec, it might mean that the daisy-online spec would also have errors.
- "version control" of our specification is out of our hands. We can try to fix our specification, but external working groups can still modify it.

So how do the getBlob and setBlob replace these functions ?
getBookmarks(id) => getBlob( id , BOOKMARK )
getKeyEchangeObject(id) => getBlob( id , KXO ) The return value of a getBlob would be a base64 encoded XML string.

Forget the following immediatly: It could even make the removed "getResource" function available again (eg. uri="blob://ncc.html" which would make the client call getBlob(id, "ncc.html") )

> geoff: get/setBlob is way out of scope.  It's far too complicated, and it could lead to serious interoperability and security problems if not properly specified.  We do not have to time to properly specify this.  If we include this in the spec, it could set us back months.  Seriously.

Frankly, we've spent enough time as it is.  I say we keep to the schedule.  If there's something we can't implement, then we cut it entirely rather than look for a new way.  Let's focus on getting this done, which means focusing on what we **can** get done (and tested).

Johan: I agree with Geoff.

#### discussion on the telecon ####

Jelle: I see benefits in us adopting the getBlob/setBlob approach because of two reasons:
  * A download-only Daisy Online client does not need to know the specifics of either the bookmark xsd or the KXO xsd.
  * support for future versions of the pdtb2 or bookmark specs will be seemless.

I acknowledge that we are a long way into the getKeyExchangeObject approach. To my mind, the getBlob/setBlob approach makes things easier.

Geoff: KXO is already in an xml format. Its well defined. We just need to simply import it. There's only one bug in it currently, and thats going to be fixed in time. I don't think we need to go the way of opaque binary objects at this stage.


jelle: We are importing a lot of xsds, and my concern is that we will need to make each of them work individually. I don't know how we will accomodate future versions of pdtb2.

Geoff: For version 1 of the Daisy Online spec, we only need to support particular versions of specs that are our dependencies i.e. bookmark, pdtb2. this satisfies our requirements e.g. exchanging keys ... Support for a single version of these specs should be sufficient for now.

Johan: manufacturers may have their own internal representations of bookmarks for example. the getBlob/setblob approach may cause a lot of interoperability issues.

geoff: It will take us a lot of time to specify the getBlob/setblob operations adequately.

Markus: I understand and appreciate the rationale behind the getblob/setblob  operations. I have seen this problem several times with w3c specs. the moment a spec that is a dependency changes, the dependent spec needs to change as well to support the new version of the spec that is a dependency. I suggest this be flagged in the issue tracker as an issue that is an enhancement, and needs to be looked at in the next version.


(The group unanimously agreed that Jelle's suggestion was a good idea, and should be looked at in the next version of the spec. Geoff to log an issue in the issue tracker and mark it  as an enhancement for the next version.)

### Error in KXO.xsd: EncryptedKey not a valid child of 

&lt;Keys&gt;

 ###

#### Discussion on the list ####

> Johan: I believe I found an error in the Key exchange object example
(http://www.daisy.org/projects/pdtb/daisy-pdtb-spec.html#s9.4) when I was trying to implement the function in my demo service. In the example, a symmetric key is inserted as a 

&lt;xe:EncryptedKey&gt;

 child element in the 

&lt;Keys&gt;

 element. I run the schema and the example through a schema validator (http://www.xmlme.com/Validator.aspx) which claims that 'EncryptedKey' is an invalid child of 'Keys'.

Should we report this to the PDTB2 people?

It would also be great if we could ask Neale if he could provide us with a sample kxo that would illustrate the structure of the kxo for the sample pdtb2 content he sent us. As of now I don't know where to put the encrypted key or in what format (plain/binary/base64) it should be. So far I've managed to find out that Neale provided us with a public-private key pair and that the private key must be used to decrypt the information in the authorization object.

What do you guys think?

mark: I will let Neal post an NLS KXO, but here is a KXO for one of our players from another company that uses PDTB2:
<?xml version="1.0" encoding="UTF-8" standalone="no" ?> <KeyExchange xmlns="http://www.daisy.org/DRM/2005/KeyExchange" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:xe="http://www.w3.org/2000/09/xmldenc#">
> 

&lt;Issuer uid="DAISY.us-acme"&gt;

ACME Corporation

&lt;/Issuer&gt;


> 

&lt;Keys&gt;


> > 

&lt;ds:KeyInfo&gt;


> > > 

&lt;ds:KeyName&gt;

DAISY.ca-humanware.serial-95-1303-000196

&lt;/ds:KeyName&gt;



> > 

&lt;/ds:KeyInfo&gt;


> > 

&lt;ds:KeyPair&gt;


> > > 

&lt;ds:KeyInfo&gt;


> > > > 

&lt;ds:KeyValue&gt;


> > > > > 

&lt;ds:RSAKeyValue&gt;


> > > > > > 

&lt;ds:Modulus&gt;

rIuqgqWUkDFcPyXRalCJ1IX6uZBLlnT25Njix1MJ6U/vFgapyjkJW+UiziiK9tx2vAJgi18/nFKjyTeRdW3b//inLnnS0jHElBBw9R32jF57NtddGU7ak6GWkdiUfv/FaBPAFYLOZD1T9wzJCXgbaR5+vALI8iAVgRfiga+rqU8=

&lt;/ds:Modulus&gt;


> > > > > > 

&lt;ds:Exponent&gt;

AQAB

&lt;/ds:Exponent&gt;



> > > > > 

&lt;/ds:RSAKeyValue&gt;


> > > > > 

&lt;ds:KeyName&gt;

DAISY.us-acme.userkey

&lt;/ds:KeyName&gt;



> > > > 

&lt;/ds:KeyValue&gt;



> > > 

&lt;/ds:KeyInfo&gt;


> > > 

&lt;xe:EncryptedKey&gt;


> > > > 

&lt;xe:CipherData&gt;


> > > > > 

&lt;xe:CipherValue&gt;

e3wbHErB6r/5PlHw6OdYOKplRC9LeN6ppSRX4UowGh3T0vuCxNE5+x1UwR1fG1wTfXMb/PhVl3kP9nLIFWiOTfEXU9otCFezXGc/UvQ4R7L2/eQhO+4SCi04KX6Vl0vx2pWgoYn3NR4bL7Vk29ehp6o1bUOSr0a4MIfJ8wDWkt+hPjgLs5kvwI0KxvA7LSokC8ZhC6BB7QBGLpgn133WB2dlpOoz/WYR9irg48cNVc7Ii/FratVU0NYMOPswuQDpBLx9S28O+WAYMQJEEEpryImi48MnmpTRoeyInPYP/n/bFrUZAch7s9wzgqao52UUdcz+I9OnSPmJdrSO+Ta4+4ugcbu/J548IA/JxLPsiRw7ApCv1+vjPgkYdjWU6leXjHWVeY4eLF9sbZMVpgf2KpdETsZAmuw1svq+tOSPR4BtGFggF1eioZfVJfjDFPH8EW3qsdiM2YBtPSa4KHMCUaKf2/xLF9XA9k2NWJzKDKKIDwWAYhvl3n6Lm7ms5ArrjME0oo2QsK2FxPCP0yJPW+xwqWjIOgH3aQrNb3Txaesr1ZVlFIx/aRk9Tl7EdRIGyjObf3wwqKMyQC3CBRnv/smH+8L+rtjvCMc3i2dGOF6z5LX+LfTA3c+2nDGLOTEViX1cPjkt4KmUyCopXuyYMvSkRkXns3CqG6ll/RDTXsRXtCaxBpCFAYJI+PdX75x8N7oZ213RYUo32fWwLYdalyDT15yRLCuWXPH0fIWr2eSQwtqBnNJBlSpADRV3bf1un+E3acKuMHhaEfDN3d4dQf+PspcuB7ncvd91VRPdspKGPHwt3zVsF3owF9D4La3pmlvbKdZiqGjPfg4hAE9x0B7IQJYRlo1AnD9Jv6S1/ozwycgXJbvPgUvFi3WOpicH4FNqQfvtp90lQjQ5oWBgKsZa8fpaIsIV89aa7Oa4PNFYxo0h8ApyZNVkdvxgdqWcYKa0PWD2ZrH4pY64nPipt78lXl8OfycgxieimZtP3UEDrlxPNk3Z3305vUpliQ+b

&lt;/xe:CipherValue&gt;



> > > > 

&lt;/xe:CipherData&gt;


> > > > 

&lt;xe:CarriedKeyName&gt;

DAISY.us-acme.userkey

&lt;/xe:CarriedKeyName&gt;



> > > 

&lt;/xe:EncryptedKey&gt;



> > 

&lt;/ds:KeyPair&gt;



> 

&lt;/Keys&gt;





Unknown end tag for &lt;/KeyExchange&gt;



Johan: If I understand this correctly the values of 

&lt;ds:Modulus&gt;

, 

&lt;ds:Exponent&gt;

, and 

&lt;xe:CipherData&gt;

 are base64 representations of data encrypted with the public  'DAISY.ca-humanware.serial-95-1303-000196'
key. Is this correct?

Mark: Almost, they are all base64 representations but only xe:CipherData is encrypted with the public 'DAISY.ca-humanware.serial-95-1303-000196'. The modulus and exponent are the public part of the key, so there is no need for encryption. In fact you can opt not to list the keypairs and stick to only encrypted key like this:



&lt;Keys&gt;


> 

&lt;ds:KeyInfo&gt;


> > 

&lt;ds:KeyName&gt;

DAISY.ca-humanware.serial-95-1303-003005

&lt;/ds:KeyName&gt;



> 

&lt;/ds:KeyInfo&gt;


> 

&lt;xe:EncryptedKey&gt;


> > 

&lt;xe:CipherData&gt;


> > 

&lt;xe:CipherValue&gt;

hYHGZV....

&lt;/xe:CipherValue&gt;


> > 

&lt;/xe:CipherData&gt;


> > 

&lt;xe:CarriedKeyName&gt;

DAISY.us-acme.userkey1

&lt;/xe:CarriedKeyName&gt;



> 

&lt;/xe:EncryptedKey&gt;


> <!-- If you would like to transport more than one key, you could add additionnal xe:EncryptedKey --> 

&lt;/Keys&gt;



Johan: Thanks for the clarification. This simple response is what I think every service provider should send to reading systems when it requests a key exchange object, but I'm pretty sure that the schema doesn't allow an xe:EncryptedKey element as a child in the Keys element. Please correct me if I'm wrong. At least my framework doesn't allow me to insert a xe:EncryptedKey here.

mark: I don't remember how this is allowed but I do know NLS uses (or used to) xe:EncryptedKey as a child of the Keys.

Alex: here is an example here, where "xe:EncryptedKey" element" is a child of the "Keys" element :
http://www.daisy.org/projects/pdtb/daisy-pdtb-spec.html#s9.4

But in the schema ( http://www.daisy.org/projects/pdtb/daisy-pdtb-spec.html#s9.2 ), I read :



&lt;xs:complexType name="KeysType" &gt;


> 

&lt;xs:annotation&gt;


> > 

&lt;xs:documentation&gt;


> > > Keys = Set of keys secured using same encryption key
> > > Keys (ds:KeyInfo, (xe:EncryptedKey | KeyPair)+)

> > 

&lt;/xs:documentation&gt;



> 

&lt;/xs:annotation&gt;


> 

&lt;xs:sequence&gt;


> > 

&lt;xs:element ref="ds:KeyInfo" /&gt;


> > 

&lt;xs:choice maxOccurs="unbounded"&gt;


> > > 

&lt;xs:element name="KeyPair" type="dkx:KeyPairType " /&gt;


> > > 

&lt;xs:element name="UAK" type="dkx:UAKType"  /&gt;



> > 

&lt;/xs:choice&gt;



> 

&lt;/xs:sequence&gt;




&lt;/xs:complexType&gt;



It seems that "xe:EncryptedKey" is missing in the schema...

#### Discussion on the telecon ####

Geoff: It is not an error in the xsd but one of Mark's examples.

Johan: encryptedKey was a child of the keys element in the examples. This is not correct as per the xsd. We should highlight this for other implementers.

Geoff: lets report this to the pdtb2 folks and leave it to them. Lets create our own example of the key exchange object.

Kenny: Are we sure that the problem is with the examples and not the xsd?

Geoff: From our point of view, it does not matter. If the kxo xsd changes, it does not impact us. James has already suggested that the regular expression problem should be resolved by feb 15. This particular problem should not be a showstopper.

### Suggestion for a Cosmetic change to Section 4.4.3 ###

kenny: Section 4.4.3 states:
"
...
Each contentItem in a contentList has an optional lastModifiedDate attribute that indicates that last time the Content was modified. A Reading Systems can use this information to determine if the Content on the Service has been updated since the last time it was accessed.
"

Proposal: modify verbiage to eliminate typos.

(the group agreed. kenny to make the change.)

> ### Spec update progress ###

  1. documentation including the wsdl and xsd files.
  1. systems testing and test suite documents.
  1. conformance report.

### Test implementation update ###

Where are we at?

### Test suite Progress ###

#### [Test Suite](http://code.google.com/p/daisy-online-delivery/wiki/tsg_test_suite) ####

#### [Systems Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolSystemTestingTestCases) ####

Geoff: two things I want to find out:
  1. Are the test cases in the systems testing document sufficient for the organizations?
  1. What organizations will participate in these tests?

## [Change Log](http://code.google.com/p/daisy-online-delivery/wiki/ChangeLog) ##

