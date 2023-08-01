package com.example.property;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @Author: tang lirong
 * @Description: 代码生成相关参数封装
 * @Date: Created in 2022/7/25 14:36
 */
@Data
@ApiModel(value = "代码生成相关参数封装")
public class GenerateProperty {

	// 表名
	@ApiModelProperty(name = "tableNames",value = "字符串拼接的以逗号分隔开的表名")
	private String tableNames;

	// 表名前缀
	@ApiModelProperty(name = "prefix",value = "生成时替换的表名前缀")
	private String prefix;

	// 模块输出包名
	@ApiModelProperty(name = "outletPackage",value = "模块输出包名")
	private String outletPackage;

	// 是否生成crud方法
	@ApiModelProperty(name = "crud",value = "是否生成crud方法，默认true ，该配置项控制crud方法的生成")
	private boolean crud = true;

	// 生成新增方法
	@ApiModelProperty(name = "create",value = "生成新增方法，默认true ，该配置项控制create方法的生成")
	private boolean create = true;

	// 生成主键查询方法
	@ApiModelProperty(name = "read",value = "生成主键查询方法，默认true ，该配置项控制read方法的生成")
	private boolean read = true;

	// 生成分页查询方法
	@ApiModelProperty(name = "readList",value = "生成分页查询方法，默认true ，该配置项控制readList方法的生成")
	private boolean readList = true;

	// 生成删除方法
	@ApiModelProperty(name = "delete",value = "生成删除方法，默认true ，该配置项控制delete方法的生成")
	private boolean delete = true;

	// 生成前端代码的参数
	@ApiModelProperty(name = "delete",value = "生成前端代码的参数，该配置项控制前端代码的生成")
	private FrontProperty frontProperty = new FrontProperty();
}