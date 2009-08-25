mkdir "build"
set CLASSPATH=%CLASSPATH%;.\lib\calabash.jar;.\lib\saxon9-s9api.jar;.\lib\jing.jar 

java com.xmlcalabash.drivers.Main wsdl-finalize.xpl
java com.xmlcalabash.drivers.Main xsd-finalize.xpl

java com.xmlcalabash.drivers.Main --with-param section.autolabel=1 --with-param section.label.includes.component.label=1 --with-param html.stylesheet=do.css build.xpl 
copy .\util\docbook\html-css\docbook.css .\build\do.css
copy .\src\bookmark-2005-1.xsd .\build\bookmark-2005-1.xsd
copy .\src\dc.xsd .\build\dc.xsd
copy .\src\xml.xsd .\build\xml.xsd
copy .\src\xmldsig.xsd .\build\xmldsig.xsd
copy .\src\xmlenc.xsd .\build\xmlenc.xsd
copy .\src\kxo.xsd .\build\kxo.xsd

java com.xmlcalabash.drivers.Main wsdl-xsd-extract.xpl