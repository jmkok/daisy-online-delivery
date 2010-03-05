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
	<xsl:output method="xml" omit-xml-declaration="no" indent="no"/>

	<xsl:variable name="wsdl" select="document('../../../src/do-wsdl-10.wsdl')"/>

	<xsl:template match="db:chapter[@xml:id='apiReference']">
		<db:chapter xml:id="apiReference" conformance="normative">
			<db:title>API Reference</db:title>
			<db:section xml:id="apiReferenceRequired">
				<db:title>Required Operations</db:title>
				<db:para>This section documents the protocol operations that all <db:xref linkend="term_service"/>s must support.</db:para>
				<xsl:call-template name="wsdlOperationsAsDocbook">
					<xsl:with-param name="operations" 
						select="$wsdl/definitions/portType/operation[count(descendant::fault[@message='tns:operationNotSupportedFault_message'])=0]"/>
				</xsl:call-template>
			</db:section>
			
			<db:section xml:id="apiReferenceOptional">
				<db:title>Optional Operations</db:title>
				<db:para>This section documents additional protocol operations that a <db:xref linkend="term_service"/> may support. Refer to
					<db:xref linkend="fundamentals_content_selection"/> for 
				conditions when certain of these optional operations become required.</db:para>
				
				<xsl:call-template name="wsdlOperationsAsDocbook">
					<xsl:with-param name="operations" 
						select="$wsdl/definitions/portType/operation[descendant::fault[@message='tns:operationNotSupportedFault_message']]"/> 
				</xsl:call-template>
			</db:section>
			
			<db:section xml:id="apiReferenceFaults">
				<db:title>Faults</db:title>
				<db:para>When a Service responds to an operation with a SOAP fault, an instance of one of the following
				types must be the child of the <db:type>detail</db:type> element.</db:para>
				<db:para>Each of these fault types has a <db:type>reason</db:type> child element, a
				<db:type>string</db:type> which can be used to send debugging information to the Reading System.
				This information should not be rendered to the User in most circumstances.</db:para>
				<xsl:for-each select="$wsdl/definitions/message[contains(@name, 'Fault')]">
					<db:section> <xsl:attribute name="xml:id" select="replace(concat('ft_',@name),'_message','')"/>
						<xsl:attribute name="xreflabel" select="replace(@name,'Fault_message','')"/>
						<xsl:variable name="conc" select="replace(@name,'Fault_message','')" />							
						<db:title>The <db:errorname><xsl:value-of select="$conc"/></db:errorname> Fault</db:title>
						<xsl:call-template name="getWSDLDocumentation">
							<xsl:with-param name="node" as="element()" select="current()/part"/>
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
								
				<db:variablelist>
					<!-- request message parameter info, if parameters are specificed -->
					
					<!-- get the request message element, truncate 'tns:' -->
					<xsl:variable name="requestMessage"
						select="$wsdl/definitions/message[@name=substring(current()/input/@message,5)]"
						as="element()"/>
					
					<!-- Get the xs:element that represents the message (wrapper), truncate 'tns:' -->
					<xsl:variable name="requestMessageXsdWrapperElement" 
						select="$wsdl/definitions/types/xs:schema/xs:element[@name=substring($requestMessage/part/@element,5)]"
						as="element()"/>
					
					<db:varlistentry>
						<db:term>Request parameters</db:term>
						<!-- 
							<xs:complexType><xs:sequence><xs:element>* == has parameters
							<xs:complexType><xs:annotation> == no parameters
						-->						
						<db:listitem>
							<xsl:choose>
								<xsl:when test="$requestMessageXsdWrapperElement/xs:complexType/xs:sequence/xs:element">
									<db:variablelist>
										<xsl:for-each select="$requestMessageXsdWrapperElement/xs:complexType/xs:sequence/xs:element">
											<db:varlistentry>
												<db:term>
													<!-- the parameter name -->
													<xsl:choose>
														<xsl:when test="@name">
															<xsl:value-of select="@name"/>
														</xsl:when>
														<xsl:when test="@ref">
															<xsl:value-of select="substring-after(@ref,':')"/>
														</xsl:when>
														<xsl:otherwise>
															Unnamed
														</xsl:otherwise>
													</xsl:choose>													
												</db:term>
												<db:listitem>
													<xsl:call-template name="getWSDLTypeInfo">
														<xsl:with-param name="xsdElement" select="current()" />
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
									<!-- No parameters, still get the documentation though -->
									<xsl:call-template name="getWSDLDocumentation">
										<xsl:with-param name="node" as="element()" select="$requestMessageXsdWrapperElement/xs:complexType"/>
									</xsl:call-template>	
								</xsl:otherwise>
							</xsl:choose>
						</db:listitem>
					</db:varlistentry>
					<!-- response type, if specified -->
					<db:varlistentry>
						<db:term>Response</db:term>
						<db:listitem>
							<xsl:choose>
								<!-- when the operation has an output -->
								<xsl:when test="current()/output">
									<xsl:variable name="responseMessage"
										select="$wsdl/definitions/message[@name=substring(current()/output/@message,5)]"
										as="element()"/>
									
									<!-- Get the xs:element that represents the message (wrapper), truncate 'tns:' -->
									<xsl:variable name="responseMessageXsdWrapperElement" 
										select="$wsdl/definitions/types/xs:schema/xs:element[@name=substring($responseMessage/part/@element,5)]"
										as="element()"/>
									
									<xsl:call-template name="getWSDLTypeInfo">
										<xsl:with-param name="xsdElement" as="element()"
											select="$responseMessageXsdWrapperElement/xs:complexType/xs:sequence/xs:element"/>
									</xsl:call-template>
									<xsl:call-template name="getWSDLDocumentation">
										<xsl:with-param name="node" as="element()" 
												select="$responseMessageXsdWrapperElement/xs:complexType/xs:sequence/xs:element"/>
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
													select="replace(concat('ft_',$wsdl/definitions/message[@name=substring(current()/@message,5)]/@name),'_message','')" />
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
		<!-- Print everything in the WSDL documentation element, alternativey
			an inline xs:annotation/xs:documentation element. If the 
		  documentation element is text only, turn into para[@role="desc"], 
		  else verbatim copy -->
		
		<!-- the input node is the parent of the wanted documentation or xs:annotation element -->
		<xsl:param name="node" as="element()"/>
		
		<!-- get the wsdl:documentation or the xs:documentation element -->
		<xsl:variable name="dbParent" as="element()" select="$node/documentation|$node/xs:annotation/xs:documentation"/>
		
		<xsl:if test="$dbParent">
			<xsl:choose>
				<xsl:when test="$dbParent/db:*">
					<xsl:copy-of select="$dbParent/db:*"/>
				</xsl:when>
				<xsl:otherwise>
					<db:para role="desc">
						<xsl:copy-of select="$dbParent/text()"/>
					</db:para>
				</xsl:otherwise>
			</xsl:choose>	
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="getWSDLTypeInfo">
		<!-- Print a db:para with type info -->
		<!-- the input node is the wsdl xsd wrapper element -->
		<xsl:param name="xsdElement" as="element()"/>		
		<db:para><xsl:text>Type: </xsl:text>
			<xsl:choose>
				<!-- the special case of the abstract itemList
				<xsl:when test="$xsdElement[@type and contains(@type,'itemList')]">
					A <db:code><xsl:value-of select="@name"/></db:code> element with one or several 
					<db:xref linkend="tp_item"/> element children.
					</xsl:when>  -->
				
				<!-- the primitive xsd types (element type="xs:*") -->
				<xsl:when test="$xsdElement/@type and starts-with($xsdElement/@type,'xs:')">
					<db:link>
						<xsl:attribute name="xlink:href"><xsl:value-of 
							select="concat('http://www.w3.org/TR/xmlschema-2/#',substring-after($xsdElement/@type,'xs:'))" />
						</xsl:attribute>
						<xsl:value-of select="$xsdElement/@type" />
					</db:link><xsl:text> </xsl:text> 
					<db:xref linkend="bib_xsdDatatypes"/>
				</xsl:when>
				<!-- type refs -->
				<xsl:when test="$xsdElement/@ref">
					<xsl:text> </xsl:text>
					<db:xref>
						<xsl:choose>
							<xsl:when test="contains($xsdElement/@ref,':')">
								<xsl:attribute name="linkend" select="concat('tp_',substring-after($xsdElement/@ref,':'))" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="linkend" select="concat('tp_',$xsdElement/@ref)" />
							</xsl:otherwise>
						</xsl:choose>
					</db:xref>
				</xsl:when>				
				<xsl:otherwise>
					<xsl:comment>TODO Fix final else clause in wsdl2docbook.xsl</xsl:comment>
					<db:remark role="todo">TODO Fix final else clause in wsdl2docbook.xsl</db:remark>
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