package com.example.generate;

import java.util.Arrays;
import java.util.List;

import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.example.property.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.GlobalConfig;
import com.baomidou.mybatisplus.generator.config.PackageConfig;
import com.baomidou.mybatisplus.generator.config.StrategyConfig;
import com.baomidou.mybatisplus.generator.config.TemplateConfig;
import com.baomidou.mybatisplus.generator.config.TemplateType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.example.convert.MyTemplateEngine;
import com.example.util.GeneratorUtil;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 代码生成器
 *
 * @Date 2020/11/16
 */
@RestController
@Api(value = "代码生成器", tags = "代码生成器")
public class Generator {

	private static final Logger log = LoggerFactory.getLogger(Generator.class);

	// 项目目录
	@Value("${generator.outlet-path}")
	private String projectPath;
	// 作者
	@Value("${generator.outlet-author}")
	private String author;
	// 逻辑删除字段
	@Value("${generator.logic-delete-field}")
	private String logicDeleteField;
	// 项目模块包名
	@Value("${generator.base-package}")
	private String basePackage;
	// 数据库配置
	@Autowired
	private DataSourceConfig dataSourceConfig;

	private static MyTemplateEngine myTemplateEngine = new MyTemplateEngine();

	@PostMapping(value = "generate")
	@ApiOperation(value = "代码生成")
	public void generate(@RequestBody GenerateProperty property) {
		log.info("==========开始生成代码==========");
		// 表名为空，本次不生成代码
		if (StringUtils.isBlank(property.getTableNames())) {
			return;
		}
		// 将部分参数直接注入到模板变量中
		myTemplateEngine.initProperty(property);
		// 代码输出相关参数
		OutletProperty outlet = getOutletProperty(property);
		// 数据库表相关参数
		List<TableInfoProperty> tableProperties = GeneratorUtil.getTableNames(property);
		// 前端代码生成参数
		FrontProperty frontProperty = property.getFrontProperty();
		// 遍历，执行生成
		tableProperties.stream().forEach(prop -> {
			outletFile(prop, outlet , frontProperty);
		});
		log.info("==========代码生成结束==========");
	}

	/**
	 * 生成代码
	 */
	public void outletFile(TableInfoProperty property, OutletProperty outlet , FrontProperty frontProperty) {
		// 代码生成器
		AutoGenerator mpg = new AutoGenerator();

		// 相关模块输出参数
		ModuleProperty moduleProperty = GeneratorUtil.getModuleProperty(property, outlet.getBasePackage());

		// 全局配置
		GlobalConfig gc = GeneratorUtil.getGlobalConfig(outlet);
		mpg.setGlobalConfig(gc);
		// 数据源配置
		mpg.setDataSource(dataSourceConfig);
		// 包配置
		PackageConfig pc = new PackageConfig();
		pc.setModuleName(property.getModuleName());
		pc.setParent(outlet.getBasePackage());
		mpg.setPackageInfo(pc);

		// 自定义配置
		InjectionProperty injectionProperty = new InjectionProperty();
		injectionProperty.setModuleName(property.getModuleName());
		injectionProperty.setOutlet(gc.getOutputDir());
		injectionProperty.setModuleProperty(moduleProperty);
		injectionProperty.setFrontProperty(frontProperty);
		InjectionConfig cfg = GeneratorUtil.getInjectionConfig(injectionProperty);
		mpg.setCfg(cfg);

		// 配置模板
		TemplateConfig templateConfig = new TemplateConfig();
		templateConfig.disable(TemplateType.ENTITY, TemplateType.MAPPER, TemplateType.XML, TemplateType.SERVICE,TemplateType.CONTROLLER);
		mpg.setTemplate(templateConfig);

		// 策略配置
		StrategyConfig strategy = new StrategyConfig();

		strategy.setInclude(property.getTableName());
		strategy.setEntityLombokModel(true);
		strategy.setNaming(NamingStrategy.underline_to_camel);
		strategy.setColumnNaming(NamingStrategy.underline_to_camel);
		strategy.setEntityTableFieldAnnotationEnable(true);
		// restful api风格，无视图返回
		strategy.setRestControllerStyle(true);
		strategy.setLogicDeleteFieldName(logicDeleteField);
		mpg.setStrategy(strategy);

		mpg.setTemplateEngine(myTemplateEngine);
		mpg.execute();
	}

	/**
	 * 构建代码输出路径相关参数
	 * @param property
	 * @return
	 */
	public OutletProperty getOutletProperty(GenerateProperty property){
		String outletPackage = property.getOutletPackage();
		if (StringUtils.isBlank(projectPath)) {
			projectPath = System.getProperty("user.dir");
		}
		if (StringUtils.isNotBlank(outletPackage)) {
			basePackage = outletPackage;
		} else {
			if (StringUtils.isBlank(basePackage)) {
				basePackage = "com.example.code";
			}
		}
		OutletProperty outlet = new OutletProperty().author(author).projectPath(projectPath).basePackage(basePackage);
		return outlet;
	}
}