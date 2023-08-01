package ${package.Service};

import ${package.Entity}.${cfg.Model.entity};
import ${superServiceClassPackage};

<#if crud>
<#if swagger2>
<#if isReadList>
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import ${cfg.Model.modulePackage}.dto.${cfg.Model.dto};
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
public interface ${cfg.Model.service} extends ${superServiceClass} <${cfg.Model.entity}>{
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
	Page<${cfg.Model.entity}> queryList(${cfg.Model.dto} param) throws Exception;
	</#if>
	
	<#if isCreate>
	/**
	 * @description 保存/修改数据接口
	 * @param entity 保存数据对象
	 * @return Boolean 是否保存成功
	 * @throws Exception 数据操作异常
	 * @create ${author} ${date}
	 */
	boolean saveOrUpdate${cfg.Model.entity}(${cfg.Model.entity} entity) throws Exception;
	</#if>
</#if>
</#if>
}