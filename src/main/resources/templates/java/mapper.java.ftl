package ${package.Mapper};

import ${package.Entity}.${cfg.Model.entity};
import ${superMapperClassPackage};

<#if crud>
<#if swagger2>
<#if isReadList>
import org.apache.ibatis.annotations.Param;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import ${cfg.Model.modulePackage}.dto.${cfg.Model.dto};
</#if>
</#if>
</#if>

 /**
 * <p>
 <#if table.comment!?length gt 0>
 *	${table.comment!} Mapper查询接口
 <#else>
 *	${entity} Mapper查询接口
 </#if>
 * </p>
 *
 <#if table.comment!?length gt 0>
 * @description ${table.comment!} Mapper查询接口
 <#else>
 * @description ${entity} Mapper查询接口
 </#if>
 * @author ${author}
 * @since ${date}
 */
public interface ${cfg.Model.mapper} extends ${superMapperClass}<${cfg.Model.entity}> {
<#if crud>
<#if swagger2>

	<#if isReadList>
	/**
	 * @description 分页查询接口
	 * @param page 分页参数 
	 * @param param 查询参数
	 * @return 分页查询数据
	 * @create ${author} ${date}
	 */
	Page<${entity}> queryList(Page<${cfg.Model.entity}> page ,@Param("et") ${cfg.Model.dto} param);
	</#if>
</#if>
</#if>
}