## Intro ##

This page records all tweaks that have been implemented in various implementations to successfully consume the normative WSDL and XSD files for the auto generation of native programming constructs in different toolkits.

## Microsoft toolkit (svcutil, xsd.exe, wsdl.exe) ##

This was done using Microsoft WCF tool svcutil.exe version 3.0.4506.2152.
It was done on modified local copies of the wsdl and xsd.
This is the command that was used:

svcutil.exe xmldsig.xsd xmlenc.xsd kxo.xsd bookmark-2005-1.xsd dc.xsd do-types-10.xsd do-wsdl-10.wsdl /language:cs /out:proxy.cs /config:test\_application.exe.config /ser:xmlserializer /fault

Here are the modifications we made:

**do-wsdl-10.wsdl**

- There are still issues with 'getBookmarks', 'setBookmarks' and 'getKeyExchangeObject'. No solution have been tested yet.

- In the getContentList operation, change **"xs:NMTOKEN"** for **"xs:string"**:
> Before:
> > 

&lt;xs:element name="getContentList"&gt;


> > > 

&lt;xs:complexType&gt;


> > > > 

&lt;xs:sequence&gt;


> > > > > <xs:element minOccurs="1" maxOccurs="1" name="id" **type="xs:NMTOKEN"**>
> > > > > 

Unknown end tag for &lt;/element&gt;



> > > > 

&lt;/xs:sequence&gt;



> > > 

&lt;/xs:complexType&gt;



> > 

&lt;/xs:element&gt;




> After:
> > 

&lt;xs:element name="getContentList"&gt;


> > > 

&lt;xs:complexType&gt;


> > > > 

&lt;xs:sequence&gt;


> > > > > <xs:element minOccurs="1" maxOccurs="1" name="id" **type="xs:string"**>
> > > > > 

Unknown end tag for &lt;/element&gt;



> > > > 

&lt;/xs:sequence&gt;



> > > 

&lt;/xs:complexType&gt;



> > 

&lt;/xs:element&gt;




**do-xsd-10.xsd**

- For 'annoucements', 'userResponse' and 'read' element: move minOccurs and maxOccurs from <xs:element ...> to <xs:sequence ...>. Note that in general, this modification does not result in the same data structure. But in the cases we are having problems with, data structure is intact.


> Before:
> > 

&lt;xs:element name="announcements"&gt;


> > > 

&lt;xs:complexType&gt;


> > > > 

&lt;xs:sequence&gt;


> > > > > <xs:element name="announcement" **minOccurs="0" maxOccurs="unbounded"**>
> > > > > 

Unknown end tag for &lt;/element&gt;



> > > > 

&lt;/xs:sequence&gt;



> > > 

&lt;/xs:complexType&gt;



> > 

&lt;/xs:element&gt;


> > 

&lt;xs:element name="userResponses"&gt;


> > > 

&lt;xs:complexType&gt;


> > > > 

&lt;xs:sequence&gt;


> > > > > <xs:element name="userResponse" **minOccurs="1" maxOccurs="unbounded"**>
> > > > > 

Unknown end tag for &lt;/element&gt;



> > > > 

&lt;/xs:sequence&gt;



> > > 

&lt;/xs:complexType&gt;



> > 

&lt;/xs:element&gt;


> > 

&lt;xs:element name="read"&gt;


> > > 

&lt;xs:complexType&gt;


> > > > 

&lt;xs:sequence&gt;


> > > > > <xs:element ref="item" **minOccurs="0" maxOccurs="unbounded"**/>

> > > > 

&lt;/xs:sequence&gt;



> > > 

&lt;/xs:complexType&gt;



> > 

&lt;/xs:element&gt;




> After:
> > 

&lt;xs:element name="announcements"&gt;


> > > 

&lt;xs:complexType&gt;


> > > > <xs:sequence **minOccurs="0" maxOccurs="unbounded"**>
> > > > > 

&lt;xs:element name="announcement"&gt;


> > > > > 

&lt;/xs:element&gt;



> > > > 

Unknown end tag for &lt;/sequence&gt;



> > > 

&lt;/xs:complexType&gt;



> > 

&lt;/xs:element&gt;


> > 

&lt;xs:element name="userResponses"&gt;


> > > 

&lt;xs:complexType&gt;


> > > > <xs:sequence **minOccurs="1" maxOccurs="unbounded"**>
> > > > > 

&lt;xs:element name="userResponse"&gt;


> > > > > 

&lt;/xs:element&gt;



> > > > 

Unknown end tag for &lt;/sequence&gt;



> > > 

&lt;/xs:complexType&gt;



> > 

&lt;/xs:element&gt;


> > 

&lt;xs:element name="read"&gt;


> > > 

&lt;xs:complexType&gt;


> > > > <xs:sequence **minOccurs="0" maxOccurs="unbounded"**>
> > > > > 

&lt;xs:element ref="item"/&gt;



> > > > 

Unknown end tag for &lt;/sequence&gt;



> > > 

&lt;/xs:complexType&gt;



> > 

&lt;/xs:element&gt;

