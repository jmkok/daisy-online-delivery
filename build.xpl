<?xml version="1.0"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" name="main">
    
    <p:input port="source">
        <p:document href="./src/do-spec-10.xml"/>
    </p:input>
    
    <p:input port='parameters' kind='parameter' primary='true'/> 
    
    <p:output port="result">
      <p:pipe step="store" port="result"/>
    </p:output>

    <p:xinclude />
 
	<p:validate-with-relax-ng assert-valid="true" name="validate">
	    <p:input port="schema">
            <p:document href="./util/docbook/rng/docbookxi.rng"/>
        </p:input>
    </p:validate-with-relax-ng>
    
    <p:xslt name="style">
        <p:input port="source">
            <p:pipe step="validate" port="result"/>
        </p:input>
        
        <p:input port="stylesheet">
            <p:document href="./util/docbook/xslt/ZedAI_docbook2xhtml.xsl"/>
        </p:input>
 <!--       
        <p:with-param name="section.autolabel" select="1"/>
        <p:with-param name="section.label.includes.component.label" select="1"/>
        <p:with-param name="html.stylesheet" select="do.css"/>   
-->        
        <p:input port="parameters">
          <p:pipe step="main" port="parameters"/> 
  		</p:input>
                 
    </p:xslt>
    
    <p:store href="./build/do-spec-10.html" name="store"/>

</p:declare-step>
