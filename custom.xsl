<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">

<!-- NESTED TOPIC TITLES (sensitive to nesting depth, but are still processed for contained markup) -->
<!-- 1st level - topic/title -->
<!-- Condensed topic title into single template without priorities; use $headinglevel to set heading.
     If desired, somebody could pass in the value to manually set the heading level -->
<xsl:template match="*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]">
  <xsl:param name="headinglevel" as="xs:integer">
      <xsl:choose>
          <xsl:when test="count(ancestor::*[contains(@class, ' topic/topic ')]) > 6">6</xsl:when>
          <xsl:otherwise><xsl:sequence select="count(ancestor::*[contains(@class, ' topic/topic ')])"/></xsl:otherwise>
      </xsl:choose>
  </xsl:param>
  <xsl:element name="h{$headinglevel}">
    <xsl:attribute name="style">display:table</xsl:attribute>
    <xsl:attribute name="class">topictitle<xsl:value-of select="$headinglevel"/></xsl:attribute>
    <xsl:call-template name="commonattributes">
      <xsl:with-param name="default-output-class">topictitle<xsl:value-of select="$headinglevel"/></xsl:with-param>
    </xsl:call-template>
    <xsl:attribute name="id"><xsl:apply-templates select="." mode="return-aria-label-id"/></xsl:attribute>
    
    <div class="edit-link-container" style="display: table-cell; margin-top: 0;">
      <xsl:apply-templates/>
    </div>
    <!-- Compute the URL params for the edit url -->
    <xsl:variable name="file.path">
      <xsl:value-of select="substring(@xtrf, 7 + string-length(system-property('cwd')))"/>
    </xsl:variable>
    <xsl:variable name="file.url.encoded">
      <xsl:value-of select="encode-for-uri(concat(system-property('repo.url'), $file.path))"/>
    </xsl:variable>
    <xsl:variable name="ditamap.url.encoded">
      <xsl:value-of select="encode-for-uri(concat(system-property('repo.url'), system-property('ditamap.path')))"/>
    </xsl:variable>

    <!-- The edit link -->
    <span class="edit-link" style="font-size: 14px; display: table-cell; text-align: right; vertical-align: middle"> 
      <a target="_blank">
        <xsl:attribute name="href">
          <xsl:value-of select="system-property('webapp.url')"/>app/oxygen.html?url=<xsl:value-of select="$file.url.encoded"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>ditamap=<xsl:value-of select="$ditamap.url.encoded"/>
        </xsl:attribute>Edit on GitHub</a>
    </span>
    <!-- Done with the edit link -->
  </xsl:element>      
  
  <xsl:value-of select="$newline"/>
</xsl:template>

</xsl:stylesheet>
