<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:f="http://github.com/darcyparker/"
  exclude-result-prefixes="f xs"
  version="2.0">

  <xsl:output
    method="xml"
    version="1.0"
    encoding="UTF-8"
    indent="yes"
    />

  <!-- Pass in the filename to parse using a parameter -->
  <xsl:param name="inputcsvFilePath" as="xs:string"/>

  <!-- Read in inputcsvFileName into a string named input.csv -->
  <!-- Also, for convenience on Windows machines: Replace \ path separator with / -->
  <xsl:variable name="input.csv" select="unparsed-text(replace($inputcsvFilePath,'\\','/'))"/>

  <xsl:function name="f:parseCSVRecords">
    <xsl:param name="input.csv"/>

    <xsl:variable name="DoubleQuote" select="'&#34;'"/>
    <xsl:variable name="SingleQuote" select='"&#37;"'/>

    <!-- Parse out each record from the CSV by new lines and/or carriage returns -->
    <xsl:variable name="recordStrings">
      <xsl:for-each select="tokenize(translate($input.csv,'&#xd;',''),'&#xa;')">
        <recordString><xsl:value-of select="current()"/></recordString>
      </xsl:for-each>
    </xsl:variable>

    <!-- Iterate over each recordString and create a 'record' element with its 'field' elements inside -->
    <xsl:for-each select="$recordStrings/recordString">
      <!--output the fields for each record-->
      <record>
        <!--Matching csv fields is bit more difficult when there are quotes that capture commas inside a field -->
        <!--This variable extract the fields out properly-->

        <!--Inject an empty space if the first field is empty... this helps with non-matching-string that begins with comma.-->
        <!--We want all non-matching strings to be everything but the first field-->
        <xsl:variable name="currentRecordString" select="if (starts-with(current(),',')) then concat($DoubleQuote,' ',$DoubleQuote,current()) else current()"/>
        <xsl:analyze-string regex='("[^"]*")+' select="$currentRecordString" >
          <xsl:matching-substring>
            <field><xsl:value-of select='replace(., "^""|""$|("")""", "$1")'/></field>
          </xsl:matching-substring>
          <xsl:non-matching-substring>
            <xsl:choose>
              <xsl:when test="starts-with(.,',')">
                <xsl:for-each select="tokenize(substring(.,2),',')">
                  <field><xsl:value-of select="."/></field>
                </xsl:for-each>
              </xsl:when>
              <xsl:when test="ends-with(.,',')">
                <xsl:for-each select="tokenize(substring(.,1,string-length(.)-1),',')">
                  <field><xsl:value-of select="."/></field>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="tokenize(.,',')">
                  <field><xsl:value-of select="."/></field>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:non-matching-substring>
        </xsl:analyze-string>
      </record>
    </xsl:for-each>
  </xsl:function>

  <xsl:template name="Start">
    <!-- Output the records... or do something with them. -->
    <records>
      <xsl:copy-of select="f:parseCSVRecords($input.csv)"/>
    </records>
  </xsl:template>

</xsl:stylesheet>
