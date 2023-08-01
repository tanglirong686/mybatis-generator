package ${cfg.Model.modulePackage}.dto;

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
</#if>

/**
* ${table.comment!}
*
* @author ${author}
* @since ${date}
*/
<#if entityLombokModel>
@Data
</#if>
<#if swagger2>
@ApiModel("${table.comment!}")
</#if>
public class ${cfg.Model.dto} {
<#------------  BEGIN 字段循环遍历  ---------->
<#list table.fields as field>
	/**
     * 	${field.comment}
     */
    <#if field.comment!?length gt 0>
        <#if swagger2>
    @ApiModelProperty(name = "${field.propertyName}",value = "${field.comment}")
        <#else>
    /**
     * ${field.comment}
     */
        </#if>
    </#if>
    private <#if field.propertyType=="LocalDateTime">Date<#else>${field.propertyType}</#if> ${field.propertyName};
</#list>
<#------------  END 字段循环遍历  ---------->
}