<?xml version="1.0"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" name="main">
    <!-- exctract an xsd from a wsdl -->
    <p:input port="source">
        <p:document href="./build/do-wsdl-10.wsdl"/>
    </p:input>
    
    <p:input port='parameters' kind='parameter' primary='true'/>
    
    <p:output port="result">
        <p:pipe step="store" port="result"/>
    </p:output>
    
    <p:xslt name="extractXSD">       
        <p:input port="stylesheet">
        <p:document href="./util/xsd/xsd-extract.xsl"/>
        </p:input>      
    </p:xslt>
    
    <p:store href="./build/temp-extracted.xsd" name="store"/>
    
</p:declare-step>