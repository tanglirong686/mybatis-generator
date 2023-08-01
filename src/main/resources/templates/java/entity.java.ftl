package ${package.Entity};

<#list table.importPackages as pkg>
import ${pkg};
</#list>
<#if swagger2>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
<#list table.fields as field>
<#if field.propertyType=="LocalDateTime">
import java.util.Date;
<#break>
</#if>
</#list>
</#if>
<#if entityLombokModel>
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
</#if>

/**
 <#if table.comment!?length gt 0>
 * @description ${table.comment!}实体类
 <#else>
 * @description ${entity}对象封装实体类
 </#if>
 * @author ${author}
 * @since ${date}
 */
<#if entityLombokModel>
@Data
    <#if superEntityClass??>
@EqualsAndHashCode(callSuper = true)
    <#else>
@EqualsAndHashCode(callSuper = false)
    </#if>
@Accessors(chain = true)
</#if>
<#if table.convert>
@TableName("${table.name}")
</#if>
<#if swagger2>
@ApiModel(value="${cfg.Model.entity}对象", description="${table.comment!}表对应实体类")
</#if>
<#if superEntityClass??>
public class ${cfg.Model.entity} extends ${superEntityClass} {
<#else>
public class ${cfg.Model.entity} implements Serializable {
</#if>

    private static final long serialVersionUID = 1L;
<#------------  BEGIN 字段循环遍历  ---------->
<#list table.fields as field>
    <#if field.keyFlag>
        <#assign keyPropertyName="${field.propertyName}"/>
    </#if>
	/**
     * 	${field.comment}
     */
    <#-- 主键 -->
    <#if field.keyFlag>
    @TableId(value = "${field.name}" ,type = IdType.ID_WORKER)
    <#else>
    <#-- 普通字段 -->
    @TableField(value = "${field.name}")
    </#if>
	<#-- 逻辑删除注解 -->
    <#if (logicDeleteFieldName!"") == field.name>
    @TableLogic
    </#if>
    <#if field.comment!?length gt 0>
        <#if swagger2>
    @ApiModelProperty(name = "${field.propertyName}",value = "${field.comment}")
        </#if>
    </#if>
    private <#if field.propertyType=="LocalDateTime">Date<#else>${field.propertyType}</#if> ${field.propertyName};
</#list>
<#------------  END 字段循环遍历  ---------->
}