<!-- mozrecent.xsl (XSL library) -->
<!-- named templates for extracting entries from the Mozilla Download Mgr dialog's list -->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:NC="http://home.netscape.com/NC-rdf#"
                xmlns:RDF="http://www.w3.org/1999/02/22-rdf-syntax-ns#">

  <xsl:template name="print_entry">
    <xsl:choose>
      <xsl:when test="starts-with(@RDF:about,'file://')">
        <xsl:value-of select="substring-after(@RDF:about,'file://')" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@RDF:about" />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text> = </xsl:text>
    <xsl:value-of select="./NC:URL/@RDF:resource" />

    <!-- dump a linefeed -->
    <xsl:text>
</xsl:text>
  </xsl:template>
</xsl:stylesheet>
