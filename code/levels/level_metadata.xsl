<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="level">
<html>
	<body>
		<xsl:attribute name="bgcolor">#<xsl:value-of select="@backgroundColor"/></xsl:attribute>
		<xsl:for-each select='objects/tile'>
			<img>
				<xsl:attribute name="title">Type = <xsl:value-of select="@type"/>, Position = (<xsl:value-of select="@xPosition"/>x, <xsl:value-of select="@yPosition"/>y)</xsl:attribute>
				<xsl:attribute name="src">images/tiles/<xsl:value-of select="@type"/>.png</xsl:attribute>
				<xsl:attribute name="style">position:absolute; left:<xsl:value-of select="@xPosition"/>px; top:<xsl:value-of select="@yPosition"/>px; z-index:<xsl:value-of select="@zIndex" /></xsl:attribute>
			</img>
		</xsl:for-each>
		<xsl:for-each select='objects/character'>
			<img>
				<xsl:attribute name="title">Type = <xsl:value-of select="@type"/>, Position = (<xsl:value-of select="@xPosition"/>x, <xsl:value-of select="@yPosition"/>y)</xsl:attribute>
				<xsl:attribute name="src">images/characters/<xsl:value-of select="@type"/>.png</xsl:attribute>
				<xsl:attribute name="Style">position:absolute; left:<xsl:value-of select="@xPosition"/>px; top:<xsl:value-of select="@yPosition"/>px;</xsl:attribute>
			</img>
		</xsl:for-each>
		<xsl:for-each select='objects/item'>
			<img>
				<xsl:attribute name="title">Type = <xsl:value-of select="@type"/>, Position = (<xsl:value-of select="@xPosition"/>x, <xsl:value-of select="@yPosition"/>y)</xsl:attribute>
				<xsl:attribute name="src">images/items/<xsl:value-of select="@type"/>.png</xsl:attribute>
				<xsl:attribute name="Style">position:absolute; left:<xsl:value-of select="@xPosition"/>px; top:<xsl:value-of select="@yPosition"/>px;</xsl:attribute>
			</img>
		</xsl:for-each>
	</body>
</html>
</xsl:template>
</xsl:stylesheet>
