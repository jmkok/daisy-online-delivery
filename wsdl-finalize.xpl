<?xml version="1.0"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" name="main" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">
    
    <p:input port="source">
        <p:document href="./src/do-wsdl-10.wsdl"/>
    </p:input>
    
    <p:input port='parameters' kind='parameter' primary='true'/>
       
    <p:output port="result">
      <p:pipe step="store" port="result"/>
    </p:output>
      
    <p:xslt name="finalizeWSDL">       
        <p:input port="stylesheet">
            <p:document href="./util/wsdl/wsdl-finalize.xsl"/>
        </p:input>      
	</p:xslt>

    <p:xslt name="indent">       
        <p:input port="stylesheet">
            <p:document href="./util/indent.xsl"/>
        </p:input>      
    </p:xslt>
    
    <!--
    <p:insert name="insertVersion" match="wsdl:definitions" position="first-child">
        <p:input port="insertion">
            <p:inline>
                <documentation xmlns="http://schemas.xmlsoap.org/wsdl/">
                    This WSDL document and the entities referenced from within it are a normative part
                    of the DAISY Online Protocol Specification (http://www.daisy.org/projects/daisy-online-delivery/). 
                    
                    Version: 20090910 (Second Working Group Draft)
                </documentation>                
            </p:inline>
        </p:input>        
    </p:insert>    -->

	<p:store href="./build/do-wsdl-10.wsdl" name="store"/>
	
</p:declare-step>