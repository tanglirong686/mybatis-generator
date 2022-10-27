package ${package.Controller};

import org.springframework.web.bind.annotation.RequestMapping;
<#if crud>
<#if swagger2>
import ${package.Entity}.${entity};
import ${package.Service}.${table.serviceName};

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
<#if isReadList>
import ${cfg.moduleModel.modulePackage}.dto.${entity}QueryDTO;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
</#if>
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
</#if>
</#if>

import io.swagger.annotations.Api;

<#if restControllerStyle>
import org.springframework.web.bind.annotation.RestController;
<#else>
import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
import ${superControllerClassPackage};
</#if>

 /**
 <#if table.comment!?length gt 0>
 * @description ${table.comment!}数据操作接口请求控制器类
 <#else>
 * @description ${entity}对象数据操作接口请求控制器类
 </#if>
 * @author ${author}
 * @since ${date}
 */
<#if restControllerStyle>
@RestController
<#else>
@Controller
</#if>
@RequestMapping("<#if package.ModuleName??>/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")
@Api(tags = "${table.comment!}操作接口")
<#if kotlin>
class ${table.controllerName}<#if superControllerClass??> : ${superControllerClass}()</#if>
<#else>
<#if superControllerClass??>
public class ${table.controllerName} extends ${superControllerClass} {
<#else>
public class ${table.controllerName} {
</#if>
<#if crud>
<#if swagger2>
	
	private static final Logger logger = LoggerFactory.getLogger(${table.controllerName}.class);
	@Autowired
	private ${table.serviceName} <#if controllerMappingHyphenStyle??>${controllerMappingHyphen}Service<#else>${table.entityPath}Service</#if>;

<#if isReadList>
	/**
	 * @description 分页查询接口
	 * @param param 分页查询参数
	 * @return 分页查询list数据
	 * @throws Exception 数据操作异常
	 * @create ${author} ${date}
	 */
	@ApiOperation(value = "分页查询数据")
	@PostMapping("/queryList")
	public ResultBean<?> queryList(@RequestBody ${entity}QueryDTO param) throws Exception{
		Page<${entity}> rstList = <#if controllerMappingHyphenStyle??>${controllerMappingHyphen}Service<#else>${table.entityPath}Service</#if>.queryList(param);
		return ResultUtil.success(rstList);
	}
</#if>
<#if isCreate>
	/**
	 * @description 保存/更新数据
	 * @param <#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>entity</#if> 保存对象数据
	 * @return 是否保存成功
	 * @throws Exception 数据操作异常
	 * @create ${author} ${date}
	 */
	@ApiOperation(value = "保存/更新数据")
	@PostMapping("/saveOrUpdate")
	public ResultBean<?> saveOrUpdate(@RequestBody ${entity} <#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>entity</#if>) throws Exception{
		try {
			boolean rst = <#if controllerMappingHyphenStyle??>${controllerMappingHyphen}Service<#else>${table.entityPath}Service</#if>.saveOrUpdate${entity}(<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>entity</#if>);
			if(rst){
				return ResultUtil.success();
			}
		} catch (Exception e) {
			logger.error("数据保存更新异常，错误原因：{}",e.getMessage(),e);
		}
		return ResultUtil.error();
	}
</#if>
<#if isRead>
	/**
	 * @description 通过主键id查询数据
	 * @param <#if controllerMappingHyphenStyle??>${controllerMappingHyphen}Id<#else>primaryId</#if> 主键id
	 * @throws Exception 数据操作异常
	 * @create ${author} ${date}
	 */
	@ApiOperation(value = "通过主键id查询数据")
	@ApiImplicitParam(name = "<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}Id<#else>primaryId</#if>", value = "主键id",paramType = "path",dataType = "String")
	@GetMapping("/queryById/{<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}Id<#else>primaryId</#if>}")
	public ResultBean<?> queryById(@PathVariable String <#if controllerMappingHyphenStyle??>${controllerMappingHyphen}Id<#else>primaryId</#if>) throws Exception{
		try {
			return ResultUtil.success(<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}Service<#else>${table.entityPath}Service</#if>.getById(<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}Id<#else>primaryId</#if>));
		} catch (Exception e) {
			logger.error("通过主键id查询数据异常，错误原因：{}",e.getMessage(),e);
		}
	}
</#if>
<#if isDelete>
	/**
	 * @description 通过主键id删除数据
	 * @param idList 主键id数组
	 * @return 是否删除成功
	 * @throws Exception 数据操作异常
	 * @create ${author} ${date}
	 */
	@ApiOperation(value = "通过主键id删除数据")
	@PostMapping("/deleteById")
	public ResultBean<?> deleteById(@RequestBody List<String> idList) throws Exception{
		try {
			boolean rst = <#if controllerMappingHyphenStyle??>${controllerMappingHyphen}Service<#else>${table.entityPath}Service</#if>.removeByIds(idList);
			if(rst){
				return ResultUtil.success();
			}
		} catch (Exception e) {
			logger.error("通过主键id删除数据异常，错误原因：{}",e.getMessage(),e);
		}
		return ResultUtil.error();
	}
</#if>
</#if>
</#if>
}
</#if>