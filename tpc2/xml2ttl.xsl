<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    
    xmlns:xd="oxygenxml.com/ns/doc/xsl"
    
    exclude-result-prefixes="xd"
    
    version="1.0">
    
    <xd:doc scope="stylesheet">
        
        <xd:desc>
            
            <xd:p><xd:b>Created on:</xd:b> Mar 7, 2021</xd:p>
            
            <xd:p><xd:b>Author:</xd:b> A75310</xd:p>
            
            <xd:p>Conversão do arquivo musical de XML para TTL</xd:p>
            
        </xd:desc>
        
    </xd:doc>
    
    
    
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>
    
    
    
    <xsl:template match="obra">
        
        ### di.uminho.pt/prc2021/musica#<xsl:value-of select="@id"/>
        
        :<xsl:value-of select="@id"/> rdf:type owl:NamedIndividual ,
        
        :Obra ;
        
        :tipo "<xsl:value-of select="tipo"/>" ;
        
        :título "<xsl:value-of select="titulo"/>" .
        
        # -------------------------------------------
        
        ### di.uminho.pt/prc2021/musica#comp_<xsl:value-of select="@id"/>
        
        :comp_<xsl:value-of select="@id"/> rdf:type owl:NamedIndividual ,
        
        :Compositor ;
        
        :nome "<xsl:value-of select="compositor"/>" .
        
        # -------------------------------------------
        
        <xsl:apply-templates select="instrumentos"/>
        
    </xsl:template>
      
    
    <xsl:template match="instrumento">
        
        ### di.uminho.pt/prc2021/mapa#inst<xsl:value-of select="count(preceding-sibling::*) + 1" />_<xsl:value-of select="../../@id"/>
        
        :inst<xsl:value-of select="count(preceding-sibling::*) + 1" />_<xsl:value-of select="../../@id"/> rdf:type owl:NamedIndividual ,
        
        :Instrumento ;
        
        :designação "<xsl:value-of select="designacao"/>" .
        
        # -------------------------------------------
        <xsl:apply-templates select="partitura"/>
    </xsl:template>
    
    
    <xsl:template match="partitura">
        
        ### di.uminho.pt/prc2021/mapa#par_<xsl:value-of select="@path"/>
        
        :par_<xsl:value-of select="@path"/> rdf:type owl:NamedIndividual ,
        
        :Partitura ;
        
        :voz "<xsl:value-of select="@voz"/>" ;
        
        :tipo "<xsl:value-of select="@type"/>" ;
        
        :path "<xsl:value-of select="@path"/>" .
        
        # -------------------------------------------
        
    </xsl:template>
    
    
    

    
    
    
</xsl:stylesheet>