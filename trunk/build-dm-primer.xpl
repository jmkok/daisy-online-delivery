<?xml version="1.0"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" name="main">
    
    <p:input port="source">
        <p:document href="./src/do-dm-primer-10.xml"/>
    </p:input>
    
    <p:input port='parameters' kind='parameter' primary='true'/> 
    
    <p:output port="result">
        <p:pipe step="store" port="result"/>
    </p:output>
        
    <p:xinclude name="xinclude" />
       
    <p:validate-with-relax-ng assert-valid="true" name="validate">
        <p:input port="source">
            <p:pipe step="xinclude" port="result"/>
        </p:input>
        
        <p:input port="schema">
            <p:document href="./util/docbook/rng/docbookxi.rng"/>
        </p:input>
    </p:validate-with-relax-ng>
    
    <p:xslt name="toXHTML">
        <p:input port="source">
            <p:pipe step="validate" port="result"/>
        </p:input>
        
        <p:input port="stylesheet">
            <p:document href="./util/docbook/xslt/ZedAI_docbook2xhtml.xsl"/>
        </p:input>

        <p:input port="parameters">
            <p:pipe step="main" port="parameters"/> 
        </p:input>
        
    </p:xslt>
    
    <p:delete name="cleanup" match="comment()|@xml:space" />
            
    <p:store href="./build/do-dm-primer-10.html" name="store" />
    
</p:declare-step>
