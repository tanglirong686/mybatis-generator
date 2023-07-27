package com.example.property;

import io.swagger.annotations.ApiModel;
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
	private String tableNames;

	// 表名前缀
	private String prefix;

	// 模块输出包名
	private String outletPackage;

	// 是否生成crud方法
	private boolean crud = true;

	// 生成新增方法
	private boolean create = true;

	// 生成主键查询方法
	private boolean read = true;

	// 生成分页查询方法
	private boolean readList = true;

	// 生成删除方法
	private boolean delete = true;
}
