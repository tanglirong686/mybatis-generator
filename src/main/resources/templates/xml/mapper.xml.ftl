<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package.Mapper}.${cfg.Model.mapper}">

<#if enableCache>
    <!-- 开启二级缓存 -->
    <cache type="org.mybatis.caches.ehcache.LoggingEhcache"/>

</#if>
<#if baseResultMap>
    <!-- 通用查询映射结果 -->
    <resultMap id="baseResultMap" type="${package.Entity}.${cfg.Model.entity}">
<#list table.fields as field>
    <#if field.keyFlag>
    <#--生成主键排在第一位-->
        <id column="${field.name}" property="${field.propertyName}" />
    </#if>
</#list>
<#list table.commonFields as field>
    <#--生成公共字段 -->
        <result column="${field.name}" property="${field.propertyName}" />
</#list>
<#list table.fields as field>
    <#if !field.keyFlag>
    <#--生成普通字段 -->
        <result column="${field.name}" property="${field.propertyName}" />
    </#if>
</#list>
    </resultMap>

</#if>
<#if baseColumnList>
    <!-- 通用查询结果列 -->
    <sql id="baseColumnList">
<#list table.commonFields as field>
        ${field.name},
</#list>
        ${table.fieldNames}
    </sql>
	
</#if>
<#if crud>
<#if baseResultMap>
<#if baseColumnList>
	<#if isReadList>
	<!-- 分页查询 -->
	<select id="queryList" resultMap="baseResultMap">
		select <include refid="baseColumnList"></include> from <#if table.convert>${table.name}</#if>
	</select>
	</#if>
</#if>
</#if>
</#if>
</mapper>