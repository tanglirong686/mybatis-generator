package com.example.util;

import java.util.*;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.FileOutConfig;
import com.baomidou.mybatisplus.generator.config.GlobalConfig;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.DateType;
import com.example.enums.CommonEnum;
import com.example.property.*;

/**
 * @Author: tang lirong
 * @Description: 生成工具类
 * @Date: Created in 2022/7/22 10:47
 */
public class GeneratorUtil {

	/**
	 * 获取表的相关参数
	 * 
	 * @param property 生成参数
	 * @return
	 */
	@SuppressWarnings("static-access")
	public static List<TableInfoProperty> getTableNames(GenerateProperty property) {
		// 表名前缀
		String prefix = property.getPrefix();
		// 表名
		String tableNames = property.getTableNames();
		List<String> tableNameArray = Arrays.asList(tableNames.split(","));
		// 返回结果
		List<TableInfoProperty> tables = new ArrayList<>();
		if (tableNameArray == null || tableNameArray.size() < 1) {
			return tables;
		}
		tableNameArray.stream().forEach(name -> {
			if(StringUtils.isNotBlank(prefix)){
				String newName = name.replace(prefix , "");
				TableInfoProperty tableInfo = getTableInfo(name , newName);
				tables.add(tableInfo);
			}else{
				TableInfoProperty tableInfo = getTableInfo(name , name);
				tables.add(tableInfo);
			}
		});
		return tables;
	}

	/**
	 * 通过表名转换为相关的字段
	 * @param name
	 * @return
	 */
	private static TableInfoProperty getTableInfo(String tableName ,String name){
		// 模块名称
		String moduleName = ConvertUtil.firstLower(ConvertUtil.underlineToHump(name));
		// 类名
		String className = ConvertUtil.firstUpper(ConvertUtil.underlineToHump(name));
		// 路由
		String router = "/" + ConvertUtil.underlineToHump(name.toLowerCase());
		TableInfoProperty tableInfo = new TableInfoProperty()
				.tableName(tableName)
				.className(className)
				.moduleName(moduleName)
				.router(router);
		return tableInfo;
	}

	/**
	 * 获取生成全局配置
	 * 
	 * @param outletProperty 输出参数封装
	 * @return
	 */
	public static GlobalConfig getGlobalConfig(OutletProperty outletProperty) {
		GlobalConfig gc = new GlobalConfig();
		// 代码输出完整路径
		String outlet = outletProperty.getProjectPath() + "/src/main/java/" + outletProperty.getBasePackage().replace(".", "/");
		gc.setOutputDir(outlet);
		gc.setAuthor(outletProperty.getAuthor());
		gc.setOpen(false);
		gc.setSwagger2(true);
		gc.setBaseColumnList(true);
		gc.setBaseResultMap(true);
		gc.setDateType(DateType.ONLY_DATE);
		return gc;
	}

	/**
	 * 注入自定义的相关配置
	 * @param property
	 * @return
	 */
	public static InjectionConfig getInjectionConfig(InjectionProperty property) {
		String outlet = property.getOutlet();
		String moduleName = property.getModuleName();
		ModuleProperty module = property.getModuleProperty();
		// 注入自定义的模板参数
		InjectionConfig cfg = new InjectionConfig() {
			@Override
			public void initMap() {
				Map<String, Object> map = new HashMap<>();
				map.put("Model", module);
				this.setMap(map);
			}
		};

		// 自定义输出配置
		List<FileOutConfig> focList = new ArrayList<>();
		// 模块输出目录
		String moduleOutPath = outlet + "/" + moduleName + "/";
		// 获取合并模板
		String[][] outConfigs = mergeTemplate(property);
		// 遍历模板
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

	/**
	 * 构建模板变量对象
	 * @param property 数据库表的参数
	 * @param basePackage 包名
	 * @return
	 */
	public static ModuleProperty getModuleProperty(TableInfoProperty property, String basePackage) {
		ModuleProperty moduleModel = new ModuleProperty();
		moduleModel.setEntity(property.getClassName());
		moduleModel.setMapper(property.getClassName() + "Mapper");
		moduleModel.setService(property.getClassName() + "Service");
		moduleModel.setServiceImpl(property.getClassName() + "ServiceImpl");
		moduleModel.setController(property.getClassName() + "Controller");
		moduleModel.setVo(property.getClassName() + "Vo");
		moduleModel.setDto(property.getClassName() + "Dto");
		moduleModel.setModulePackage(basePackage + "." + property.getModuleName());
		moduleModel.setRouter(property.getRouter());
		moduleModel.setPrefixName(property.getModuleName());
		return moduleModel;
	}

	/**
	 * 合并前后端模板
	 * @param property 注入参数
	 * @return
	 */
	private static String[][] mergeTemplate(InjectionProperty property){
		ModuleProperty module = property.getModuleProperty();
		FrontProperty frontProperty = property.getFrontProperty();

		// 获取前端模板配置
		Set<String> include = getInclude(frontProperty);
		String[][] front = getFrontTemplate(include , property.getModuleName());
		// 获取后端模板配置
		String[][] back = getBackTemplate(module);
		// 初始下标
		int init = 0;
		int index = front.length + back.length;
		String[][] result = new String[index][];
		// 合并前端模板
		for(String[] temp : front){
			result[init] = temp;
			init++;
		}
		// 合并后端模板
		for(String[] temp : back){
			result[init] = temp;
			init++;
		}
		return result;
	}

	/**
	 * 代码输出配置
	 *
	 * @param moduleModel 模块信息
	 * @return
	 */
	public static String[][] getBackTemplate(ModuleProperty moduleModel) {
		String[][] result = new String[][] {
			// entity
			{ "/templates/java/entity.java.ftl", "entity/" + moduleModel.getEntity() + ".java" },
			// mapper
			{ "/templates/java/mapper.java.ftl", "mapper/" + moduleModel.getMapper() + ".java" },
			// mapper xml
			{ "/templates/xml/mapper.xml.ftl", "mapper/" + moduleModel.getMapper() + ".xml" },
			// service
			{ "/templates/java/service.java.ftl", "service/" + moduleModel.getService() + ".java" },
			// serviceImpl
			{ "/templates/java/serviceImpl.java.ftl", "service/" + moduleModel.getServiceImpl() + ".java" },
			// controller
			{ "/templates/java/controller.java.ftl", "controller/" + moduleModel.getController() + ".java" },
			// vo
			{"/templates/java/vo.java.ftl", "vo/" + moduleModel.getVo() + ".java" },
			// dto
			{"/templates/java/dto.java.ftl", "dto/" + moduleModel.getDto() + ".java" }
		};
		return result;
	}

	/**
	 * 通过参数从枚举中获取前端模板名称
	 * @param property 前端代码生成参数
	 * @return
	 */
	public static Set<String> getInclude(FrontProperty property){
		Set<String> include = new HashSet<>();
		if(property.getType().equals(CommonEnum.FrontType.REACT.getValue())){
			if(property.isSimple()){
				include.add(CommonEnum.ReactPage.INDEX.getValue());
				include.add(CommonEnum.ReactPage.ADD_FORM.getValue());
				include.add(CommonEnum.ReactPage.EDIT_FORM.getValue());
			}else if(property.isSimpleTree()){
				include.add(CommonEnum.ReactPage.SIMPLE_TREE.getValue());
				include.add(CommonEnum.ReactPage.ADD_FORM.getValue());
				include.add(CommonEnum.ReactPage.EDIT_FORM.getValue());
				include.add(CommonEnum.ReactPage.TREE_NODE.getValue());
			}else if(property.isComplexTree()){
				include.add(CommonEnum.ReactPage.COMPLEX_TREE.getValue());
				include.add(CommonEnum.ReactPage.ADD_FORM.getValue());
				include.add(CommonEnum.ReactPage.EDIT_FORM.getValue());
				include.add(CommonEnum.ReactPage.TREE_NODE.getValue());
				include.add(CommonEnum.ReactPage.COMPLEX_TREE_CHILD_ADD.getValue());
				include.add(CommonEnum.ReactPage.COMPLEX_TREE_CHILD_EDIT.getValue());
			}else{
				// 默认生成简单页面
				include.add(CommonEnum.ReactPage.INDEX.getValue());
				include.add(CommonEnum.ReactPage.ADD_FORM.getValue());
				include.add(CommonEnum.ReactPage.EDIT_FORM.getValue());
			}
		}
		include.add(CommonEnum.ApiPage.API.getValue());
		include.add(CommonEnum.ApiPage.ACTION.getValue());
		include.add(CommonEnum.ApiPage.REDUCERS.getValue());
		return include;
	}

	/**
	 * 获取前端模板
	 * @param include
	 * @return
	 */
	public static String[][] getFrontTemplate(Set<String> include , String moduleName) {
		String[][] includeList = new String[][] {
				// react index
				{ "/templates/front/react/index.js.ftl", "front/react/index.js" },
				// react add-form
				{ "/templates/front/react/add-form.js.ftl", "front/react/component/add-form.js" },
				// react edit-form
				{ "/templates/front/react/edit-form.js.ftl", "front/react/component/edit-form.js" },
				// react simple-tree
				{ "/templates/front/react/simple_tree.js.ftl", "front/react/simple_tree.js" },
				// react tree-node
				{ "/templates/front/react/tree_node.js.ftl", "front/react/component/treeNode.js" },
				// react complex-tree
				{ "/templates/front/react/complex_tree.js.ftl", "front/react/complex_tree.js" },
				// react add-child-form
				{ "/templates/front/react/add-child-form.js.ftl", "front/react/component/add-child-form.js" },
				// react edit-child-form
				{ "/templates/front/react/edit-child-form.js.ftl", "front/react/component/edit-child-form.js" },
				// api
				{ "/templates/front/api/api.js.ftl", "front/api/" + moduleName + ".js" },
				// action
				{ "/templates/front/store/action.js.ftl", "front/store/action/" + moduleName + ".js" },
				// reducer
				{ "/templates/front/store/reducers.js.ftl", "front/store/reducer/" + moduleName + ".js" }
		};
		String[][] result = new String[include.size()][2];
		int index = 0;
		for(String c : include){
			for (int i = 0; i < includeList.length; i++) {
				String template = includeList[i][0];
				if(template.contains(c) || template.endsWith(c)){
					result[index] = includeList[i];
					index ++;
				}
			}
		}
		return result;
	}
}