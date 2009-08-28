#!/bin/sh
if [ ! -d ./build/ ]
then
    mkdir "build"
fi

#cp=./lib/calabash.jar:./lib/saxon9-s9api.jar:./lib/jing_20090818.jar:./lib/saxon9.jar
cp=./lib/calumet.jar:./lib/xercesImpl.jar:./lib/xml-apis.jar:./lib/serializer.jar:./lib/commons-httpclient-3.1.jar:./lib/commons-logging-1.1.1.jar:./lib/commons-codec-1.3.jar:./lib/jing.jar:./lib/saxon9.jar:./lib/saxon9-dom.jar:./lib/xalan.jar

#java -cp $cp com.xmlcalabash.drivers.Main wsdl-finalize.xpl
java -cp $cp com.emc.documentum.xml.xproc.tool.Cmd wsdl-finalize.xpl

#java -cp $cp com.xmlcalabash.drivers.Main xsd-finalize.xpl
java -cp $cp com.emc.documentum.xml.xproc.tool.Cmd xsd-finalize.xpl

#java -cp $cp com.xmlcalabash.drivers.Main --with-param section.autolabel=1 --with-param section.label.includes.component.label=1 --with-param html.stylesheet=do.css build.xpl 
java -cp $cp com.emc.documentum.xml.xproc.tool.Cmd -p section.autolabel=1 -p section.label.includes.component.label=1 -p html.stylesheet=do.css build.xpl 

cp ./util/docbook/html-css/docbook.css ./build/do.css
cp ./src/bookmark-2005-1.xsd ./build/bookmark-2005-1.xsd
cp ./src/dc.xsd ./build/dc.xsd
cp ./src/xml.xsd ./build/xml.xsd
cp ./src/xmldsig.xsd ./build/xmldsig.xsd
cp ./src/xmlenc.xsd ./build/xmlenc.xsd
cp ./src/kxo.xsd ./build/kxo.xsd

#java -cp $cp com.xmlcalabash.drivers.Main wsdl-xsd-extract.xpl
java -cp $cp com.emc.documentum.xml.xproc.tool.Cmd wsdl-xsd-extract.xpl