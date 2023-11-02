package ${package.Controller};

import org.springframework.web.bind.annotation.RequestMapping;
<#if crud>
<#if swagger2>
import ${package.Entity}.${cfg.Model.entity};
import ${package.Service}.${cfg.Model.service};

<#if isReadList>
import ${cfg.Model.modulePackage}.dto.${cfg.Model.dto};
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
 * @description ${table.comment!}数据操作接口
 <#else>
 * @description ${entity}对象数据操作接口
 </#if>
 * @author ${author}
 * @since ${date}
 */
<#if restControllerStyle>
@RestController
<#else>
@Controller
</#if>
@RequestMapping("${cfg.Model.router}")
@Api(tags = "${table.comment!}操作接口")
<#if superControllerClass??>
public class ${cfg.Model.controller} extends ${superControllerClass} {
<#else>
public class ${cfg.Model.controller} {
</#if>
<#if crud>
<#if swagger2>

	@Autowired
	private ${cfg.Model.service} ${cfg.Model.prefixName}Service;

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
	public ResultBean<?> queryList(@RequestBody ${cfg.Model.dto} param) throws Exception{
		Page<${cfg.Model.entity}> rstList = ${cfg.Model.prefixName}Service.queryList(param);
		return ResultUtil.success(rstList);
	}
</#if>
<#if isCreate>
	/**
	 * @description 保存/更新数据
	 * @param ${cfg.Model.prefixName} 保存对象数据
	 * @return 是否保存成功
	 * @throws Exception 数据操作异常
	 * @create ${author} ${date}
	 */
	@ApiOperation(value = "保存/更新数据")
	@PostMapping("/saveOrUpdate")
	public ResultBean<?> saveOrUpdate(@RequestBody ${cfg.Model.entity} ${cfg.Model.prefixName}) throws Exception{
		boolean rst = ${cfg.Model.prefixName}Service.saveOrUpdate${cfg.Model.entity}(${cfg.Model.prefixName});
		if(rst){
			return ResultUtil.success();
		}
		return ResultUtil.error();
	}
</#if>
<#if isRead>
	/**
	 * @description 通过主键id查询数据
	 * @param primaryId 主键id
	 * @throws Exception 数据操作异常
	 * @create ${author} ${date}
	 */
	@ApiOperation(value = "通过主键id查询数据")
	@GetMapping("/queryById")
	public ResultBean<?> queryById(@RequestParam(value="${cfg.Model.prefixName}Id") String primaryId) throws Exception{
		return ResultUtil.success(${cfg.Model.prefixName}Service.getById(primaryId));
	}
</#if>
<#if isDelete>
	/**
	 * @description 通过主键id删除数据
	 * @param list 主键id数组
	 * @return 是否删除成功
	 * @throws Exception 数据操作异常
	 * @create ${author} ${date}
	 */
	@ApiOperation(value = "通过主键id删除数据")
	@PostMapping("/deleteById")
	public ResultBean<?> deleteById(@RequestBody List<String> list) throws Exception{
		boolean rst = ${cfg.Model.prefixName}Service.removeByIds(list);
		if(rst){
			return ResultUtil.success();
		}
		return ResultUtil.error();
	}
</#if>
</#if>
</#if>
}