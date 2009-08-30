<?xml version="1.0" encoding="UTF-8"?>
<!--
    ZedAI_docbook2xhtml.xsl:  customization layer to DocBook5 XSLTs for ZedAI spec
    jpritchett@rfbd.org
    1 April 2009
    Revised, 8 May 2009
        * Added noXHTML2 feature
    Revised, 13 May 2009
        * Added http-equiv metadata to force character encoding
    Revised, 28 May 2009
        * Added custom styling for editor credit on title page
        * Added appendices to the @conformance template
    Revised, 29 May 2009
        * Added bibliographies to the @conformance template
        * Conformance language is now context sensitive

    Features:
        * remark[@role='todo'] is converted to span[@class='todo'] (for styling purposes)
        * Parts of the document with @conformance set will now spit out a "This section is ..." line
        * Paragraphs in the document with @condition='noXHTML2' will now spit out a note regarding the
    dependency, and will set para/@style to "noXHTML2"
        * The editor credit on the title page has custom styling
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:saxon="http://icl.com/saxon"
    xmlns:db="http://docbook.org/ns/docbook"
    xmlns="http://www.w3.org/1999/xhtml">
    
    <xsl:import href="xhtml-1_1/docbook.xsl "/>
    
    <xsl:output method="xhtml" 
        encoding="UTF-8" 
        omit-xml-declaration="no"
        indent="yes"
        exclude-result-prefixes="saxon db"/>

    <xsl:param name="generate.toc">
appendix  toc,title
article/appendix  nop
article   toc,title
book      toc,title,example
chapter   toc,title
part      toc,title
preface   toc,title
qandadiv  toc
qandaset  toc
reference toc,title
sect1     toc
sect2     toc
sect3     toc
sect4     toc
sect5     toc
section   toc
set       toc,title
</xsl:param>
	
<!-- ============================================================================= -->
    <!-- Fill in the docbook placeholder user.head.content template to add an http-equiv meta
        element -->
    
    <xsl:template name="user.head.content">        
        <xsl:element name="meta" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="http-equiv">Content-Type</xsl:attribute>
            <xsl:attribute name="content">text/html; charset=utf-8</xsl:attribute>
        </xsl:element>
    </xsl:template>    
    
<!-- ============================================================================= -->
    <!-- remark[@role='todo'] = span[@class='todo'] -->

    <!-- Note:  template copied from inline.xsl and modified -->
    <xsl:template match="db:remark[@role='todo']">
                <xsl:param name="content">
                    <xsl:call-template name="anchor"/>
                    <xsl:call-template name="simple.xlink">
                        <xsl:with-param name="content">
                            <xsl:apply-templates/>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:param>
                <!-- * if you want output from the inline.charseq template wrapped in -->
                <!-- * something other than a Span, call the template with some value -->
                <!-- * for the 'wrapper-name' param -->
                <xsl:param name="wrapper-name">span</xsl:param>
        <xsl:if test="$show.comments != 0">
                <xsl:element name="{$wrapper-name}" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:attribute name="class">todo</xsl:attribute>
                    <xsl:call-template name="dir"/>
                    <xsl:call-template name="generate.html.title"/>
                    <xsl:copy-of select="$content"/>
                    <xsl:call-template name="apply-annotations"/>
                </xsl:element>
        </xsl:if>
    </xsl:template>

<!-- ============================================================================= -->
    <!-- For chapters, preface, sections, and appendices that have @conformance, add a "This section is ..." line -->
    <!-- We match on title so that we can insert the text after the heading -->
    <xsl:template
        match="db:chapter/db:title|db:preface/db:title|db:section/db:title|db:appendix/db:title|db:bibliography/db:title">
        <xsl:apply-imports />
        <!-- Do everything the normal transform does before adding more text -->
        <xsl:variable name="conformanceLevel" select="../@conformance" />
        <xsl:variable name="structureName">
            <xsl:choose>
                <xsl:when test="local-name(..)='preface'">
                    <xsl:value-of select="'section'" />
                </xsl:when>
                <xsl:when test="local-name(..)='bibliography'">
                    <xsl:value-of select="'section'" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="local-name(..)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:if test="$conformanceLevel != ''">
            <xsl:element name="p" namespace="http://www.w3.org/1999/xhtml">
                <xsl:attribute name="class">
                    <xsl:value-of select="$conformanceLevel" />
                </xsl:attribute> This <xsl:value-of select="$structureName" /> is
                    <xsl:value-of select="$conformanceLevel" />
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    
    
    <!-- ============================================================================= -->
    <!-- add daisy logo -->
    
    <xsl:template name="user.header.content">
        <xsl:element name="a">
            <xsl:attribute name="href">http://www.daisy.org/</xsl:attribute>
            <xsl:element name="img">
                <xsl:attribute name="src">http://www.daisy.org/images/daisylogo-w.gif</xsl:attribute>
                <xsl:attribute name="alt">DAISY Consortium Logo - Link to Home Page</xsl:attribute>
                <xsl:attribute name="width">150</xsl:attribute>
                <xsl:attribute name="height">110</xsl:attribute>
                <xsl:attribute name="border">0</xsl:attribute>
                <xsl:attribute name="class">logo</xsl:attribute>
            </xsl:element>
        </xsl:element>
    </xsl:template>    
    
    
    <!-- ============================================================================= -->
    <!-- add text labels for release info and publication date -->
    
    <xsl:template match="db:releaseinfo" mode="titlepage.mode">
        <xsl:element name="p">
            <xsl:attribute name="class">releaseinfo</xsl:attribute>
            <xsl:text>STATUS: </xsl:text>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="db:pubdate" mode="titlepage.mode">
        <xsl:element name="p">
            <xsl:attribute name="class">pubdate</xsl:attribute>
            <xsl:text>Last update: </xsl:text>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!-- ============================================================================= -->
    <!-- override titlepage hr separators -->
   
    <xsl:template name="book.titlepage.separator"/>
    <xsl:template name="section.titlepage.separator"/>
    
    
    <!-- ============================================================================= -->
    <!-- Change the way credits are done for the editor -->
    <xsl:template match="editor" mode="titlepage.mode">
        <div>
            <xsl:apply-templates select="." mode="class.attribute"/>
            <xsl:if test="self::editor[position()=1] and not($editedby.enabled = 0)">
                <span class="editedby"><xsl:call-template
                    name="gentext.edited.by"/>&#160;&#160;</span>
            </xsl:if>
            <span>
                <xsl:apply-templates select="." mode="class.attribute"/>
                <xsl:choose>
                    <xsl:when test="orgname">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="personname and affiliation">
                        <xsl:call-template name="person.name"/>, <xsl:apply-templates mode="titlepage.mode" select="affiliation"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="person.name"/>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
            <xsl:if test="not($contrib.inline.enabled = 0)">
                <xsl:apply-templates mode="titlepage.mode" select="contrib"/>
            </xsl:if>
            <xsl:if test="not($blurb.on.titlepage.enabled = 0)">
                <xsl:choose>
                    <xsl:when test="$contrib.inline.enabled = 0">
                        <xsl:apply-templates mode="titlepage.mode" select="contrib|authorblurb|personblurb"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates mode="titlepage.mode" select="authorblurb|personblurb"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template match="affiliation" mode="titlepage.mode">
        <span>
            <xsl:apply-templates select="." mode="class.attribute"/>
            <xsl:apply-templates mode="titlepage.mode"/>
        </span>
    </xsl:template>
    
    <xsl:template match="orgname" mode="titlepage.mode">
        <span>
            <xsl:apply-templates select="." mode="class.attribute"/>
            <xsl:apply-templates mode="titlepage.mode"/>
        </span>
    </xsl:template>
    
    
</xsl:stylesheet>
