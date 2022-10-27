package com.example.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.FileOutConfig;
import com.baomidou.mybatisplus.generator.config.GlobalConfig;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.DateType;
import com.example.convert.TemplateMethod;
import com.example.property.ModuleProperty;
import com.example.property.OutletProperty;
import com.example.property.TableInfoProperty;

/**
 * @Author: tang lirong
 * @Description: 生成工具类
 * @Date: Created in 2022/7/22 10:47
 */
public class GeneratorUtil {

	private static TemplateMethod templateMethod = new TemplateMethod();

	/**
	 * 获取表的相关参数
	 * 
	 * @param tableNameArray 表名数组
	 * @return
	 */
	@SuppressWarnings("static-access")
	public static List<TableInfoProperty> getTableNames(List<String> tableNameArray) {
		List<TableInfoProperty> tables = new ArrayList<>();
		if (tableNameArray == null || tableNameArray.size() < 1) {
			return tables;
		}
		tableNameArray.stream().forEach(name -> {
			// 模块名称
			String moduleName = templateMethod.firstLower(templateMethod.underlineToHump(name));
			// 类名
			String className = templateMethod.firstUpper(templateMethod.underlineToHump(name));
			// 路由
			String router = "/" + templateMethod.underlineToHump(name.toLowerCase());
			TableInfoProperty tableInfo = new TableInfoProperty().tableName(name).className(className)
				.moduleName(moduleName).router(router);
			tables.add(tableInfo);
		});
		return tables;
	}

	/**
	 * 获取生成全局配置
	 * 
	 * @param outletProperty 输出参数封装
	 * @return
	 */
	public static GlobalConfig getGlobalConfig(OutletProperty outletProperty) {
		GlobalConfig gc = new GlobalConfig();
		gc.setOutputDir(
			outletProperty.getProjectPath() + "/src/main/java/" + outletProperty.getBasePackage().replace(".", "/"));
		gc.setAuthor(outletProperty.getAuthor());
		gc.setOpen(false);
		gc.setSwagger2(true);
		gc.setBaseColumnList(true);
		gc.setBaseResultMap(true);
		gc.setDateType(DateType.ONLY_DATE);
		return gc;
	}

	public static InjectionConfig getInjectionConfig(ModuleProperty module, String moduleName, String outlet) {
		InjectionConfig cfg = new InjectionConfig() {
			@Override
			public void initMap() {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("templateMethod", new TemplateMethod());
				map.put("moduleModel", module);
				this.setMap(map);
			}
		};

		// 自定义输出配置
		List<FileOutConfig> focList = new ArrayList<>();
		// 模块输出目录
		String moduleOutPath = outlet + "/" + moduleName + "/";
		// 获取配置
		String[][] outConfigs = GeneratorUtil.outConfig(module);
		for (String[] outConfig : outConfigs) {
			focList.add(new FileOutConfig(outConfig[0]) {
				@Override
				public String outputFile(TableInfo tableInfo) {
					return moduleOutPath + outConfig[1];
				}
			});
		}
		cfg.setFileOutConfigList(focList);
		return cfg;
	}

	public static ModuleProperty getModuleProperty(TableInfoProperty property, String basePackage) {
		ModuleProperty moduleModel = new ModuleProperty();
		moduleModel.setEntity(property.getClassName());
		moduleModel.setMapper("I" + property.getClassName() + "Mapper");
		moduleModel.setService("I" + property.getClassName() + "Service");
		moduleModel.setServiceImpl(property.getClassName() + "ServiceImpl");
		moduleModel.setController(property.getClassName() + "Controller");
		moduleModel.setVo(property.getClassName() + "VO");
		moduleModel.setCondition(property.getClassName() + "DTO");
		moduleModel.setModulePackage(basePackage + "." + property.getModuleName());
		moduleModel.setServiceInstance(templateMethod.firstLower(property.getClassName()) + "Service");
		moduleModel.setConditionInstance(templateMethod.firstLower(moduleModel.getCondition()));
		moduleModel.setRouter(property.getRouter());
		return moduleModel;
	}

	/**
	 * 代码输出配置
	 *
	 * @param moduleModel 模块信息
	 * @return
	 */
	public static String[][] outConfig(ModuleProperty moduleModel) {
		String[][] result = new String[][] {
			// entity
			{ "/templates/entity.java.ftl", "entity/" + moduleModel.getEntity() + ".java" },
			// mapper
			{ "/templates/mapper.java.ftl", "mapper/" + moduleModel.getMapper() + ".java" },
			// mapper xml
			{ "/templates/mapper.xml.ftl", "mapper/mapper/" + moduleModel.getMapper() + ".xml" },
			// service
			{ "/templates/service.java.ftl", "service/" + moduleModel.getService() + ".java" },
			// serviceImpl
			{ "/templates/serviceImpl.java.ftl", "service/impl/" + moduleModel.getServiceImpl() + ".java" },
			// controller
			{ "/templates/controller.java.ftl", "controller/" + moduleModel.getController() + ".java" },
			// vo
			{ "/templates/vo.java.ftl", "vo/" + moduleModel.getVo() + ".java" },
			// condition
			{ "/templates/dto.java.ftl", "dto/" + moduleModel.getCondition() + ".java" } };

		return result;
	}

}
