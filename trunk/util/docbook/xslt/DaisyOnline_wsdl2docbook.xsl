<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:db="http://docbook.org/ns/docbook" version="2.0"
	xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
	xpath-default-namespace="http://schemas.xmlsoap.org/wsdl/"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="db wsdl">
	<!--
		Transform a docbook instance to a docbook instance, inserting data
		from a WSDL doc in a predefined slot.
		
		The generated xml uses a predictable id generation, so that its members can be referenced safely 
		in surrounding parts of the host document
	-->
	<xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>

	<xsl:variable name="wsdl" select="document('../../../src/do-wsdl-10.wsdl')"/>

	<xsl:template match="db:chapter[@xml:id='apiReference']">
		<db:chapter xml:id="apiReference" conformance="normative">
			<db:title>API Reference</db:title>
			<db:section xml:id="apiReferenceCore">
				<db:title>Core Interface</db:title>
				<xsl:call-template name="wsdlOperationsAsDocbook">
					<xsl:with-param name="portTypeName">daisy-online-core</xsl:with-param>
				</xsl:call-template>
			</db:section>
			<db:section xml:id="apiReferenceExtended">
				<db:title>Extended Interface</db:title>
				<db:para>TBD</db:para>
			</db:section>
		</db:chapter>
	</xsl:template>

	<xsl:template name="wsdlOperationsAsDocbook">
		<!-- print all operations being children of inparam porttype as docbook -->
		<xsl:param name="portTypeName" as="xs:string"/>

		<xsl:variable name="operations" as="element()*"
			select="$wsdl/definitions/portType[@name=$portTypeName]/operation"/>

		<xsl:for-each select="$operations">
			<db:section>
				<xsl:attribute name="xml:id" select="concat('op_',@name)"/>
				<db:title>The <xsl:value-of select="@name"/> Operation</db:title>

				<!-- the operation shortdesc -->
				<xsl:call-template name="getWSDLShortDesc">
					<xsl:with-param name="node" as="element()" select="current()"/>
				</xsl:call-template>

				<!-- get the request and response message elements, truncate 'tns:' -->
				<xsl:variable name="requestMessage"
					select="$wsdl/definitions/message[@name=substring(current()/input/@message,5)]"
					as="element()"/>
				<xsl:variable name="responseMessage"
					select="$wsdl/definitions/message[@name=substring(current()/output/@message,5)]"
					as="element()"/>

				<db:variablelist>
					<!-- request message parameter info, if parameters are specificed -->
					<db:varlistentry>
						<db:term>Request parameters</db:term>
						<db:listitem>
							<xsl:choose>
								<xsl:when test="$requestMessage/part">
									<db:variablelist>
										<xsl:for-each select="$requestMessage/part">
											<db:varlistentry>
												<db:term>
													<xsl:value-of select="@name"/>
												</db:term>
												<db:listitem>
													<db:para>Type: <xsl:value-of select="@element"/></db:para>
													<xsl:call-template name="getWSDLShortDesc">
														<xsl:with-param name="node" as="element()" select="current()"/>
													</xsl:call-template>
												</db:listitem>
											</db:varlistentry>
										</xsl:for-each>
									</db:variablelist>
								</xsl:when>
								<xsl:otherwise>
									<db:para>This operation has zero request parameters.</db:para>
								</xsl:otherwise>
							</xsl:choose>
						</db:listitem>
					</db:varlistentry>
					<!-- response type, if specified -->
					<db:varlistentry>
						<db:term>Response Type</db:term>
						<db:listitem>
							<xsl:choose>
								<xsl:when test="$responseMessage/part">
									<db:para>Type: <xsl:value-of select="$responseMessage/part/@element"/></db:para>
									<xsl:call-template name="getWSDLShortDesc">
										<xsl:with-param name="node" as="element()"
											select="$responseMessage/part"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<db:para>This operation has no return value.</db:para>
								</xsl:otherwise>
							</xsl:choose>
						</db:listitem>
					</db:varlistentry>
					<!-- Exceptions -->
					<db:varlistentry>
						<db:term>Faults</db:term>
						<db:listitem>
							<xsl:choose>
								<xsl:when test="./fault">
									<db:variablelist>
									<xsl:for-each select="./fault">
										<xsl:variable name="faultMessage"
											select="$wsdl/definitions/message[@name=substring(current()/@message,5)]"
											as="element()"/>
										<db:varlistentry>
										<db:term>
											<xsl:value-of select="$faultMessage/@name"/> </db:term>
										<db:listitem>
											<xsl:call-template name="getWSDLShortDesc">
												<xsl:with-param name="node" as="element()"
													select="$faultMessage"/>
											</xsl:call-template>
										</db:listitem>
										</db:varlistentry>
									</xsl:for-each>
									</db:variablelist>
								</xsl:when>
								<xsl:otherwise>
									<db:para>This operation defines no faults.</db:para>
								</xsl:otherwise>
							</xsl:choose>
						</db:listitem>
					</db:varlistentry>

				</db:variablelist>

			</db:section>
		</xsl:for-each>

	</xsl:template>

	<xsl:template name="getWSDLShortDesc">

		<!-- Get an item's shortdesc from a WSDL documentation element. This is defined
		as either a documentation element with only text children, or a db:para[@role='desc'] 
		child of a WSDL documentation element. -->

		<!-- the input node is the parent of the wanted documentation element -->
		<xsl:param name="node" as="element()"/>

		<xsl:if test="$node/documentation">
			<xsl:choose>
				<xsl:when test="$node/documentation/db:para[@role='desc']">
					<xsl:copy-of select="$node/documentation/db:para[@role='desc']"/>
				</xsl:when>
				<xsl:otherwise>
					<db:para role="desc">
						<xsl:copy-of select="$node/documentation/text()"/>
					</db:para>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
