package com.example.generate;

import com.example.util.DocumentUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @description 数据库文档生成
 * @author tang lirong
 * @createtime 2023/8/18 15:52
 */
@RestController
@Api(value = "数据库文档生成", tags = "数据库文档生成")
public class DocumentGenerator {

    private static final Logger log = LoggerFactory.getLogger(DocumentGenerator.class);

    @PostMapping(value = "generateWord")
    @ApiOperation(value = "word文档生成")
    public void generateWord() {
        log.info("==========开始生成==========");
        DocumentUtil.generateWord();
        log.info("==========生成结束==========");
    }
}