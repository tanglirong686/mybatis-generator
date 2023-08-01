package com.example.property;

import com.example.enums.CommonEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 前端代码生成参数
 */
@ApiModel(value = "前端代码生成参数")
public class FrontProperty {
    // 前端使用的模板类型（React or Vue or ...）
    @ApiModelProperty(name = "type",value = "前端使用的模板类型，默认react ，该配置项控制前端使用哪种模板")
    private String type = CommonEnum.FrontType.REACT.getValue();

    // 简单单表的增删改查
    @ApiModelProperty(name = "simple",value = "默认true ，该配置控制使用模板生成简单的单表增删改查功能")
    private boolean simple = true;

    // 简单的节点树页面（数据来自同一张表）
    @ApiModelProperty(name = "simpleTree",value = "默认false ，该配置项控制使用模板生成单表的Tree的增删改查功能")
    private boolean simpleTree = false;

    // 复杂的节点树页面（数据来自两张不同的表）
    @ApiModelProperty(name = "complexTree",value = "默认false ，该配置项控制使用模板生成复杂的Tree增删改查功能（数据来自两张不同的表）")
    private boolean complexTree = false;

    public FrontProperty() {
    }

    public FrontProperty(String type, boolean simple, boolean simpleTree, boolean complexTree) {
        this.type = type;
        this.simple = simple;
        this.simpleTree = simpleTree;
        this.complexTree = complexTree;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean isSimple() {
        return simple;
    }

    public void setSimple(boolean simple) {
        this.simple = simple;
    }

    public boolean isSimpleTree() {
        return simpleTree;
    }

    public void setSimpleTree(boolean simpleTree) {
        this.simpleTree = simpleTree;
    }

    public boolean isComplexTree() {
        return complexTree;
    }

    public void setComplexTree(boolean complexTree) {
        this.complexTree = complexTree;
    }
}