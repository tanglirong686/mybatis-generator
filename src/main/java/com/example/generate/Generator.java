package com.example.generate;

import java.util.Arrays;
import java.util.List;

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
import com.example.property.GenerateProperty;
import com.example.property.ModuleProperty;
import com.example.property.OutletProperty;
import com.example.property.TableInfoProperty;
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
	public void generate(@RequestBody GenerateProperty generateProperty) {
		log.info("==========开始生成代码==========");
		String outletPackage = generateProperty.getOutletPackage();
		// 表名
		String tableNames = generateProperty.getTableNames();

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
		if (StringUtils.isBlank(tableNames)) {
			return;
		}
		myTemplateEngine.initProperty(generateProperty);
		OutletProperty outlet = new OutletProperty().author(author).projectPath(projectPath).basePackage(basePackage);
		List<String> tableNameArray = Arrays.asList(tableNames.split(","));
		List<TableInfoProperty> tableProperties = GeneratorUtil.getTableNames(tableNameArray);
		// 遍历，执行生成
		tableProperties.stream().forEach(prop -> {
			outletFile(prop, outlet);
		});
		log.info("==========代码生成结束==========");
	}

	/**
	 * 生成代码
	 */
	public void outletFile(TableInfoProperty property, OutletProperty outlet) {
		// 代码生成器
		AutoGenerator mpg = new AutoGenerator();

		// 设置
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
		InjectionConfig cfg = GeneratorUtil.getInjectionConfig(moduleProperty, property.getModuleName(),
			gc.getOutputDir());
		mpg.setCfg(cfg);

		// 配置模板
		TemplateConfig templateConfig = new TemplateConfig();
		templateConfig.disable(TemplateType.ENTITY, TemplateType.MAPPER, TemplateType.XML, TemplateType.SERVICE,
			TemplateType.CONTROLLER);
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
}
