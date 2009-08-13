<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:db="http://docbook.org/ns/docbook" version="2.0"
	xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
	xpath-default-namespace="http://schemas.xmlsoap.org/wsdl/"
	xmlns:xlink="http://www.w3.org/1999/xlink"
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
			<db:section xml:id="apiReferenceBasic">
				<db:title>Required Operations</db:title>
				<xsl:call-template name="wsdlOperationsAsDocbook">
					<xsl:with-param name="operations" 
						select="$wsdl/definitions/portType/operation[count(descendant::fault[@message='tns:OperationNotSupportedFault'])=0]"/>
				</xsl:call-template>
			</db:section>
			
			<db:section xml:id="apiReferenceAdvanced">
				<db:title>Optional Operations</db:title>
				<xsl:call-template name="wsdlOperationsAsDocbook">
					<xsl:with-param name="operations" 
					select="$wsdl/definitions/portType/operation[descendant::fault[@message='tns:OperationNotSupportedFault']]"/> 
				</xsl:call-template>
			</db:section>
			
			<db:section xml:id="apiReferenceFaults">
				<db:title>Faults</db:title>
				<xsl:for-each select="$wsdl/definitions/message[contains(@name, 'Fault')]">
					<db:section> <xsl:attribute name="xml:id" select="concat('ft_',@name)"/>
						<xsl:attribute name="xreflabel" select="@name"/>
						<xsl:variable name="conc" select="replace(@name,'Fault','')" />							
						<db:title>The <db:errorname><xsl:value-of select="$conc"/></db:errorname> Fault</db:title>
						<xsl:call-template name="getWSDLDocumentation">
							<xsl:with-param name="node" as="element()" select="current()"/>
						</xsl:call-template>
					</db:section>
				</xsl:for-each>
			</db:section>
		</db:chapter>
	</xsl:template>

	<xsl:template name="wsdlOperationsAsDocbook">
		<!-- print all inparam operations as docbook -->
		<xsl:param name="operations" as="element()*"/>

		<xsl:for-each select="$operations">
			<db:section>
				<xsl:attribute name="xml:id" select="concat('op_',@name)"/>
				<xsl:attribute name="xreflabel" select="@name"/>

				<db:title>The <db:function><xsl:value-of select="@name"/></db:function> Operation</db:title>
				
				<xsl:call-template name="getWSDLDocumentation">
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
													<xsl:call-template name="getWSDLTypeInfo">
														<xsl:with-param name="node" select="@element" />
													</xsl:call-template>
													<xsl:call-template name="getWSDLDocumentation">
														<xsl:with-param name="node" as="element()" select="current()"/>
													</xsl:call-template>
												</db:listitem>
											</db:varlistentry>
										</xsl:for-each>
									</db:variablelist>
								</xsl:when>
								<xsl:otherwise>
									<db:para>This operation has no request parameters.</db:para>
								</xsl:otherwise>
							</xsl:choose>
						</db:listitem>
					</db:varlistentry>
					<!-- response type, if specified -->
					<db:varlistentry>
						<db:term>Response</db:term>
						<db:listitem>
							<xsl:choose>
								<xsl:when test="$responseMessage/part">
									<xsl:call-template name="getWSDLTypeInfo">
										<xsl:with-param name="node" as="attribute()"
											select="$responseMessage/part/@element"/>
									</xsl:call-template>
									<xsl:call-template name="getWSDLDocumentation">
										<xsl:with-param name="node" as="element()" select="$responseMessage/part"/>
									</xsl:call-template>				
								</xsl:when>
								<xsl:otherwise>
									<db:para>This operation has no response.</db:para>
								</xsl:otherwise>
							</xsl:choose>
						</db:listitem>
					</db:varlistentry>
					<!-- Faults -->
					<db:varlistentry>
						<db:term>Faults</db:term>
						<db:listitem>
							<xsl:choose>
								<xsl:when test="./fault">
									<db:para>										
										<xsl:for-each select="./fault">
											<db:xref>
												<xsl:attribute name="linkend" 
													select="concat('ft_',$wsdl/definitions/message[@name=substring(current()/@message,5)]/@name)" />
											</db:xref>	
											<xsl:if test="position() != last()">, </xsl:if>
										</xsl:for-each>									
									</db:para>
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

	<xsl:template name="getWSDLDocumentation">
		<!-- Print everything in the WSDL documentation element. If the 
		  documentation element is text only, turn into para[@role="desc"], 
		  else verbatim copy -->
		<!-- the input node is the parent of the wanted documentation element -->
		<xsl:param name="node" as="element()"/>
		
		<xsl:if test="$node/documentation">
			<xsl:choose>
				<xsl:when test="$node/documentation/db:*">
					<xsl:copy-of select="$node/documentation/db:*"/>
				</xsl:when>
				<xsl:otherwise>
					<db:para role="desc">
						<xsl:copy-of select="$node/documentation/text()"/>
					</db:para>
				</xsl:otherwise>
			</xsl:choose>	
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="getWSDLTypeInfo">
		<!-- Print a db:para with type info -->
		<!-- the input node is the wsdl "element" attribute -->
		<xsl:param name="node" as="attribute()"/>		
		<db:para>Type:
			<xsl:choose>
				<xsl:when test="starts-with($node,'xsd:')">
					<db:link>
						<xsl:attribute name="xlink:href"><xsl:value-of 
							select="concat('http://www.w3.org/TR/xmlschema-2/#',substring-after($node,'xsd:'))" />
						</xsl:attribute>
						<xsl:value-of select="$node" />
					</db:link> 
					<db:xref linkend="bib_xsdDatatypes"/>
				</xsl:when>
				<xsl:otherwise>
					<db:xref>
						<xsl:attribute name="linkend" select="concat('tp_',substring($node,5))" />
					</db:xref>
				</xsl:otherwise>
			</xsl:choose>
		</db:para>
	</xsl:template>
	

	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

	<xsl:template name="getWSDLShortDesc">
		
		<!-- Print a db:para with an item's shortdesc from a WSDL documentation element. This is defined
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
	
	<xsl:template name="getWSDLOtherDesc">
		<!-- Print everything in the docbook namespace that doesnt match shortdesc -->
		<!-- the input node is the parent of the wanted documentation element -->
		<xsl:param name="node" as="element()"/>
		
		<xsl:if test="$node/documentation">
			<xsl:if test="$node/documentation/db:*">
				<xsl:copy-of select="$node/documentation/db:*[@role!='desc']"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
