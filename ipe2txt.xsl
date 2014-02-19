<!--  (XSL Transformation) -->
<!--  -->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" />

  <!-- Suppress built-in processing of all text nodes -->
  <xsl:template match="text()"/>
  
  <xsl:template match="text/text()">
    <xsl:value-of select="." />
  </xsl:template>

  <xsl:template match="path">
  <xsl:text>
</xsl:text>
  </xsl:template>

  <xsl:template match="text">
    <xsl:apply-templates/>
  </xsl:template>
</xsl:stylesheet>
