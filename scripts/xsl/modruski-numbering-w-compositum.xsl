<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    exclude-result-prefixes="tei">
    <xsl:output method = "xml" indent="yes" omit-xml-declaration="no" /> 
    <!-- copy everything, for w/w elements, copy parent @n, add a, b -->
    <xsl:include href="copy.xsl"/>
    <xsl:template match="//tei:text//tei:w[@ana='compositum']/tei:w[1]">
        <xsl:element name="{local-name()}" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n" xmlns:tei="http://www.tei-c.org/ns/1.0"><xsl:value-of select="concat(../@n, 'a')"/></xsl:attribute> 
            <xsl:apply-templates select="@lemma | @lemmaRef | @ana | node()"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="//tei:text//tei:w[@ana='compositum']/tei:w[2]">
        <xsl:element name="{local-name()}" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n" xmlns:tei="http://www.tei-c.org/ns/1.0"><xsl:value-of select="concat(../@n, 'b')"/></xsl:attribute> 
            <xsl:apply-templates select="@lemma | @lemmaRef | @ana | node()"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>

