package com.example.property;

import com.zaxxer.hikari.HikariConfig;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Value;

@Data
@ApiModel(value = "数据库表文档生成参数")
public class DocGeneProperty {

    // 生成文件名称
    @ApiModelProperty(name = "fileName",value = "生成文件名称")
    private String fileName;

    // 文档生成输出路径
    @Value("${generator.doc-path}")
    @ApiModelProperty(name = "outlet",value = "文档生成输出路径" , required = true)
    private String outlet;

    // 自定义生成的模板文件路径
    @ApiModelProperty(name = "tempPath",value = "自定义生成的模板文件路径" , hidden = true)
    private String tempPath;

    // 数据库连接配置
    @ApiModelProperty(name = "hikariConfig",value = "数据库连接配置" , hidden = true)
    private HikariConfig hikariConfig;

    public void setFileName(String fileName) {
        if(StringUtils.isEmpty(fileName)){
            this.fileName = "数据库设计文档";
            return;
        }
        this.fileName = fileName;
    }
}