<?xml version="1.0" standalone="no"?>
<xsl:stylesheet version="1.0"
           xmlns:svg="http://www.w3.org/2000/svg"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           xmlns:exsl="http://exslt.org/common"
           xmlns:xlink="http://www.w3.org/1999/xlink">
           
<xsl:variable name="COL_XLNX"    	select="'#810017'"/>
<xsl:variable name="COL_INFO"    	select="'#2233FF'"/>

<xsl:variable name="COL_MODUSR" 	select="'#FFFFAA'"/>
<xsl:variable name="COL_MODSYS" 	select="'#AAAAFF'"/>
<xsl:variable name="COL_MODSYSNW" 	select="'#000099'"/>

<xsl:variable name="COL_BLACK"      select="'#000000'"/>
<xsl:variable name="COL_WHITE"      select="'#FFFFFF'"/>

<!-- 
<xsl:variable name="COL_ASH"        select="'#DEDEDE'"/>
-->
<xsl:variable name="COL_RED"        select="'#AA0000'"/>
<xsl:variable name="COL_GREEN"      select="'#33CC33'"/>
<xsl:variable name="COL_BLUE_LT"    select="'#AAAAFF'"/>

<xsl:variable name="COL_GRAY"       select="'#CECECE'"/>
<xsl:variable name="COL_GRAY_LT"   	select="'#E1E1E1'"/>
<xsl:variable name="COL_GRAY_DK"   	select="'#B1B1B1'"/>

<xsl:variable name="COL_YELLOW"     select="'#FFFFDD'"/>
<xsl:variable name="COL_YELLOW_LT"  select="'#FFFFEE'"/>				

<xsl:variable name="COL_ATTR_BUF"   select="'#FF5555'"/>
<xsl:variable name="COL_ATTR_CLK"   select="'#55FF55'"/>
<xsl:variable name="COL_ATTR_INT"   select="'#5555FF'"/>
<xsl:variable name="COL_ATTR_RST"   select="'#FFCC00'"/>



<xsl:variable name="COL_BUSSTDS">
	
	<BUSCOLOR BUSSTD="XIL"        RGB="#990066" RGB_LT="#CC3399"/>
	<BUSCOLOR BUSSTD="OCM" 		  RGB="#0000DD" RGB_LT="#9999DD"/>
	<BUSCOLOR BUSSTD="OPB"        RGB="#339900" RGB_LT="#CCDDCC"/>
	<BUSCOLOR BUSSTD="LMB"        RGB="#7777FF" RGB_LT="#DDDDFF"/>
	<BUSCOLOR BUSSTD="FSL"        RGB="#CC00CC" RGB_LT="#FFBBFF"/>
	<BUSCOLOR BUSSTD="DCR"        RGB="#6699FF" RGB_LT="#BBDDFF"/>
	<BUSCOLOR BUSSTD="FCB"        RGB="#8C00FF" RGB_LT="#CCCCFF"/>
	<BUSCOLOR BUSSTD="PLB"        RGB="#FF5500" RGB_LT="#FFBB00"/>
	<BUSCOLOR BUSSTD="PLBV46"     RGB="#BB9955" RGB_LT="#FFFFDD"/>
	<BUSCOLOR BUSSTD="PLBV46_P2P" RGB="#BB9955" RGB_LT="#FFFFDD"/>
	
	<BUSCOLOR BUSSTD="TRS"         RGB="#009999" RGB_LT="#00CCCC"/>
	<BUSCOLOR BUSSTD="TRANS"       RGB="#009999" RGB_LT="#00CCCC"/>
	<BUSCOLOR BUSSTD="TRANSPARENT" RGB="#009999" RGB_LT="#00CCCC"/>

	<BUSCOLOR BUSSTD="TARGET"      RGB="#009999" RGB_LT="#00CCCC"/>
	<BUSCOLOR BUSSTD="INITIATOR"   RGB="#009999" RGB_LT="#00CCCC"/>
	
	<BUSCOLOR BUSSTD="KEY" 		   RGB="#444444" RGB_LT="#888888"/>
	
</xsl:variable>

<xsl:variable name="COL_INTCS">

	<INTCCOLOR INTC_INDEX="0" RGB="'#FF9900'"/>
	<INTCCOLOR INTC_INDEX="1" RGB="'#00CCCC'"/>
	<INTCCOLOR INTC_INDEX="2" RGB="'#33FF33'"/>
	<INTCCOLOR INTC_INDEX="3" RGB="'#FF00CC'"/>
	<INTCCOLOR INTC_INDEX="4" RGB="'#99FF33'"/>
	<INTCCOLOR INTC_INDEX="5" RGB="'#0066CC'"/>
	<INTCCOLOR INTC_INDEX="6" RGB="'#9933FF'"/>
	<INTCCOLOR INTC_INDEX="7" RGB="'#3300FF'"/>
	<INTCCOLOR INTC_INDEX="8" RGB="'#00FF33'"/>
	<INTCCOLOR INTC_INDEX="9" RGB="'#FF3333'"/>

</xsl:variable>

<xsl:template name="IntcIndex2Color">
	<xsl:param name="iIntcIndex"  select="'0'"/>
	
	<xsl:choose>
		<xsl:when test="exsl:node-set($COL_INTCS)/INTCCOLOR[(@INTC_INDEX= $iIntc2Color)]/@RGB">
			<xsl:value-of select="exsl:node-set($COL_INTCS)/INTCCOLOR[(@INTC_INDEX = $iIntcIndex)]/@RGB"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="exsl:node-set($COL_INTCS)/INTCCOLOR[(@INTC_INDEX = '0')]/@RGB"/>
		</xsl:otherwise>
	</xsl:choose>		
</xsl:template>	
	
	
<xsl:template name="BusStd2Color">
	<xsl:param name="iBusStd"  select="'OPB'"/>
	
	<xsl:choose>
		<xsl:when test="exsl:node-set($COL_BUSSTDS)/BUSCOLOR[(@BUSSTD = $iBusStd)]/@RGB">
			<xsl:value-of select="exsl:node-set($COL_BUSSTDS)/BUSCOLOR[(@BUSSTD = $iBusStd)]/@RGB"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="exsl:node-set($COL_BUSSTDS)/BUSCOLOR[(@BUSSTD = 'TRS')]/@RGB"/>
		</xsl:otherwise>
	</xsl:choose>		
</xsl:template>	
	
	
<xsl:template name="BusStd2LightColor">
	<xsl:param name="iBusStd"  select="'OPB'"/>
	
<!--	
	<xsl:message>The color of bus  <xsl:value-of select="$busType"/> is <xsl:value-of select="exsl:node-set($COL_BUSSTDS)/BUSCOLOR[(@BUSSTD = $busType)]/@RGB"/>
-->	
		
	<xsl:choose>
		<xsl:when test="exsl:node-set($COL_BUSSTDS)/BUSCOLOR[(@BUSSTD = $iBusStd)]/@RGB_LT">
			<xsl:value-of select="exsl:node-set($COL_BUSSTDS)/BUSCOLOR[(@BUSSTD = $iBusStd)]/@RGB_LT"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="exsl:node-set($COL_BUSSTDS)/BUSCOLOR[(@BUSSTD = 'TRS')]/@RGB_LT"/>
		</xsl:otherwise>
	</xsl:choose>		
</xsl:template>	
		
</xsl:stylesheet>
