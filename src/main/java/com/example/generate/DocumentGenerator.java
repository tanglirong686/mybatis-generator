package com.example.generate;

import com.example.property.DocGeneProperty;
import com.example.util.DocumentUtil;
import com.zaxxer.hikari.HikariConfig;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * @description 数据库文档生成
 * @author tang lirong
 * @createtime 2023/8/18 15:52
 */
@RestController
@Api(value = "数据库文档生成", tags = "数据库文档生成")
public class DocumentGenerator {

    @Autowired
    private HikariConfig hikariConfig;

    private static final Logger log = LoggerFactory.getLogger(DocumentGenerator.class);

    // 自定义模板文件路径
    private static final String TEMPLATE_PATH = "I:\\workspace\\mybatis-generator\\resources\\templates\\document\\documentation_word.ftl";

    @PostMapping(value = "generateWord")
    @ApiOperation(value = "word文档生成")
    public void generateWord(@RequestBody  DocGeneProperty property) {
        log.info("==========开始生成==========");
        property.setHikariConfig(hikariConfig);
        property.setTempPath(TEMPLATE_PATH);
        DocumentUtil.generateWord(property);
        log.info("==========生成结束==========");
    }
}