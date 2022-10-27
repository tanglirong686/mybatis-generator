package ${package.Mapper};

import ${package.Entity}.${entity};
import ${superMapperClassPackage};

<#if crud>
<#if swagger2>
<#if isReadList>
import org.apache.ibatis.annotations.Param;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import ${cfg.moduleModel.modulePackage}.dto.${entity}QueryDTO;
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
<#if kotlin>
interface ${table.mapperName} : ${superMapperClass}<${entity}>
<#else>
public interface I${table.mapperName} extends ${superMapperClass}<${entity}> {
<#if crud>
<#if swagger2>

	<#if isReadList>
	/**
	 * @description 分页查询接口
	 * @param page 分页参数 
	 * @param param 查询参数
	 * @return 分页查询数据
	 * @throws Exception 数据查询操作异常
	 * @create ${author} ${date}
	 */
	Page<${entity}> queryList(Page<${entity}> page ,@Param("et") ${entity}QueryDTO param) throws Exception;
	</#if>
</#if>
</#if>
}
</#if>