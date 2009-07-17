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
					<db:para>...</db:para>	
				</db:section>			
			</xsl:for-each>
		</db:chapter>
	</xsl:template>

	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
