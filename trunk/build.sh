#!/bin/sh
if [ ! -d ./build/ ]
then
    mkdir "build"
fi

cp=./lib/calabash.jar:./lib/saxon9-s9api.jar:./lib/jing.jar
java -cp $cp com.xmlcalabash.drivers.Main --with-param section.autolabel=1 --with-param section.label.includes.component.label=1 --with-param html.stylesheet=do.css build.xpl 
cp ./util/docbook/html-css/docbook.css ./build/do.css
java -cp $cp com.xmlcalabash.drivers.Main wsdl-finalize.xpl
cp ./src/do-types-10.xsd ./build/do-types-10.xsd
