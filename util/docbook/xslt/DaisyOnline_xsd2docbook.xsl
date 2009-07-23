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
		<db:chapter xml:id="typeReference" conformance="normative">
			<db:title>Type Reference</db:title>
			<!-- get the top-level elements in the xsd (aka types) -->
			<xsl:for-each select="$xsd/schema/element">
				<db:section>
					<xsl:attribute name="xml:id" select="concat('tp_',@name)"/>
					<xsl:attribute name="xreflabel" select="@name"/>
					<db:title>The <xsl:value-of select="@name"/> Type</db:title>
					<db:section>
						<xsl:attribute name="xml:id" select="concat('tp_',@name,'_desc')"/>
						<db:title>Description</db:title>
						<!-- hack until descriptions are written -->
						<xsl:choose>
							<xsl:when test="child::xs:annotation">
								<db:para>
									<xsl:apply-templates select="child::xs:annotation/xs:documentation/*"/>
								</db:para>
							</xsl:when>
							<xsl:otherwise>
								<db:para>...</db:para>
							</xsl:otherwise>
						</xsl:choose>
					</db:section>
					<db:section>
						<xsl:attribute name="xml:id" select="concat('tp_',@name,'_cm')"/>
						<db:title>Content Model</db:title>
						<db:para>
							<xsl:call-template name="generateCM">
								<xsl:with-param name="thisType" select="."/>
							</xsl:call-template>
						</db:para>
						<xsl:if test=".//xs:any[count(ancestor::xs:element)=1]">
							<db:para>This element is extensible.</db:para>
						</xsl:if>
					</db:section>
					<db:section>
						<xsl:attribute name="xml:id" select="concat('tp_',@name,'_elements')"/>
						<db:title>Element Descriptions</db:title>
						<xsl:apply-templates select=".//xs:element"/>
					</db:section>
				</db:section>
			</xsl:for-each>
		</db:chapter>
	</xsl:template>
	
	<xsl:template name="generateCM">
		<xsl:param name="thisType"/>
		
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
							</xsl:call-template>
							<xsl:text>) </xsl:text>
						</xsl:when>
						<xsl:when test="self::xs:element">
							<db:emphasis>
								<xsl:value-of select="@name|@ref"/>
							</db:emphasis>
							
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
						</xsl:when>
						<xsl:when test="self::xs:annotation"/>
						<xsl:when test="self::xs:any"/>
						<xsl:when test="self::xs:attribute"/>
						<xsl:when test="self::xs:complexType">
							<xsl:call-template name="generateCM">
								<xsl:with-param name="thisType" select="."/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="self::xs:simpleType">
							<db:itemizedlist>
								<xsl:for-each select="child::xs:restriction/*">
									<xsl:choose>
										<xsl:when test="self::xs:enumeration">
											<db:listitem>
												<db:para>
													<xsl:value-of select="@value"/>
													<xsl:if test="child::xs:annotation">
														<xsl:text> &#8212; </xsl:text>
														<xsl:apply-templates select="child::xs:annotation/xs:documentation/*"/>
													</xsl:if>
												</db:para>
											</db:listitem>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
							</db:itemizedlist>
						</xsl:when>
						<xsl:otherwise>###<xsl:value-of select="local-name()"/>###</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="xs:element">
		<xsl:variable name="ref" select="@ref"/>
		<xsl:variable name="thisElem" select="//xs:element[@name=$ref]|."/>
		
		<db:bridgehead>
			<xsl:value-of select="$thisElem/@name"/>
		</db:bridgehead>
		
		<xsl:if test="$thisElem/xs:annotation">
			<xsl:choose>
				<xsl:when test="$thisElem/xs:annotation/xs:documentation/daisy:remark">
					<xsl:apply-templates select="$thisElem/xs:annotation/xs:documentation/*"/>
				</xsl:when>
				<xsl:otherwise>
					<db:para>
						<xsl:apply-templates select="$thisElem/xs:annotation/xs:documentation/*"/>
					</db:para>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		
		<db:itemizedlist>
			<db:listitem>
				<db:para>
					<xsl:text>cardinality: </xsl:text>
					<xsl:choose>
						<xsl:when test="$thisElem/@minOccurs='1' and $thisElem/@maxOccurs='1'">required</xsl:when>
						<xsl:when test="$thisElem/@minOccurs='0' and $thisElem/@maxOccurs='1'">optional</xsl:when>
						<xsl:when test="$thisElem/@minOccurs='1' and $thisElem/@maxOccurs='unbounded'">one or more</xsl:when>
						<xsl:when test="$thisElem/@minOccurs='0' and $thisElem/@maxOccurs='unbounded'">zero or more</xsl:when>
						<xsl:otherwise><xsl:value-of select="$thisElem/@minOccurs"/> to <xsl:value-of select="$thisElem/@maxOccurs"/></xsl:otherwise>
					</xsl:choose>
				</db:para>
			</db:listitem>
			<db:listitem>
				<db:para>
					<xsl:choose>
						<xsl:when test="$thisElem/@type">
							<xsl:text>type: </xsl:text><xsl:value-of select="$thisElem/@type"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="$thisElem/xs:complexType">
									<xsl:text>content model: </xsl:text>
								</xsl:when>
								<xsl:when test="$thisElem/xs:simpleType">
									<xsl:text>allowed values: </xsl:text>
								</xsl:when>
								<xsl:when test="not($thisElem/xs:*[not(self::xs:annotation)][not(self::xs:attribute)])"/>
								<xsl:otherwise>
									<xsl:text>##unknown##: </xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:call-template name="generateCM">
								<xsl:with-param name="thisType" select="$thisElem"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</db:para>
			</db:listitem>
			<xsl:if test="$thisElem/xs:complexType/xs:attribute">
				<db:listitem>
					<db:para>
						<xsl:text>attributes:</xsl:text>
						<db:itemizedlist>
							<xsl:for-each select="$thisElem/xs:complexType/xs:attribute">
								<db:listitem>
									<db:para>
										<db:emphasis>
											<xsl:value-of select="@name|@ref"/>
										</db:emphasis>
										<xsl:text> (</xsl:text>
										<xsl:value-of select="@use"/>
										<xsl:text>)</xsl:text>
										<xsl:if test="count(@*) &gt; 2 or child::xs:simpleType">
											<db:itemizedlist>
												<xsl:if test="child::xs:simpleType">
													<db:listitem>
														<db:para>
															<xsl:text>allowed values:</xsl:text>
															<xsl:call-template name="generateCM">
																<xsl:with-param name="thisType" select="child::xs:simpleType"/>
															</xsl:call-template>
														</db:para>
													</db:listitem>
												</xsl:if>
												<xsl:for-each select="@*">
													<xsl:choose>
														<xsl:when test="local-name() = 'name' or local-name() = 'use'"/>
														<xsl:otherwise>
															<db:listitem>
																<db:para>
																	<xsl:value-of select="local-name()"/>
																	<xsl:text> = </xsl:text>
																	<xsl:value-of select="."/>
																</db:para>
															</db:listitem>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:for-each>
											</db:itemizedlist>
										</xsl:if>
									</db:para>
								</db:listitem>
							</xsl:for-each>
						</db:itemizedlist>
					</db:para>
				</db:listitem>
			</xsl:if>
		</db:itemizedlist>
	</xsl:template>
	
	<xsl:template match="xs:attribute">
		<xsl:value-of select="@name"/>
	</xsl:template>
	
	<xsl:template match="*[parent::xs:documentation]">
		<xsl:apply-templates/>
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
