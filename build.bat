mkdir "build"

REM set CLASSPATH=%CLASSPATH%;.\lib\calabash.jar;.\lib\saxon9-s9api.jar;.\lib\jing_20090818.jar;.\lib\saxon9.jar
set CLASSPATH=%CLASSPATH%;.\lib\calumet.jar;.\lib\xercesImpl.jar;.\lib\xml-apis.jar;.\lib\serializer.jar;.\lib\commons-httpclient-3.1.jar;.\lib\commons-logging-1.1.1.jar;.\lib\commons-codec-1.3.jar;.\lib\jing.jar;.\lib\saxon9.jar;.\lib\saxon9-dom.jar;.\lib\xalan.jar


REM java com.xmlcalabash.drivers.Main wsdl-finalize.xpl
java com.emc.documentum.xml.xproc.tool.Cmd wsdl-finalize.xpl

REM java com.xmlcalabash.drivers.Main xsd-finalize.xpl
java com.emc.documentum.xml.xproc.tool.Cmd xsd-finalize.xpl

REM java com.xmlcalabash.drivers.Main --with-param section.autolabel=1 --with-param section.label.includes.component.label=1 --with-param html.stylesheet=do.css build.xpl 
java com.emc.documentum.xml.xproc.tool.Cmd -p section.autolabel=1 -p section.label.includes.component.label=1 -p html.stylesheet=do.css build.xpl 

REM java com.xmlcalabash.drivers.Main --with-param section.autolabel=1 --with-param section.label.includes.component.label=1 --with-param html.stylesheet=do.css build-dm-primer.xpl 
java com.emc.documentum.xml.xproc.tool.Cmd -p section.autolabel=1 -p section.label.includes.component.label=1 -p html.stylesheet=do.css build-dm-primer.xpl 

copy .\util\docbook\html-css\docbook.css .\build\do.css
copy .\src\bookmark-2005-1.xsd .\build\bookmark-2005-1.xsd

REM java com.xmlcalabash.drivers.Main wsdl-xsd-extract.xpl
java com.emc.documentum.xml.xproc.tool.Cmd wsdl-xsd-extract.xpl