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
@ApiModel(value="${entity}对象", description="${table.comment!}表对应实体类")
</#if>
<#if superEntityClass??>
public class ${entity} extends ${superEntityClass}<#if activeRecord><${entity}></#if> {
<#elseif activeRecord>
public class ${entity} extends Model<${entity}> {
<#else>
public class ${entity} implements Serializable {
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
    <#if field.comment!?length gt 0>
    <#if swagger2>
    /**@ApiModelProperty(name = "${field.propertyName}",value = "${field.comment}")*/
    <#else>
    /**
     * ${field.comment}
     */
    </#if>
    </#if>
    <#if table.fields[1].propertyName==field.propertyName>
    <#-- 主键 -->
    	<#if table.fields[1].propertyName==field.propertyName>
    @TableId(value = "${field.name}" ,type = IdType.ASSIGN_UUID)
    	<#elseif field.convert>
    @TableId("${field.name}")
    	</#if>
    <#-- 普通字段 -->
    <#elseif field.fill??>
    <#-------   存在字段填充设置   ----->
        <#if field.convert>
    @TableField(value = "${field.name}", fill = FieldFill.${field.fill})
        <#else>
    @TableField(fill = FieldFill.${field.fill})
        </#if>
    <#elseif field.convert>
    @TableField(value="${field.name}"<#if field.name=="id">,exist=false</#if>)
    </#if>
	<#-- 乐观锁注解 -->
    <#if (versionFieldName!"") == field.name>
    @Version
    </#if>
	<#-- 逻辑删除注解 -->
    <#if (logicDeleteFieldName!"") == field.name>
    @TableLogic
    </#if>
    private <#if field.propertyType=="LocalDateTime">Date<#else>${field.propertyType}</#if> ${field.propertyName};
</#list>
<#------------  END 字段循环遍历  ---------->

<#------------  构造函数生成  ---------->
	public ${entity}() {
		super();
	}
	
	public ${entity}(
	<#list table.fields as field>
	<#if field.propertyName !="id">,</#if><#if field.propertyType=="LocalDateTime">Date<#else>${field.propertyType}</#if> ${field.propertyName}
	</#list>) {
		<#list table.fields as field>
		this.${field.propertyName} = ${field.propertyName};
		</#list>
	}
	
<#if !entityLombokModel>
    @Override
    public String toString() {
        return "${entity} [<#list table.fields as field><#if field_index==0>${field.propertyName}=" + ${field.propertyName} +
        <#else>
        ", ${field.propertyName}=" + ${field.propertyName} +
        </#if>
    </#list>
        "]";
    }
</#if>
}