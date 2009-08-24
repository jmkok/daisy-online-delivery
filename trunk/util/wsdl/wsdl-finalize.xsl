<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
	xpath-default-namespace="http://schemas.xmlsoap.org/wsdl/"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
	exclude-result-prefixes="wsdl xs">
	<!--
		Transform a wsdl instance to a wsdl instance, inserting the bindings section
		using WrappedDocumentLiteralBinding		
	-->
	<xsl:output indent="yes" exclude-result-prefixes="wsdl xs" method="xml"/>
	
	<xsl:template match="definitions/node()[last()]">
		<xsl:apply-templates/>
		<xsl:text>  &#10;</xsl:text>
		<xsl:element name="binding" namespace="http://schemas.xmlsoap.org/wsdl/">
			<xsl:attribute name="name">DaisyOnlineService</xsl:attribute>
			<xsl:attribute name="type">tns:daisy-online</xsl:attribute>
			<soap:binding style="document" transport="http://schemas.xmlsoap.org/soap/http"/>
			<xsl:for-each select="//portType/operation">
				<xsl:text>    &#10;</xsl:text>
				<xsl:element name="operation" namespace="http://schemas.xmlsoap.org/wsdl/">
					<xsl:attribute name="name" select="./@name"/>					
					<soap:operation soapAction="" style="document"/>					
					<xsl:element name="input" namespace="http://schemas.xmlsoap.org/wsdl/">
						<soap:body use="literal"/>
					</xsl:element>					
					<xsl:element name="output" namespace="http://schemas.xmlsoap.org/wsdl/">
						<soap:body use="literal"/>
					</xsl:element>
					<xsl:for-each select="./fault">
						<xsl:text>    &#10;</xsl:text>
						<xsl:element name="fault" namespace="http://schemas.xmlsoap.org/wsdl/">
							<xsl:attribute name="name" select="@name" />
							<soap:fault use="literal" name="{@name}"/>
						</xsl:element>
					</xsl:for-each>
						
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>

 	<xsl:template match="xs:annotation|xs:annotation/*|wsdl:documentation|wsdl:documentation/*">
	  	<xsl:text></xsl:text>
	</xsl:template>

	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
