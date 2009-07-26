<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:db="http://docbook.org/ns/docbook" version="2.0"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:daisy="http://www.daisy.org/ns/daisy-online/#"
	xpath-default-namespace="http://www.w3.org/2001/XMLSchema"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="db">
	<!--
		Transform a docbook instance to a docbook instance, inserting data
		from a XSD doc in a predefined slot.
		
		The generated xml uses a predictable id generation, so that its members can be referenced safely 
		in surrounding parts of the host document
	-->
	
	<xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>

	<xsl:variable name="xsd" select="document('../../../src/do-types-10.xsd')"/>
	
	<!-- list of types - prevents processing of general-use elements in xsd -->
	
	<xsl:variable name="typeList">readingSystemAttributes|announcements|contentMetadata|bookmarkSet|questions|userResponses|serviceAttributes</xsl:variable>

	<xsl:template match="db:chapter[@xml:id='typeReference']">
		<xsl:element name="db:chapter">
			<xsl:attribute name="xml:id">typeReference</xsl:attribute>
			<xsl:attribute name="conformance">normative</xsl:attribute>
			<xsl:element name="db:title">Type Reference</xsl:element>
			<!-- get the top-level elements in the xsd (aka types) -->
			<xsl:for-each select="$xsd/schema/element">
				<xsl:variable name="idref" select="concat('tp_', @name, '_element_')"></xsl:variable>
				<xsl:if test="contains($typeList, @name)">
					<xsl:element name="db:section">
						<xsl:attribute name="xml:id" select="concat('tp_',@name)"/>
						<xsl:attribute name="xreflabel" select="@name"/>
						
						<xsl:element name="db:title">
							<xsl:text>The </xsl:text>
							<xsl:value-of select="@name"/>
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
						
						<xsl:call-template name="buildSection">
							<xsl:with-param name="idref" select="$idref"/>
							<xsl:with-param name="isType">true</xsl:with-param>
						</xsl:call-template>
					</xsl:element>
				</xsl:if>
			</xsl:for-each>
			<xsl:element name="db:section">
				<xsl:attribute name="xml:id">tp_general_elementReference</xsl:attribute>
				<xsl:element name="db:title">Common Elements and Constructs</xsl:element>
				<xsl:for-each select="$xsd/schema/element">
					<xsl:variable name="idref" select="concat('tp_', @name)"></xsl:variable>
					
					<xsl:if test="not(contains($typeList, @name))">
						<xsl:element name="db:variablelist">
							<xsl:element name="db:varlistentry">
								<xsl:element name="db:term">
									<xsl:attribute name="xml:id" select="concat('tp_',@name)"/>
									<xsl:attribute name="xreflabel" select="@name"/>
									<xsl:value-of select="@name"/>
								</xsl:element>
								
								<xsl:element name="db:listitem">
									<xsl:choose>
										<xsl:when test="child::xs:annotation">
											<xsl:copy-of select="child::xs:annotation/xs:documentation/db:*"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:element name="db:para">...</xsl:element>
										</xsl:otherwise>
									</xsl:choose>
									
									<xsl:call-template name="buildSection">
										<xsl:with-param name="idref" select="$idref"/>
										<xsl:with-param name="isType">true</xsl:with-param>
									</xsl:call-template>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	
	
	
	<xsl:template name="buildSection">
		<xsl:param name="idref" as="xs:string"/>
		<xsl:param name="isType" as="xs:boolean"/>
		
		<xsl:element name="db:variablelist">
			<xsl:element name="db:varlistentry">
				<xsl:element name="db:term">
					<xsl:text>Content Model</xsl:text>
				</xsl:element>
				
				<xsl:element name="db:listitem">
					<xsl:element name="db:para">
						<xsl:call-template name="generateCM">
							<xsl:with-param name="thisType" select="."/>
							<xsl:with-param name="idref" select="$idref"/>
						</xsl:call-template>
					</xsl:element>
					<xsl:if test=".//xs:any[count(ancestor::xs:element)=1]">
						<xsl:element name="db:para">This element is extensible.</xsl:element>
					</xsl:if>
				</xsl:element>
			</xsl:element>
			
			<xsl:if test=".//xs:element[not(@ref)]">
				<xsl:element name="db:varlistentry">
					<xsl:element name="db:term">
						<xsl:text>Element Reference</xsl:text>
					</xsl:element>
					<xsl:element name="db:listitem">
						<xsl:call-template name="generateElements">
							<xsl:with-param name="elist" select=".//xs:element[not(@ref)]"/>
							<xsl:with-param name="idref">
								<xsl:value-of select="$idref"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:element>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	
	
	
	<!-- 
			GENERATE A DTD-LIKE CONTENT MODEL
	-->
	
	<xsl:template name="generateCM">
		<xsl:param name="thisType"/>
		<xsl:param name="idref" as="xs:string"/>
		
		<xsl:choose>
			<xsl:when test="not($thisType/child::*[not(self::xs:attribute)])">
				<xsl:value-of select="@type"/>
			</xsl:when>
			
			<xsl:otherwise>
				<xsl:for-each select="$thisType/child::*[not(xs:any)]">
					<xsl:choose>
						<xsl:when test="self::xs:sequence or self::xs:choice">
							<xsl:call-template name="processCMGroup">
								<xsl:with-param name="idref" select="$idref"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="self::xs:element">
							<xsl:call-template name="processCMElement">
								<xsl:with-param name="idref" select="$idref"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="self::xs:complexType">
							<xsl:call-template name="generateCM">
								<xsl:with-param name="thisType" select="."/>
								<xsl:with-param name="idref" select="$idref"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="self::xs:simpleType">
							<xsl:call-template name="processCMSimpleType">
								<xsl:with-param name="idref" select="$idref"/>
							</xsl:call-template>
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
	
	<xsl:template name="processCMGroup">
		<xsl:param name="idref" as="xs:string"/>
		
		<xsl:text> (</xsl:text>
		<xsl:call-template name="generateCM">
			<xsl:with-param name="thisType" select="."/>
			<xsl:with-param name="idref" select="$idref"/>
		</xsl:call-template>
		<xsl:text>) </xsl:text>
		
		<xsl:call-template name="addJoiner"/>
	</xsl:template>
	
	
	
	<xsl:template name="processCMElement">
		<xsl:param name="idref" as="xs:string"/>
		
		<xsl:variable name="name" select="@name|@ref"/>
		
		<xsl:element name="db:link">
			<xsl:attribute name="linkend">
				<xsl:choose>
					<xsl:when test="@ref">
						<xsl:value-of select="concat('tp_', $name)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($idref, $name)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:value-of select="$name"/>
		</xsl:element>
		
		<xsl:call-template name="addModifier"/>
		
		<xsl:call-template name="addJoiner"/>
	</xsl:template>
	
	
	
	<xsl:template name="processCMSimpleType">
		<xsl:param name="idref" as="xs:string"/>
		
		<xsl:choose>
			<xsl:when test="child::xs:restriction/*">
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
				<xsl:value-of select="child::xs:restriction/@base"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="child::xs:restriction/*">
			<xsl:call-template name="processRestriction"/>
		</xsl:if>
	</xsl:template>
	
	
	
	<xsl:template name="processRestriction">
		<xsl:element name="db:itemizedlist">
			<xsl:for-each select="child::xs:restriction/*">
				<xsl:element name="db:listitem">
					<xsl:element name="db:para">
						<xsl:choose>
							<xsl:when test="self::xs:enumeration">
								<xsl:value-of select="@value"/>
							</xsl:when>
							<xsl:when test="self::xs:minInclusive">
								<xsl:text>minimum value: </xsl:text>
								<xsl:value-of select="@value"/>
							</xsl:when>
							<xsl:when test="self::xs:maxInclusive">
								<xsl:text>maximum value: </xsl:text>
								<xsl:value-of select="@value"/>
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
	
	
	
	<xsl:template name="addModifier">
		<xsl:choose>
			<xsl:when test="(not(@minOccurs) and not(@maxOccurs))
						or (@minOccurs='1' and @maxOccurs='1')
						or (not(@minOccurs) and @maxOccurs='1')
						or (@minOccurs='1' and not(@maxOccurs))
						"/>
			<xsl:when test="@minOccurs='0' and (not(@maxOccurs) or @maxOccurs='1')">?</xsl:when>
			<xsl:when test="@minOccurs='0' and @maxOccurs='unbounded'">*</xsl:when>
			<xsl:when test="(not(@minOccurs) or @minOccurs='1') and @maxOccurs='unbounded'">+</xsl:when>
			<xsl:otherwise>
				<xsl:text>{</xsl:text>
				<xsl:choose>
					<xsl:when test="not(@minOccurs)">1</xsl:when>
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
	
	
	
	<xsl:template name="addCardinality">
		<xsl:choose>
			<xsl:when test="(not(@minOccurs) and not(@maxOccurs))
				or (@minOccurs='1' and @maxOccurs='1')
				or (not(@minOccurs) and @maxOccurs='1')
				or (@minOccurs='1' and not(@maxOccurs))
				">1</xsl:when>
			<xsl:when test="@minOccurs='0' and (not(@maxOccurs) or @maxOccurs='1')">0 or 1</xsl:when>
			<xsl:when test="@minOccurs='0' and @maxOccurs='unbounded'">0 or more</xsl:when>
			<xsl:when test="(not(@minOccurs) or @minOccurs='1') and @maxOccurs='unbounded'">1 or more</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="not(@minOccurs)">1</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@minOccurs"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="not(@maxOccurs)">
						<xsl:text> or more</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text> to </xsl:text>
						<xsl:value-of select="@maxOccurs"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	
	<xsl:template name="addJoiner">
		<xsl:if test="following-sibling::xs:element 
			or following-sibling::xs:complexType[.//xs:element]
			or following-sibling::xs:simpleType
			or following-sibling::xs:complexContent[.//xs:element]
			or following-sibling::xs:simpleContent
			or following-sibling::xs:sequence[.//xs:element]
			or following-sibling::xs:choice[.//xs:element]">
			<xsl:choose>
				<xsl:when test="parent::xs:choice"> | </xsl:when>
				<xsl:when test="parent::xs:sequence">, </xsl:when>
				<xsl:otherwise> #unknown# </xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	
	
	
	
	<!-- 
			PROCESS ELEMENTS INFORMATION
	-->
	
	
	<xsl:template name="generateElements">
		<xsl:param name="elist"/>
		<xsl:param name="idref" as="xs:string"/>
		
		<xsl:element name="db:variablelist">
			<xsl:for-each select="$elist">
				
				<xsl:variable name="parent" select="ancestor::xs:element[not(ancestor::xs:element)]/@name"/>
				<xsl:variable name="name" select="@name"/>
				
				<xsl:choose>
					<xsl:when test="@name and preceding::xs:element[@name=$name][ancestor::xs:element[not(ancestor::xs:element)]/@name=$parent]"/>
					<xsl:otherwise>
						
						<xsl:element name="db:varlistentry">
							<xsl:element name="db:term">
								<xsl:attribute name="xml:id" select="concat($idref, @name)"/>
								<xsl:value-of select="@name"/>
							</xsl:element>
							
							<xsl:element name="db:listitem">
								<!-- add description -->
								<xsl:if test="xs:annotation">
									<xsl:apply-templates select="xs:annotation/xs:documentation/*"/>
								</xsl:if>
								
								<xsl:element name="db:variablelist">
									<xsl:element name="db:varlistentry">
										<xsl:element name="db:term">
											<xsl:text>Properties</xsl:text>
										</xsl:element>
										<xsl:element name="db:listitem">
											<xsl:call-template name="addElementInfo">
												<xsl:with-param name="idref" select="$idref"/>
											</xsl:call-template>
										</xsl:element>
									</xsl:element>
									
									<xsl:if test="xs:complexType/xs:attribute">
										<xsl:element name="db:varlistentry">
											<xsl:element name="db:term">
												<xsl:text>Attributes</xsl:text>
											</xsl:element>
											<xsl:element name="db:listitem">
												<xsl:call-template name="addAttributeInfo">
													<xsl:with-param name="idref" select="$idref"/>
												</xsl:call-template>
											</xsl:element>
										</xsl:element>
									</xsl:if>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	
	
	
	<xsl:template name="addElementInfo">
		<xsl:param name="idref" as="xs:string"/>
		
		<xsl:element name="db:para">
			<xsl:element name="db:emphasis">Cardinality: </xsl:element>
			<xsl:call-template name="addCardinality"/>
		</xsl:element>
		
		<xsl:choose>
			<xsl:when test="@type">
				<xsl:element name="db:para">
					<xsl:element name="db:emphasis">
						<xsl:text>Data type: </xsl:text>
					</xsl:element>
					<xsl:value-of select="@type"/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="db:para">
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
								<xsl:with-param name="idref" select="$idref"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
		
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
	
	
	
	<xsl:template name="addAttributeInfo">
		<xsl:param name="idref"/>
		
		<xsl:element name="db:table">
			<xsl:attribute name="class">attrTable</xsl:attribute>
			
			<xsl:element name="db:caption">
				<xsl:attribute name="class">hiddenCaption</xsl:attribute>
			</xsl:element>
			
			<xsl:element name="db:thead">
				<xsl:element name="db:tr">
					<xsl:element name="db:th">
						<xsl:attribute name="class">attrName</xsl:attribute>
						<xsl:text>name</xsl:text>
					</xsl:element>
					<xsl:element name="db:th">
						<xsl:attribute name="class">attrUse</xsl:attribute>
						<xsl:text>use</xsl:text>
					</xsl:element>
					<xsl:element name="db:th">
						<xsl:attribute name="class">attrType</xsl:attribute>
						<xsl:text>properties</xsl:text>
					</xsl:element>
					<xsl:element name="db:th">
						<xsl:attribute name="class">attrDefault</xsl:attribute>
						<xsl:text>default</xsl:text>
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<xsl:element name="db:tbody">
				<xsl:for-each select="xs:complexType/xs:attribute">
					<xsl:element name="db:tr">
						<xsl:element name="db:td">
							<xsl:element name="db:emphasis">
								<xsl:value-of select="@name|@ref"/>
							</xsl:element>
						</xsl:element>
						<xsl:element name="db:td">
							<xsl:choose>
								<xsl:when test="@use">
									<xsl:value-of select="@use"/>
								</xsl:when>
								<xsl:otherwise>optional</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
						<xsl:element name="db:td">
							<xsl:element name="db:para">
								<xsl:choose>
									<xsl:when test="child::xs:simpleType">
										<xsl:call-template name="generateCM">
											<xsl:with-param name="thisType" select="."/>
											<xsl:with-param name="idref" select="$idref"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="@type">
										Data type: <xsl:value-of select="@type"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>&#160;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:element>
							
							<xsl:if test="@fixed">
								<xsl:element name="db:para">
									<xsl:text>Fixed value: </xsl:text>
									<xsl:value-of select="@fixed"/>
								</xsl:element>
							</xsl:if>
							
							<xsl:if test="@form">
								<xsl:element name="db:para">
									<xsl:text>Form: </xsl:text>
									<xsl:value-of select="@form"/>
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
						<xsl:element name="db:td">
							<xsl:choose>
								<xsl:when test="@default">
									<xsl:value-of select="@default"/>
								</xsl:when>
								<xsl:otherwise>&#160;</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
					</xsl:element>
				</xsl:for-each>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	
	
	
	
	
	
	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="@xlink:href">
		<xsl:attribute name="xlink:href">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>
	
	<xsl:template match="daisy:*" priority="1">
		<xsl:element name="db:{local-name()}">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>
