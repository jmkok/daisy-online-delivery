#!/bin/sh
if [ ! -d ./build/ ]
then
    mkdir "build"
fi

cp=./lib/calabash.jar:./lib/saxon9-s9api.jar:./lib/jing.jar

java -cp $cp com.xmlcalabash.drivers.Main wsdl-finalize.xpl
java -cp $cp com.xmlcalabash.drivers.Main xsd-finalize.xpl

java -cp $cp com.xmlcalabash.drivers.Main --with-param section.autolabel=1 --with-param section.label.includes.component.label=1 --with-param html.stylesheet=do.css build.xpl 
cp ./util/docbook/html-css/docbook.css ./build/do.css
cp ./src/bookmark-2005-1.xsd ./build/bookmark-2005-1.xsd
cp ./src/dc.xsd ./build/dc.xsd
cp ./src/xml.xsd ./build/xml.xsd
cp ./src/xmldsig.xsd ./build/xmldsig.xsd
cp ./src/xmlenc.xsd ./build/xmlenc.xsd
cp ./src/kxo.xsd ./build/kxo.xsd

java -cp $cp com.xmlcalabash.drivers.Main wsdl-xsd-extract.xpl