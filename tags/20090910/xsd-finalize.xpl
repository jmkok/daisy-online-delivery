<?xml version="1.0"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" name="main">
    
    <p:input port="source">
        <p:document href="./src/do-types-10.xsd"/>
    </p:input>
    
    <p:input port='parameters' kind='parameter' primary='true'/>
       
    <p:output port="result">
      <p:pipe step="store" port="result"/>
    </p:output>
      
    <p:xslt name="finalizeXSD">       
        <p:input port="stylesheet">
            <p:document href="./util/xsd/xsd-finalize.xsl"/>
        </p:input>      
	</p:xslt>

    <p:xslt name="indent">       
        <p:input port="stylesheet">
            <p:document href="./util/indent.xsl"/>
        </p:input>      
	</p:xslt>
 		
	<p:store href="./build/do-types-10.xsd" name="store"/>
	
</p:declare-step>