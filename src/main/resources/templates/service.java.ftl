package ${package.Service};

import ${package.Entity}.${entity};
import ${superServiceClassPackage};

<#if crud>
<#if swagger2>
<#if isReadList>
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import ${cfg.moduleModel.modulePackage}.dto.${entity}QueryDTO;
</#if>
</#if>
</#if>

/**
 <#if table.comment!?length gt 0>
 * @description ${table.comment!} Service接口
 <#else>
 * @description ${entity}对象数据操作Service接口
 </#if>
 * @author ${author}
 * @since ${date}
 */
<#if kotlin>
 interface ${table.serviceName} : ${superServiceClass} <${entity}>
<#else>
public interface ${table.serviceName} extends ${superServiceClass} <${entity}>{
<#if crud>
<#if swagger2>
	
	<#if isReadList>
	/**
	 * @description 分页查询接口
	 * @param param 分页查询参数
	 * @return 分页查询数据
	 * @throws Exception 数据操作异常
	 * @create ${author} ${date}
	 */
	Page<${entity}> queryList(${entity}QueryDTO param) throws Exception;
	</#if>
	
	<#if isCreate>
	/**
	 * @description 保存/修改数据接口
	 * @param <#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>entity</#if> 保存数据对象
	 * @return Boolean 是否保存成功
	 * @throws Exception 数据操作异常
	 * @create ${author} ${date}
	 */
	boolean saveOrUpdate${entity}(${entity} <#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>entity</#if>) throws Exception;
	</#if>
</#if>
</#if>
}
</#if>