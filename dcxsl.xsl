<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/"

>
  <xsl:output method="html"/>

  <xsl:template match="/rdf:RDF/*">
    <p class="title">Title:</p>
    <input type="text">
      <xsl:attribute name="class">dcEditor-title</xsl:attribute>
      <xsl:attribute name="value"><xsl:value-of select="dc:title"/></xsl:attribute>
    </input>

    <p class="creator">Creator:</p>
    <input type="text">
      <xsl:attribute name="class">dcEditor-creator</xsl:attribute>
      <xsl:attribute name="value"><xsl:value-of select="dc:creator"/></xsl:attribute>
    </input>

    <p class="description">Description:</p>
    <input type="text">
      <xsl:attribute name="class">dcEditor-description</xsl:attribute>
      <xsl:attribute name="value"><xsl:value-of select="dc:description"/></xsl:attribute>
    </input>

    <p class="date">Date:</p>
    <input type="text">
      <xsl:attribute name="class">dcEditor-date</xsl:attribute>
      <xsl:attribute name="value"><xsl:value-of select="dc:date"/></xsl:attribute>
    </input>

    <p class="identifier">Identifier:</p>
    <input type="text">
      <xsl:attribute name="class">dcEditor-identifier</xsl:attribute>
      <xsl:attribute name="value"><xsl:value-of select="dc:identifier"/></xsl:attribute>
    </input>
  </xsl:template>
</xsl:stylesheet>
