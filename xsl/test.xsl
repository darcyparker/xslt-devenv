<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="1.0">
  <xsl:output
    method="xml"
    version="1.0"
    encoding="UTF-8"
    indent="yes"
    />

  <!--Identity Transform-->
  <xsl:template match="@*|*">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/">
    <xsl:message terminate="no"><xsl:value-of select="concat('xslt processor: ',system-property('xsl:vendor-url'))"/></xsl:message>
    <xsl:apply-templates select="node()"/>
  </xsl:template>
</xsl:stylesheet>
