<?xml version="1.0" encoding="UTF-8"?>
<!--

    This stylesheet expects oai/dc records
-->
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
>

 <xsl:output indent="yes"
        method="xml"
        version="1.0"
        encoding="UTF-8"/>

  <xsl:include href="xml-to-string.xsl" />
      <xsl:variable name="fullrecord">
        <xsl:call-template name="xml-to-string"/>
    </xsl:variable>


  <xsl:template match="/rdf:RDF/*">
    <pz:record>



      <xsl:attribute name="mergekey">
        <xsl:text>title </xsl:text>
	<xsl:value-of select="dc:title[1]"/>
	<xsl:text> author </xsl:text>
	<xsl:value-of select="dc:creator[1]"/>
      </xsl:attribute>

      <pz:metadata type="id">
        <xsl:value-of select="dc:identifier"/>
      </pz:metadata>

      <pz:metadata type="fullrecord"><xsl:value-of select="$fullrecord"/></pz:metadata>

      <xsl:for-each select="dc:title">
        <pz:metadata type="title">
          <xsl:value-of select="."/>
        </pz:metadata>
      </xsl:for-each>

      <xsl:for-each select="dc:date">
        <pz:metadata type="date">
	  <xsl:value-of select="."/>
	</pz:metadata>
      </xsl:for-each>

      <xsl:for-each select="dc:subject">
        <pz:metadata type="subject">
	  <xsl:value-of select="."/>
	</pz:metadata>
      </xsl:for-each>

      <xsl:for-each select="dc:creator">
	<pz:metadata type="author">
          <xsl:value-of select="."/>
	</pz:metadata>
      </xsl:for-each>

      <xsl:for-each select="dc:description">
        <pz:metadata type="description">
	  <xsl:value-of select="."/>
	</pz:metadata>
      </xsl:for-each>

      <xsl:for-each select="dc:identifier">
        <pz:metadata type="electronic-url">
	  <xsl:value-of select="."/>
	</pz:metadata>
      </xsl:for-each>

      <xsl:for-each select="dc:type">
        <pz:metadata type="medium">
	  <xsl:value-of select="."/>
	</pz:metadata>
      </xsl:for-each>


    </pz:record>
  </xsl:template>


  <xsl:template match="text()"/>

</xsl:stylesheet>
