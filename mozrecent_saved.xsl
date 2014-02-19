<!-- mozrecent_saved.xsl (XSL library) -->
<!-- extracts entries from the Mozilla Download Mgr dialog's list -->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:NC="http://home.netscape.com/NC-rdf#"
                xmlns:RDF="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <xsl:output method="text" />

  <xsl:include href="libmozrecent.xsl" />

  <!-- Suppress built-in processing of all text nodes -->
  <xsl:template match="text()"/>
  
<!--#
  <xsl:template match="">
    <xsl:apply-templates/>
  </xsl:template>
-->

  <xsl:template match="RDF:Description[not (starts-with(@RDF:about,'/tmp') or starts-with(@RDF:about,'file:///tmp'))]">
    <xsl:call-template name="print_entry" /> 
  </xsl:template>

  <!-- copy RDF:Seq and all descendents -->
<!--#
  <xsl:template match="RDF:Seq|RDF:Seq/*|RDF:Seq/text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

-->
</xsl:stylesheet>
