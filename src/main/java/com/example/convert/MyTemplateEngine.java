package com.example.convert;

import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import com.baomidou.mybatisplus.core.toolkit.StringPool;
import com.baomidou.mybatisplus.generator.config.ConstVal;
import com.baomidou.mybatisplus.generator.config.builder.ConfigBuilder;
import com.baomidou.mybatisplus.generator.engine.AbstractTemplateEngine;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

import com.example.property.GenerateProperty;
import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * @description 自定义模板引擎
 * @author tanglirong
 */
public class MyTemplateEngine extends AbstractTemplateEngine{
	
	private Configuration configuration;

    private boolean crud;

    private boolean create;

    private boolean read;

    private boolean readList;

    private boolean delete;

	@Override
	@SuppressWarnings("deprecation")
    public MyTemplateEngine init(ConfigBuilder configBuilder) {
        super.init(configBuilder);
        configuration = new Configuration();
        configuration.setDefaultEncoding(ConstVal.UTF8);
        configuration.setClassForTemplateLoading(FreemarkerTemplateEngine.class, StringPool.SLASH);
        return this;
    }

    @Override
    public void writer(Map<String, Object> objectMap, String templatePath, String outputFile) throws Exception {
        Template template = configuration.getTemplate(templatePath);
        try (FileOutputStream fileOutputStream = new FileOutputStream(outputFile)) {
        	// 重设模板文件中时间格式化方式
			objectMap.put("date", new SimpleDateFormat("yyyy/MM/dd").format(new Date()));
			// 自定义模板变量
			objectMap.put("crud", this.crud);
			objectMap.put("isRead", this.read);
			objectMap.put("isReadList", this.readList);
			objectMap.put("isCreate", this.create);
			objectMap.put("isDelete", this.delete);
        	template.process(objectMap, new OutputStreamWriter(fileOutputStream, ConstVal.UTF8));
        }
        logger.debug("模板:" + templatePath + ";  文件:" + outputFile);
    }

    @Override
    public String templateFilePath(String filePath) {
        return filePath + ".tl";
    }

    /**
     * 初始化设置生成的相关自定义参数
     * @param property
     */
    public void initProperty(GenerateProperty property){
        this.crud = property.isCrud();
        this.create = property.isCreate();
        this.read = property.isRead();
        this.readList = property.isReadList();
        this.delete = property.isDelete();
    }
}