package ${package.ServiceImpl};

import org.springframework.stereotype.Service;

import ${package.Entity}.${entity};
import ${package.Mapper}.I${table.mapperName};
import ${package.Service}.${table.serviceName};
import ${superServiceImplClassPackage};

<#if crud>
<#if swagger2>
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
<#if isReadList>
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import ${cfg.moduleModel.modulePackage}.dto.${entity}QueryDTO;
</#if>
</#if>
</#if>

/**
 <#if table.comment!?length gt 0>
 * @description ${table.comment!} Service接口实现类
 <#else>
 * @description ${entity}对象数据操作Service接口实现类
 </#if>
 * @author ${author}
 * @since ${date}
 */
@Service
<#if kotlin>
open class ${table.serviceImplName} : ${superServiceImplClass}<I${table.mapperName},${entity}>(),${table.serviceName}{
 	
}
<#else>
public class ${table.serviceImplName} extends ${superServiceImplClass}<I${table.mapperName},${entity}> implements ${table.serviceName}{
<#if crud>
<#if swagger2>
	
	private static final Logger logger = LoggerFactory.getLogger(${table.serviceImplName}.class);
	<#if isReadList>
	/**
	 * @description 分页查询接口
	 * @param param 分页查询参数
	 * @return 分页查询数据
	 * @throws Exception 数据操作异常
	 * @create ${author} ${date}
	 */
	@Override
	public Page<${entity}> queryList(${entity}QueryDTO param) throws Exception{
		try {
			Page<${entity}> page = new Page<>(param.getCurrent(), param.getSize());
			return baseMapper.queryList(page,param);
		} catch (Exception e) {
			logger.error("分页查询异常，错误原因：{}",e.getMessage(),e);
		}
		return null;
	}
	</#if>
	
	<#if isCreate>
	/**
	 * @description 保存/修改数据接口
	 * @param <#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>entity</#if> 保存数据对象
	 * @return Boolean 是否保存成功
	 * @throws Exception 数据操作异常
	 * @create ${author} ${date}
	 */
	@Override
	public boolean saveOrUpdate${entity}(${entity} <#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>entity</#if>) throws Exception{
		try {
			return super.saveOrUpdate(<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>entity</#if>);
		} catch (Exception e) {
			logger.error("保存异常，错误原因：{}",e.getMessage(),e);
		}
		return false;
	}
	</#if>
</#if>
</#if>
}
</#if>