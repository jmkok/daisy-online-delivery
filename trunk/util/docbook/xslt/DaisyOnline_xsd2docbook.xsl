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

	<xsl:template match="db:chapter[@xml:id='typeReference']">
		<xsl:element name="db:chapter">
			<xsl:attribute name="xml:id">typeReference</xsl:attribute>
			<xsl:attribute name="conformance">normative</xsl:attribute>
			<xsl:element name="db:title">Type Reference</xsl:element>
			<!-- get the top-level elements in the xsd (aka types) -->
			<xsl:for-each select="$xsd/schema/element">
				<xsl:variable name="idref" select="concat('tp_', @name, '_element_')"></xsl:variable>
				<xsl:element name="db:section">
					<xsl:attribute name="xml:id" select="concat('tp_',@name)"/>
					<xsl:attribute name="xreflabel" select="@name"/>
					<xsl:element name="db:title">The <xsl:value-of select="@name"/> Type</xsl:element>
					<xsl:element name="db:section">
						<xsl:attribute name="xml:id" select="concat('tp_',@name,'_desc')"/>
						<xsl:element name="db:title">Description</xsl:element>
						<!-- hack until descriptions are written -->
						<xsl:choose>
							<xsl:when test="child::xs:annotation">
								<xsl:copy-of select="child::xs:annotation/xs:documentation/*"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:element name="db:para">...</xsl:element>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:element>
					<xsl:element name="db:section">
						<xsl:attribute name="xml:id" select="concat('tp_',@name,'cm')"/>
						<xsl:element name="db:title">Content Model</xsl:element>
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
					<xsl:element name="db:section">
						<xsl:attribute name="xml:id" select="concat('tp_', @name, '_elementReference')"/>
						<xsl:element name="db:title">Element Reference</xsl:element>
						<xsl:call-template name="generateElements">
							<xsl:with-param name="elist" select=".//xs:element"/>
							<xsl:with-param name="idref">
								<xsl:value-of select="$idref"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	
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
							<xsl:text> (</xsl:text>
							<xsl:call-template name="generateCM">
								<xsl:with-param name="thisType" select="."/>
								<xsl:with-param name="idref" select="$idref"/>
							</xsl:call-template>
							<xsl:text>) </xsl:text>
							<xsl:call-template name="addJoiner"/>
						</xsl:when>
						<xsl:when test="self::xs:element">
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
							
							
							<xsl:choose>
								<xsl:when test="not(@minOccurs) and not(@maxOccurs)"/>
								<xsl:when test="@minOccurs='0' and @maxOccurs='1'">?</xsl:when>
								<xsl:when test="@minOccurs='0' and @maxOccurs='unbounded'">*</xsl:when>
								<xsl:when test="@minOccurs='1' and @maxOccurs='1'"/>
								<xsl:when test="@minOccurs='1' and @maxOccurs='unbounded'">+</xsl:when>
								<xsl:when test="@minOccurs or @maxOccurs">
									<xsl:text>{</xsl:text>
									<xsl:value-of select="@minOccurs"/>
									<xsl:text>,</xsl:text>
									<xsl:value-of select="@maxOccurs"/>
									<xsl:text>}</xsl:text>
								</xsl:when>
							</xsl:choose>
							<xsl:call-template name="addJoiner"/>
						</xsl:when>
						<xsl:when test="self::xs:annotation"/>
						<xsl:when test="self::xs:any"/>
						<xsl:when test="self::xs:attribute"/>
						<xsl:when test="self::xs:complexType">
							<xsl:call-template name="generateCM">
								<xsl:with-param name="thisType" select="."/>
								<xsl:with-param name="idref" select="$idref"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="self::xs:simpleType">
							<xsl:element name="db:para">
								<xsl:choose>
									<xsl:when test="child::xs:restriction/*">
										<xsl:choose>
											<xsl:when test="child::xs:restriction/xs:enumeration">
												Enumeration:
											</xsl:when>
											<xsl:when test="child::xs:restriction/xs:minInclusive|child::xs:restriction/xs:maxInclusive">
												Integer Value:
											</xsl:when>
											<xsl:otherwise>
												##unknown##: (<xsl:value-of select="child::xs:restriction/@base"/>)
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="child::xs:restriction/@base"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:element>
							<xsl:if test="child::xs:restriction/*">
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
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>###<xsl:value-of select="local-name()"/>###</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	
	<xsl:template name="addJoiner">
		<xsl:if test="following-sibling::xs:element 
			or following-sibling::xs:complexType
			or following-sibling::xs:simpleType
			or following-sibling::xs:complexContent
			or following-sibling::xs:simpleContent
			or following-sibling::xs:sequence
			or following-sibling::xs:choice">
			<xsl:choose>
				<xsl:when test="parent::xs:choice"> | </xsl:when>
				<xsl:when test="parent::xs:sequence">, </xsl:when>
				<xsl:otherwise> #unknown# </xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	
	
	
	
	<xsl:template name="generateElements">
		<xsl:param name="elist"/>
		<xsl:param name="idref" as="xs:string"/>
		
		<xsl:for-each select="$elist">
		
			<xsl:variable name="parent" select="ancestor::xs:element[not(ancestor::xs:element)]/@name"/>
			<xsl:variable name="name" select="@name"/>
			
			<xsl:choose>
				<xsl:when test="@name and preceding::xs:element[@name=$name][ancestor::xs:element[not(ancestor::xs:element)]/@name=$parent]"/>
				<xsl:otherwise>
					
					<xsl:element name="db:bridgehead">
						<xsl:attribute name="xml:id" select="concat($idref, @name)"/>
						<xsl:value-of select="@name"/>
					</xsl:element>
					
					<!-- add description -->
					<xsl:if test="xs:annotation">
						<xsl:apply-templates select="xs:annotation/xs:documentation/*"/>
					</xsl:if>
					
					<xsl:element name="db:table">
						<xsl:attribute name="width">75%</xsl:attribute>
						<xsl:attribute name="cellpadding">2</xsl:attribute>
						<xsl:attribute name="cellspacing">0</xsl:attribute>
						<xsl:attribute name="frame">box</xsl:attribute>
						<xsl:attribute name="border">1</xsl:attribute>
						<xsl:attribute name="style">margin: .25empx; padding: 0px; border: 1px solid black;</xsl:attribute>
						<xsl:element name="db:caption">
							<xsl:value-of select="@name"/>
							<xsl:text> Properties</xsl:text>
						</xsl:element>
						<xsl:element name="db:thead">
							<xsl:element name="db:tr">
								<xsl:element name="db:th">
									<xsl:attribute name="style">width: 30%;</xsl:attribute>
									<xsl:text>characteristic</xsl:text>
								</xsl:element>
								<xsl:element name="db:th">
									<xsl:attribute name="style">width: 70%;</xsl:attribute>
									<xsl:text>description</xsl:text>
								</xsl:element>
							</xsl:element>
						</xsl:element>
						<xsl:element name="db:tbody">
							<xsl:element name="db:tr">
								<xsl:element name="db:td">cardinality</xsl:element>
								<xsl:element name="db:td">
									<xsl:element name="db:para">
										<xsl:text>minOccurs: </xsl:text>
										<xsl:choose>
											<xsl:when test="@minOccurs">
												<xsl:value-of select="@minOccurs"/>
											</xsl:when>
											<xsl:otherwise>1</xsl:otherwise>
										</xsl:choose>
										<xsl:text>, maxOccurs: </xsl:text>
										<xsl:choose>
											<xsl:when test="@maxOccurs">
												<xsl:value-of select="@maxOccurs"/>
											</xsl:when>
											<xsl:otherwise>1</xsl:otherwise>
										</xsl:choose>
									</xsl:element>
								</xsl:element>
							</xsl:element>
							<xsl:element name="db:tr">
								<xsl:choose>
									<xsl:when test="@type">
										<xsl:element name="db:td">
											<xsl:text>type</xsl:text>
										</xsl:element>
										<xsl:element name="db:td">
											<xsl:value-of select="@type"/>
										</xsl:element>
									</xsl:when>
									<xsl:otherwise>
										<xsl:element name="db:td">
											<xsl:element name="db:para">
												<xsl:choose>
													<xsl:when test="xs:complexType">
														<xsl:text>content model: </xsl:text>
													</xsl:when>
													<xsl:when test="xs:simpleType">
														<xsl:text>allowed values: </xsl:text>
													</xsl:when>
													<xsl:when test="not(xs:*[not(self::xs:annotation)][not(self::xs:attribute)])"/>
													<xsl:otherwise>
														<xsl:text>##unknown##: </xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:element>
										</xsl:element>
										<xsl:element name="db:td">
											<xsl:call-template name="generateCM">
												<xsl:with-param name="thisType" select="."/>
												<xsl:with-param name="idref" select="$idref"/>
											</xsl:call-template>
										</xsl:element>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:element>
						</xsl:element>
					</xsl:element>
					
					<xsl:if test="xs:complexType/xs:attribute">
						<xsl:element name="db:table">
							<xsl:attribute name="width">75%</xsl:attribute>
							<xsl:attribute name="cellpadding">2</xsl:attribute>
							<xsl:attribute name="cellspacing">0</xsl:attribute>
							<xsl:attribute name="frame">box</xsl:attribute>
							<xsl:attribute name="border">1</xsl:attribute>
							<xsl:attribute name="style">margin: .25empx; padding: 0px; border: 1px solid black;</xsl:attribute>
							
							<xsl:element name="db:caption">
								<xsl:attribute name="style">margin-top: 2em</xsl:attribute>
								<xsl:value-of select="@name"/>
								<xsl:text> Attributes</xsl:text>
							</xsl:element>
							<xsl:element name="db:thead">
								<xsl:element name="db:tr">
									<xsl:element name="db:th">
										<xsl:attribute name="style">width: 20%;</xsl:attribute>
										<xsl:text>name</xsl:text>
									</xsl:element>
									<xsl:element name="db:th">
										<xsl:attribute name="style">width: 50%;</xsl:attribute>
										<xsl:text>use</xsl:text>
									</xsl:element>
									<xsl:element name="db:th">
										<xsl:attribute name="style">width: 15%;</xsl:attribute>
										<xsl:text>value</xsl:text>
									</xsl:element>
									<xsl:element name="db:th">
										<xsl:attribute name="style">width: 15%;</xsl:attribute>
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
											<xsl:choose>
												<xsl:when test="child::xs:simpleType">
													<xsl:call-template name="generateCM">
														<xsl:with-param name="thisType" select="."/>
														<xsl:with-param name="idref" select="$idref"/>
													</xsl:call-template>
												</xsl:when>
												<xsl:when test="@type">
													<xsl:value-of select="@type"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>&#160;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
											
											<!-- display any problems -->
											<xsl:for-each select="@*">
												<xsl:choose>
													<xsl:when test="contains('name|use|default|type|ref', local-name())"/>
													<xsl:otherwise>
														<xsl:value-of select="local-name()"/>
														<xsl:text> = </xsl:text>
														<xsl:value-of select="."/>
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
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
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
