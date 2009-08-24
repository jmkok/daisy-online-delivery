<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<!--
		Transform an xsd instance to an xsd instance, removing documentation
	-->
	<xsl:output indent="yes" method="xml"/>
	
	<xsl:template match="xs:annotation|xs:annotation/*">
	  	<xsl:text></xsl:text>
	</xsl:template>

	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
