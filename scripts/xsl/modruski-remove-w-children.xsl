<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    exclude-result-prefixes="tei">
    <xsl:output method = "xml" indent="yes" omit-xml-declaration="no" /> 
    <!-- modruski-remove-w-children: copy everything, remove all pc nodes, all nodes children of w -->
    <xsl:include href="copy.xsl"/>
    <xsl:template match="//tei:text//tei:pc"/>
    <xsl:template match="//tei:text//tei:w">
        <xsl:element name="{local-name()}" namespace="http://www.tei-c.org/ns/1.0">
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>

