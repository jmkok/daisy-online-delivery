<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:db="http://docbook.org/ns/docbook" version="2.0"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:daisy="http://www.daisy.org/ns/daisy-online/#"
	xpath-default-namespace="http://www.w3.org/2001/XMLSchema"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="db"
	xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
	xmlns:xi="http://www.w3.org/2001/XInclude">
	<!--
		Transform a docbook instance to a docbook instance, inserting data
		from a XSD doc in a predefined slot.
		
		The generated xml uses a predictable id generation, so that its members can be referenced safely 
		in surrounding parts of the host document
	-->
	
	<xsl:output method="xml" omit-xml-declaration="no" indent="no"/>

	<!-- import online types schema -->
	<xsl:variable name="xsd" select="document('../../../src/do-types-10.xsd')"/>
	<!-- import bookmark schema -->
	<xsl:variable name="bookmark" select="document('../../../src/bookmark-2005-1.xsd')"/>
	<!-- import key exchange schema -->
	<xsl:variable name="kxo" select="document('../../../src/kxo.xsd')"/>
	<!-- import sample file -->
	<xsl:variable name="samplesIndex" select="document('../../../src/samples-index.xml')"/>
	<!-- import wsdl -->
	<xsl:variable name="wsdl" select="document('../../../src/do-wsdl-10.wsdl')"/>
		
	<!-- list of types - prevents processing of general-use elements in xsd -->
	
	<xsl:variable name="typeList">|announcements|bookmarkSet|contentList|contentMetadata|KeyExchange|questions|readingSystemAttributes|resources|serviceAttributes|userResponses|read|keyRing|</xsl:variable>

	<xsl:template match="db:chapter[@xml:id='typeReference']">
		<xsl:element name="db:chapter">
			<xsl:attribute name="xml:id">typeReference</xsl:attribute>
			<xsl:attribute name="conformance">normative</xsl:attribute>
			<xsl:element name="db:title">Type Reference</xsl:element>
			
			<!-- get the top-level elements in the xsd (aka types) -->
			<xsl:for-each select="$xsd/xs:schema/xs:element|$bookmark/xs:schema/xs:element|$kxo/xs:schema/xs:element">
				<xsl:sort select="@name" case-order="lower-first"/>
				<xsl:if test="contains($typeList, concat('|',@name,'|'))">
					<xsl:element name="db:section">
						<xsl:attribute name="xml:id" select="concat('tp_',@name)"/>
						<xsl:attribute name="xreflabel" select="@name"/>
						
						<xsl:element name="db:title">
							<xsl:text>The </xsl:text>
							<xsl:element name="db:type">
								<xsl:value-of select="@name"/>
							</xsl:element>
							<xsl:text> Type</xsl:text>
						</xsl:element>
						
						<xsl:choose>
							<xsl:when test="child::xs:annotation">
								<xsl:copy-of select="child::xs:annotation/xs:documentation/db:*"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:element name="db:para">...</xsl:element>
							</xsl:otherwise>
						</xsl:choose>
						
							<xsl:call-template name="addUsedBy">
								
							</xsl:call-template>
							
							
							<xsl:call-template name="addContentModel">
								<xsl:with-param name="isType">true</xsl:with-param>
							</xsl:call-template>
							
							<xsl:if test="xs:complexType/xs:attribute">
								<xsl:call-template name="addAttributeInfo"/>
							</xsl:if>
						
						<!-- check if there are samples (0-n per type), if so, include -->
						<xsl:variable name="type" select="@name" />
						<xsl:choose>
							<xsl:when test="count($samplesIndex/daisy:samples/daisy:type[@name=$type]/daisy:sample) > 0">
								<db:section xml:id="{$type}-examples">
									<db:title><xsl:value-of select="$type"/> Examples</db:title>
								<xsl:for-each select="$samplesIndex/daisy:samples/daisy:type[@name=$type]/daisy:sample">
									<db:example> <db:title><xsl:value-of select="@title"/></db:title>
									<xsl:if test="./daisy:annotation/db:*">
										<xsl:copy-of select="./daisy:annotation/db:*" />
									</xsl:if>
									<db:programlisting><xsl:element name="xi:include">
										<xsl:attribute name="href" select="resolve-uri(@src,base-uri())" />
										<xsl:attribute name="parse">text</xsl:attribute>
									</xsl:element>
									</db:programlisting>
									</db:example>
								</xsl:for-each>
									</db:section>
							</xsl:when>	
							<xsl:otherwise>
								<xsl:message>Warning: no type sample(s) found for <xsl:value-of select="$type" /></xsl:message>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:element>
				</xsl:if>
			</xsl:for-each>
			
			<!-- generate documentation for all of the elements referenced in the schema -->
			<xsl:element name="db:section">
				<xsl:attribute name="xml:id">tp_general_elementReference</xsl:attribute>
				<xsl:element name="db:title">Element Reference</xsl:element>
				<xsl:call-template name="generateElementDocumentation"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<!-- adds info on which operations passes or returns the primary types -->
	<xsl:template name="addUsedBy">
		<xsl:variable name="curTypeName" select="current()/@name"/>
		
			<xsl:element name="db:bridgehead">
				<xsl:text>Used By</xsl:text>
			</xsl:element>
			
			<xsl:element name="db:para">
				<xsl:variable name="wsdl-elements" as="element()*" select="$wsdl/wsdl:definitions/wsdl:types/xs:schema/xs:element"/>
				
				<xsl:for-each select="$wsdl-elements">
					<xsl:variable name="p" select="position()"/>
					<!-- curWsdlXsElement is the wsdl xsd wrapper named a la getServiceAttributes and getServiceAttributesResponse -->
					<xsl:variable name="curWsdlXsElement" select="$wsdl-elements[$p]" as="element()"/>
					<!-- if curWsdlXsElement has a descendant xs:element with a ref that matches curTypeName except prefix, then a match -->
					<xsl:if test="$curWsdlXsElement//xs:element/@ref eq  $curTypeName or $curTypeName eq substring-after($curWsdlXsElement//xs:element/@ref,':')">
							<xsl:choose>
								<xsl:when test="contains($curWsdlXsElement/@name, 'Response')">
									<xsl:element name="db:code">
										<xsl:element name="db:xref">
											<xsl:attribute name="linkend">
												<xsl:value-of select="concat('op_',replace($curWsdlXsElement/@name,'Response',''))"/>
											</xsl:attribute>									
										</xsl:element>
									</xsl:element>
									<xsl:text> (response)</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:element name="db:code">
										<xsl:element name="db:xref">
											<xsl:attribute name="linkend"><xsl:value-of select="concat('op_',$curWsdlXsElement/@name)"/></xsl:attribute>
										</xsl:element>
									</xsl:element>
									<xsl:text> (parameter)</xsl:text>
								</xsl:otherwise>
							</xsl:choose>														
					</xsl:if>					
				</xsl:for-each>
			</xsl:element>	
	</xsl:template>	
	
	<!-- adds the content model section for the primary types -->
		
	<xsl:template name="addContentModel">
		<xsl:param name="isType" as="xs:boolean"/>
		
			<xsl:element name="db:bridgehead">
				<xsl:text>Content Model</xsl:text>
			</xsl:element>
			
				<xsl:element name="db:para">
					<xsl:call-template name="generateCM">
						<xsl:with-param name="thisType" select="."/>
					</xsl:call-template>
				</xsl:element>
				<xsl:if test=".//xs:any[count(ancestor::xs:element)=1]">
					<xsl:element name="db:para">
						<xsl:text>This element is extensible.</xsl:text>
					</xsl:element>
				</xsl:if>
	</xsl:template>
	
	
	
	<!-- 
			GENERATE A DTD-LIKE CONTENT MODEL
	-->
	
	<xsl:template name="generateCM">
		<xsl:param name="thisType"/>
		
		<xsl:choose>
			<!-- check if element is empty (no child elements and not a group) -->
			<xsl:when test="not($thisType/child::*[not(self::xs:attribute)]) and not(self::xs:group)">
				<xsl:choose>
					<!-- text only when an empty complexType and allows mixed content -->
					<xsl:when test="self::xs:complexType and @mixed='true'">text only</xsl:when>
					<xsl:otherwise>
						<!-- use the type for the allowed value --> 
						<xsl:value-of select="@type"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			
			<xsl:otherwise>
				<!-- process each child accordingly -->
				<xsl:for-each select="$thisType/child::*[not(xs:any)]">
					<xsl:choose>
						<xsl:when test="self::xs:sequence or self::xs:choice">
							<xsl:call-template name="processCMGroup"/>
						</xsl:when>
						<xsl:when test="self::xs:element">
							<xsl:call-template name="addCMElement"/>
						</xsl:when>
						<xsl:when test="self::xs:complexType">
							<xsl:call-template name="generateCM">
								<xsl:with-param name="thisType" select="."/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="self::xs:simpleType or self::xs:complexContent">
							<xsl:call-template name="processComplexSimple"/>
						</xsl:when>
						<xsl:when test="self::xs:annotation"/>
						<xsl:when test="self::xs:any"/>
						<xsl:when test="self::xs:attribute"/>
						<xsl:otherwise>
							UNKNOWN: ###<xsl:value-of select="local-name()"/>###
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	
	
	<!-- 
			CONTENT MODEL PROCESSING OPERATIONS
	-->
	
	<!-- wrap groups in parentheses -->
	<xsl:template name="processCMGroup">
		
		<xsl:text> ( </xsl:text>
			<xsl:call-template name="generateCM">
				<xsl:with-param name="thisType" select="."/>
			</xsl:call-template>
		<xsl:text> )</xsl:text>
		
		<xsl:call-template name="addModifier"/>
		<xsl:text> </xsl:text>
		<xsl:call-template name="addJoiner"/>
	
	</xsl:template>
	
	
	<!-- add an element to the content model -->
	<xsl:template name="addCMElement">
		
		<xsl:variable name="name" select="@name|@ref"/>
		
		<xsl:call-template name="addLink">
			<xsl:with-param name="name" select="$name"/>
		</xsl:call-template>
		
		<xsl:call-template name="addModifier"/>
		
		<xsl:call-template name="addJoiner"/>
	</xsl:template>
	
	
	
	<!-- adds an internal link or an href for elements from other namespaces --> 
	<xsl:template name="addLink">
		<xsl:param name="name"/>
		
		<xsl:element name="db:link">
			<xsl:choose>
				<xsl:when test="contains($name, ':')
							or (ancestor::xs:schema[@id='bookmark-2005-1'] and not($name='bookmarkSet'))
							or (ancestor::xs:schema[@id='KeyExchange'] and not($name='KeyExchange'))">
					<xsl:variable name="prefix" select="substring-before($name, ':')"/>
					<xsl:variable name="localname">
						<xsl:choose>
							<xsl:when test="contains($name, ':')">
								<xsl:value-of select="substring-after($name, ':')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$name"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					
					<xsl:attribute name="xlink:href">
						<xsl:choose>
							<xsl:when test="ancestor::xs:schema[@id='bookmark-2005-1']">
								<xsl:text>http://www.daisy.org/z3986/2005/Z3986-2005.html#</xsl:text>
								<xsl:choose>
									<xsl:when test="$name = 'title'">li_433</xsl:when>
									<xsl:when test="$name = 'uid'">li_439</xsl:when>
									<xsl:when test="$name = 'lastmark'">li_440</xsl:when>
									<xsl:when test="$name = 'bookmark'">li_447</xsl:when>
									<xsl:when test="$name = 'hilite'">li_450</xsl:when>
									<xsl:otherwise>Bkmk</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="ancestor::xs:schema[@id='KeyExchange']">
								<xsl:text>http://www.daisy.org/projects/pdtb/daisy-pdtb-spec.html#s6.1</xsl:text>
							</xsl:when>
							<xsl:when test="$prefix='dc'">
								<xsl:text>http://dublincore.org/documents/dces/#</xsl:text>
								<xsl:value-of select="$localname"/>
							</xsl:when>
							<xsl:when test="$prefix='ds'">
								<xsl:text>http://www.w3.org/TR/2002/REC-xmldsig-core-20020212/#sec-</xsl:text>
								<xsl:value-of select="$localname"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>### UNKNOWN NAMESPACE PREFIX : </xsl:text>
								<xsl:value-of select="$prefix"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="linkend">
						<xsl:value-of select="concat('tp_',$name)"/>
						<xsl:if test="not(@ref) and count(ancestor::xs:schema//xs:element[@name=$name]) &gt; 1">
							<xsl:variable name="ecnt" select="count(preceding::xs:element[@name=$name])"/>
							<xsl:choose>
								<xsl:when test="$ecnt = 0"/>
								<xsl:otherwise>
									<xsl:value-of select="$ecnt"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:element name="db:type">
				<xsl:value-of select="$name"/>
			</xsl:element>
		</xsl:element>
		
	</xsl:template>
	
	
	
	<!-- contents of complexcontent and simplecontent are handled the same way -->
	<xsl:template name="processComplexSimple">
		
		<xsl:choose>
			<!-- if referencing a group grab the contents of the group and process -->
			<xsl:when test="child::xs:group">
				<xsl:variable name="grpRef" select="child::xs:group/@ref"/>
				<xsl:call-template name="generateCM">
					<xsl:with-param name="thisType" select="ancestor::xs:schema/xs:group[@name=$grpRef]"/>
				</xsl:call-template>
			</xsl:when>
			<!-- add a header depending on the type of restriction -->
			<xsl:when test="child::xs:restriction/*[not(self::xs:element)]">
				<xsl:choose>
					<xsl:when test="ancestor::xs:attribute">
						<xsl:choose>
							<xsl:when test="child::xs:restriction/xs:enumeration">
								<xsl:text>Enumeration:</xsl:text>
							</xsl:when>
							<xsl:when test="child::xs:restriction/xs:minInclusive|child::xs:restriction/xs:maxInclusive">
								<xsl:text>Integer Set:</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>##unknown##: (</xsl:text>
								<xsl:value-of select="child::xs:restriction/@base"/>
								<xsl:text>)</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<!-- otherwise use the base value -->
				<xsl:value-of select="child::xs:restriction/@base"/>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:if test="child::xs:restriction/*">
			<!-- process the restriction -->
			<xsl:call-template name="processRestriction"/>
		</xsl:if>
	</xsl:template>
	
	
	<!-- runs through children of the restriction and builds the documentation -->
	<xsl:template name="processRestriction">
		<xsl:element name="db:itemizedlist">
			<xsl:for-each select="child::xs:restriction/*">
				<xsl:element name="db:listitem">
					<xsl:element name="db:para">
						<xsl:choose>
							<xsl:when test="self::xs:enumeration">
								<xsl:element name="db:literal">
									<xsl:value-of select="@value"/>
								</xsl:element>
							</xsl:when>
							<xsl:when test="self::xs:minInclusive">
								<xsl:text>minimum value: </xsl:text>
								<xsl:element name="db:literal">
									<xsl:value-of select="@value"/>
								</xsl:element>
							</xsl:when>
							<xsl:when test="self::xs:maxInclusive">
								<xsl:text>maximum value: </xsl:text>
								<xsl:element name="db:literal">
									<xsl:value-of select="@value"/>
								</xsl:element>
							</xsl:when>
						</xsl:choose>
					</xsl:element>
					<xsl:if test="child::xs:annotation">
						<xsl:apply-templates select="child::xs:annotation/xs:documentation/db:*"/>
					</xsl:if>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	
	
	
	<!-- adds the dtd equivalent modifier for an element or group (*,+,?) -->
	<xsl:template name="addModifier">
		<xsl:choose>
			<xsl:when test="(not(@minOccurs) and not(@maxOccurs))
						or (@minOccurs='1' and @maxOccurs='1')
						or (not(@minOccurs) and @maxOccurs='1')
						or (@minOccurs='1' and not(@maxOccurs))"/>
			<xsl:when test="@minOccurs='0' and (not(@maxOccurs) or @maxOccurs='1')">
				<xsl:text>?</xsl:text>
			</xsl:when>
			<xsl:when test="@minOccurs='0' and @maxOccurs='unbounded'">
				<xsl:text>*</xsl:text>
			</xsl:when>
			<xsl:when test="(not(@minOccurs) or @minOccurs='1') and @maxOccurs='unbounded'">
				<xsl:text>+</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>{</xsl:text>
				<xsl:choose>
					<xsl:when test="not(@minOccurs)">
						<xsl:text>1</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@minOccurs"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>, </xsl:text>
				<xsl:choose>
					<xsl:when test="not(@maxOccurs)">
						<xsl:text>1</xsl:text>
					</xsl:when>
					<xsl:when test="@maxOccurs = 'unbounded'">
						<xsl:text>∞</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@maxOccurs"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>}</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	
	<!-- determine if part of a group and add the appropriate joining character -->
	<xsl:template name="addJoiner">
		<xsl:if test="following-sibling::xs:element 
			or following-sibling::xs:complexType[.//xs:element]
			or following-sibling::xs:simpleType
			or following-sibling::xs:complexContent[.//xs:element]
			or following-sibling::xs:simpleContent
			or following-sibling::xs:sequence[.//xs:element]
			or following-sibling::xs:choice[.//xs:element]">
			<xsl:choose>
				<xsl:when test="parent::xs:choice">
					<xsl:text> | </xsl:text>
				</xsl:when>
				<xsl:when test="parent::xs:sequence">
					<xsl:text>, </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<!-- just in case -->
					<xsl:text> #unknown# </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<!-- 
			PROCESS ELEMENTS
	-->
	
	
	<!-- entry function to generate the documentation section for an element -->
	<xsl:template name="generateElementDocumentation">
		
		<!-- iterate over all elements that are not references -->
		<xsl:for-each select="$xsd//element[not(@ref)]">
			<xsl:sort select="@name" case-order="lower-first"/>
			
			<!-- check that the element hasn't already been processed as a type -->
			<xsl:if test="not(contains($typeList, concat('|',@name,'|')))">
				<xsl:variable name="name" select="@name"/>
				
				<!-- change to section to include in toc -->
				<xsl:element name="db:simplesect">
					<xsl:attribute name="xml:id">
						<!-- ids to bookmark schema elements include '_bookmark' to differentiate from type schema -->
						<xsl:choose>
							<xsl:when test="ancestor::xs:schema[@id='bookmark-2005-1']">
								<xsl:value-of select="concat('tp_bookmark_',@name)"/>
								<xsl:if test="preceding::xs:element[@name=$name]">
									<xsl:value-of select="count(preceding::xs:element[@name=$name])"/>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat('tp_',@name)"/>
								<xsl:if test="preceding::xs:element[@name=$name]">
									<xsl:value-of select="count(preceding::xs:element[@name=$name])"/>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="xreflabel" select="$name"/>
					<xsl:element name="db:title">
						<xsl:value-of select="$name"/>
					</xsl:element>
					
					<!-- include any documentation from the schema after the heading -->
					<xsl:if test="xs:annotation">
						<xsl:apply-templates select="xs:annotation/xs:documentation/*"/>
					</xsl:if>
					
					<!-- begin processing the content for the element -->
					<xsl:call-template name="writeElementInformation"/>
				</xsl:element>
			
			</xsl:if>
		</xsl:for-each>
		
	</xsl:template>
	
	
	
	<xsl:template name="writeElementInformation">
		
		<!-- each section of information is marked by a new term in the variablelist -->
			<xsl:variable name="parent" select="ancestor::xs:element[not(ancestor::xs:element)]/@name"/>
			<xsl:variable name="name" select="@name"/>
			
			<xsl:choose>
				<xsl:when test="@name and preceding::xs:element[@name=$name][ancestor::xs:element[not(ancestor::xs:element)]/@name=$parent]">
					<!-- skip the element if it's a repeat within the same parent -->
				</xsl:when>
				<xsl:otherwise>
						<!-- add info about the properties of the element -->
						<xsl:element name="db:bridgehead">
							<xsl:text>Properties</xsl:text>
						</xsl:element>
						<xsl:call-template name="addElementInfo"/>
					
					<!-- add table with attribute info, if any -->
					<xsl:if test="xs:complexType/xs:attribute">
						<xsl:call-template name="addAttributeInfo"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		
	</xsl:template>
	
	
	<!-- adds documentation about the type of value or content model allowed by the element -->
	<xsl:template name="addElementInfo">
		
		<xsl:choose>
			<xsl:when test="@type">
				<xsl:element name="db:para">
					<xsl:attribute name="role">typeProperty</xsl:attribute>
					<xsl:element name="db:emphasis">
						<xsl:text>Data type: </xsl:text>
					</xsl:element>
					<xsl:element name="db:type">
						<xsl:value-of select="@type"/>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="db:para">
					<xsl:attribute name="role">typeProperty</xsl:attribute>
					<xsl:element name="db:emphasis">
						<xsl:choose>
							<xsl:when test="xs:complexType">
								<xsl:text>Content model: </xsl:text>
							</xsl:when>
							<xsl:when test="xs:simpleType">
								<xsl:text>Allowed values: </xsl:text>
							</xsl:when>
							<xsl:when test="not(xs:*[not(self::xs:annotation)][not(self::xs:attribute)])"/>
							<xsl:otherwise>
								<xsl:text>##unknown##: </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:element>
					
					<xsl:choose>
						<xsl:when test="xs:complexType[child::xs:group]">
							<xsl:variable name="grpRef" select="xs:complexType/child::xs:group/@ref"/>
							<xsl:call-template name="generateCM">
								<xsl:with-param name="thisType" select="ancestor::xs:schema//xs:group[@name=$grpRef]"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="xs:complexType[not(.//xs:element)]">
							<xsl:choose>
								<xsl:when test="not(xs:complexType[@mixed='true'])">
									<xsl:text>empty element</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>text only</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="generateCM">
								<xsl:with-param name="thisType" select="."/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
				
				<!-- check if an extensible element -->
				<xsl:if test="xs:complexType/xs:sequence/xs:choice/xs:any or xs:complexType/xs:sequence/xs:any">
					<xsl:element name="db:para">
						<xsl:text>This element is extensible.</xsl:text>
					</xsl:element>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:element name="db:para">
			<xsl:attribute name="role">typeProperty</xsl:attribute>
			<xsl:element name="db:emphasis">
				<xsl:text>Parent(s): </xsl:text>
			</xsl:element>
			<xsl:call-template name="addParents"/>
		</xsl:element>
		
		<xsl:for-each select="@*">
			<xsl:if test="not(contains('type|xml:id|name|ref|minOccurs|maxOccurs', name()))">
				<xsl:element name="db:para">
					<xsl:element name="db:emphasis">
						<xsl:value-of select="upper-case(substring(name(), 1, 1))"/>
						<xsl:value-of select="substring(name(), 2)"/>
					</xsl:element>
					<xsl:text>: </xsl:text>
					<xsl:value-of select="."/>
				</xsl:element>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	
	
	<!-- grabs the names of all elements that have this element as a child and makes a linkable list to them -->
	<xsl:template name="addParents">
		<xsl:variable name="name" select="@name"/>
		
		<xsl:choose>
			<xsl:when test="not(ancestor::xs:element)">
				<xsl:choose>
					<xsl:when test="ancestor::xs:group">
						<xsl:variable name="groupName" select="ancestor::xs:group/@name"/>
						<xsl:for-each select="ancestor::xs:schema//xs:element[not(descendant::xs:element)][descendant::xs:group[@ref=$groupName]]">
							<xsl:sort select="@name"/>
							<xsl:call-template name="addLink">
								<xsl:with-param name="name" select="@name"/>
							</xsl:call-template>
							<xsl:if test="not(position() = last())">
								<xsl:text>, </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="
							ancestor::xs:schema//xs:element[@ref=$name]/ancestor::xs:element[1]
							|ancestor::xs:schema//xs:element[not(descendant::xs:element)][descendant::xs:group[@ref=ancestor::xs:schema/xs:group[descendant::xs:element[@ref=$name]]/@name]]">
							<xsl:sort select="@name"/>
							<xsl:call-template name="addLink">
								<xsl:with-param name="name" select="@name"/>
							</xsl:call-template>
							<xsl:if test="not(position() = last())">
								<xsl:text>, </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
				
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="addLink">
					<xsl:with-param name="name" select="ancestor::xs:element[1]/@name"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	
	</xsl:template>
	
	
	
	<!-- iterate over the attributes and generate a table of information -->
	<xsl:template name="addAttributeInfo">
		
		<xsl:element name="db:bridgehead">
			<xsl:text>Attributes</xsl:text>
		</xsl:element>
		
			<xsl:for-each select="xs:complexType/xs:attribute">
				<xsl:element name="db:itemizedlist">
					<xsl:element name="db:listitem">
						<xsl:element name="db:para">
							<xsl:attribute name="role">attrName</xsl:attribute>
							<xsl:value-of select="@name|@ref"/>
						</xsl:element>
						
						<xsl:copy-of select="./xs:annotation/xs:documentation/db:*"/>
						
						<xsl:element name="db:para">
							<xsl:attribute name="role">typeProperty</xsl:attribute>
							<xsl:element name="db:emphasis">Use: </xsl:element>
							<xsl:choose>
								<xsl:when test="@use">
									<xsl:value-of select="@use"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>optional</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
						<xsl:element name="db:para">
							<xsl:attribute name="role">typeProperty</xsl:attribute>
							<xsl:choose>
								<xsl:when test="child::xs:simpleType">
									<xsl:call-template name="generateCM">
										<xsl:with-param name="thisType" select="."/>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="@type">
									<xsl:element name="db:emphasis">
										<xsl:text>Data type: </xsl:text>
									</xsl:element>
									<xsl:element name="db:type">
										<xsl:value-of select="@type"/>
									</xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>&#160;</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
						
						<xsl:if test="@fixed">
							<xsl:element name="db:para">
								<xsl:attribute name="role">typeProperty</xsl:attribute>
								<xsl:element name="db:emphasis">
									<xsl:text>Fixed value: </xsl:text>
								</xsl:element>
								<xsl:element name="db:literal">
									<xsl:value-of select="@fixed"/>
								</xsl:element>
							</xsl:element>
						</xsl:if>
						
						<xsl:if test="@form">
							<xsl:element name="db:para">
								<xsl:attribute name="role">typeProperty</xsl:attribute>
								<xsl:text>Form: </xsl:text>
								<xsl:value-of select="@form"/>
							</xsl:element>
						</xsl:if>
						
						<xsl:if test="@default">
							<xsl:element name="db:para">
								<xsl:attribute name="role">typeProperty</xsl:attribute>
								<xsl:element name="db:emphasis">
									<xsl:text>Default Value: </xsl:text>
								</xsl:element>
								<xsl:element name="db:literal">
									<xsl:value-of select="@default"/>
								</xsl:element>
							</xsl:element>
						</xsl:if>
						
						<!-- display any problems -->
						<xsl:for-each select="@*">
							<xsl:choose>
								<xsl:when test="contains('form|fixed|name|use|default|type|ref', local-name())"/>
								<xsl:otherwise>
									<xsl:element name="db:para">
										<xsl:value-of select="local-name()"/>
										<xsl:text> = </xsl:text>
										<xsl:value-of select="."/>
									</xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
		
	</xsl:template>
	
	
	
	
	
	
	
	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	
	<!-- stop from getting stripped -->
	<xsl:template match="@xlink:href">
		<xsl:attribute name="xlink:href">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>
	
	<!-- clean up for any elements in the root namespace that should be in db:* -->
	<xsl:template match="daisy:*" priority="1">
		<xsl:element name="db:{local-name()}">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>
