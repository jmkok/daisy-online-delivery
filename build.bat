mkdir "build"
set CLASSPATH=%CLASSPATH%;.\lib\calabash.jar;.\lib\saxon9-s9api.jar;.\lib\jing.jar 
java com.xmlcalabash.drivers.Main --with-param section.autolabel=1 --with-param section.label.includes.component.label=1 --with-param html.stylesheet=do.css build.xpl 
copy .\util\docbook\html-css\docbook.css .\build\do.css
java com.xmlcalabash.drivers.Main wsdl-finalize.xpl
copy .\src\do-types-10.xsd .\build\do-types-10.xsd
copy .\src\bookmark-2005-1.xsd .\build\bookmark-2005-1.xsd