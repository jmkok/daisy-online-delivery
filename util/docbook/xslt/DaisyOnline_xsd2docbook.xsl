<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:db="http://docbook.org/ns/docbook" version="2.0"
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
								<xsl:apply-templates select="child::xs:annotation/xs:documentation/*"/>
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
				<xsl:text>empty</xsl:text>
			</xsl:when>
			
			<xsl:otherwise>
				
				<xsl:for-each select="$thisType/child::*">
					<xsl:choose>
						<xsl:when test="self::xs:complexType or self::xs:sequence or self::xs:choice">
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
						<xsl:when test="self::xs:attribute"/>
						<xsl:otherwise>###<xsl:value-of select="local-name()"/>###</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="xs:element">
		<db:para>
			<db:emphasis>
				<xsl:value-of select="@name|@ref"/>
			</db:emphasis>
			
			<xsl:text> (</xsl:text>
				<xsl:choose>
					<xsl:when test="@minOccurs='1' and @maxOccurs='1'">required</xsl:when>
					<xsl:when test="@minOccurs='0' and @maxOccurs='1'">optional</xsl:when>
					<xsl:when test="@minOccurs='1' and @maxOccurs='unbounded'">one or more</xsl:when>
					<xsl:when test="@minOccurs='0' and @maxOccurs='unbounded'">zero or more</xsl:when>
					<xsl:otherwise><xsl:value-of select="@minOccurs"/> to <xsl:value-of select="@maxOccurs"/></xsl:otherwise>
				</xsl:choose>
			<xsl:text>)</xsl:text>
			
			<db:itemizedlist>
				<db:listitem>
					<db:para>
						<xsl:choose>
							<xsl:when test="@type">
								<xsl:text>type=</xsl:text><xsl:value-of select="@type"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>content model=</xsl:text>
								<xsl:call-template name="generateCM">
									<xsl:with-param name="thisType" select="."/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</db:para>
				</db:listitem>
				<xsl:if test="child::xs:complexType/xs:attribute">
					<db:listitem>
						<db:para>
							attributes:
							<db:itemizedlist>
								<xsl:for-each select="child::xs:complexType/xs:attribute">
									<db:listitem>
										<db:para>
											<db:emphasis>
												<xsl:value-of select="@name|@ref"/>
											</db:emphasis>
										</db:para>
									</db:listitem>
								</xsl:for-each>
							</db:itemizedlist>
						</db:para>
					</db:listitem>
				</xsl:if>
				<xsl:if test="child::xs:annotation">
					<db:listitem>
						<db:para>
							<xsl:apply-templates select="child::xs:annotation/xs:documentation/*"/>
						</db:para>
					</db:listitem>
				</xsl:if>
			</db:itemizedlist>
		</db:para>
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

</xsl:stylesheet>
