<?xm version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="html" />
    <xsl:param name="mode" />

    <xsl:variable name="process.root" select="@@CC_LAYER_PATH@@" />
    <xsl:variable name="base.url">@@BASE_URL@@</xsl:variable>
    <xsl:variable name="downfile.url">@@DOWNLOAD_URL@@</xsl:variable>
    <xsl:variable name="module.file">@@MODULE_FILE@@</xsl:variable>
    <xsl:variable name="page.layer.path">@@LAYER_PATH@@</xsl:variable>
    <xsl:variable name="isshowdetail">@@IS_SHOWDETAIL@@</xsl:variable>

    <xsl:key name="layer-by-name" match="@@CC_LAYER_PATH@@/layer" use="@name" />

    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="$mode = 'summary'">
                <xsl:apply-templates select="." mode="summary" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="task.layer" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <xsl:template match="/" mode="summary">
        <xsl:if test="count($process.root//artifact) > 0">
            <xsl:call-template name="task.summary.sublayer"/>
        </xsl:if>
    </xsl:template>


    <xsl:template match="/" mode="task.layer">
        <xsl:if test="count($process.root//artifact) > 0">
            <h2 align="center">artifact report</h2>
            <xsl:call-template name="task.summary.sublayer" />
        </xsl:if>
        <xsl:if test="count($process.root//artifact) = 0 and count(//artifact) = 0">
            <p align="center">artifact was not run against this project. </p>
        </xsl:if>
    </xsl:template>


    <xsl:template match="*" mode="get.full.layer.name">
        <xsl:if test="count(parent::layer) > 0">
            <xsl:apply-templates select="parent::layer" mode="get.full.layer.name" />
        </xsl:if>
        <xsl:if test="local-name() = 'layer'">/<xsl:value-of select="@name" /></xsl:if>
    </xsl:template>

    <xsl:template name="task.summary.sublayer">
        <xsl:variable name="artifact.root" select="$process.root" />
        <xsl:variable name="child.layer.count" select="count($process.root/layer)" />

        <h2>&#160; Cloud Artifact Summary <em><xsl:apply-templates select="$process.root[1]" mode="get.full.layer.name" /></em></h2>
        <table  class="sortable pane bigtable stripped-odd" id="artifact" border="1">
            <tbody>
                <tr class="header">
                    <th>
                        <xsl:if test="local-name($process.root[1]) = 'layer'">
                            <xsl:value-of select="$process.root[1]/@name" />
                        </xsl:if>
                        <xsl:if test="local-name($process.root[1]) != 'layer'">
                            Name
                        </xsl:if>
                    </th>
                    <th>artifact info</th>
                </tr>

                <xsl:if test="count($process.root) > 0">
                    <xsl:for-each select="$process.root">
                        <xsl:apply-templates select="artifact" mode="currentnode.task.layer" />
                    </xsl:for-each>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>

    <xsl:template match="artifact" mode="currentnode.task.layer">
        <tr>
            <td>./artifact</td>
            <td>
              <p>CloudProvider: <xsl:value-of select="cloudProvider/@value" /></p>
              <p>Region: <xsl:value-of select="region/@value" /></p>
              <p>Bucket: <xsl:value-of select="bucket/@value" /></p>
              <p>RemoteDir: /<xsl:value-of select="remoteDir/@value" /></p>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
