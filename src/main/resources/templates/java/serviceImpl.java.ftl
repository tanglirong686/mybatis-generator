package ${package.ServiceImpl};

import org.springframework.stereotype.Service;

import ${package.Entity}.${cfg.Model.entity};
import ${package.Mapper}.${cfg.Model.mapper};
import ${package.Service}.${cfg.Model.service};
import ${superServiceImplClassPackage};

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
 * @description ${table.comment!} Service接口实现类
 <#else>
 * @description ${entity}对象数据操作Service接口实现类
 </#if>
 * @author ${author}
 * @since ${date}
 */
@Service
public class ${cfg.Model.serviceImpl} extends ${superServiceImplClass}<${cfg.Model.mapper},${cfg.Model.entity}> implements ${cfg.Model.service}{
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
	@Override
	public Page<${entity}> queryList(${cfg.Model.dto} param) throws Exception{
		Page<${cfg.Model.entity}> page = new Page<>(param.getCurrent(), param.getSize());
		return baseMapper.queryList(page,param);
	}
	</#if>
	
	<#if isCreate>
	/**
	 * @description 保存/修改数据接口
	 * @param entity 保存数据对象
	 * @return Boolean 是否保存成功
	 * @throws Exception 数据操作异常
	 * @create ${author} ${date}
	 */
	@Override
	public boolean saveOrUpdate${cfg.Model.entity}(${cfg.Model.entity} entity) throws Exception{
		return super.saveOrUpdate(entity);
	}
	</#if>
</#if>
</#if>
}