package com.example.property;

/**
 * @Author: tang lirong
 * @Description: 数据库表生成代码的相关参数封装
 * @Date: Created in 2022/7/21 16:54
 */
public class TableInfoProperty {
    // 表名
    private String tableName;
    // 模块名称
    private String moduleName;
    // 生成文件类名
    private String className;
    // 请求路由地址
    private String router;

    public String getTableName() {
        return tableName;
    }

    public String getModuleName() {
        return moduleName;
    }

    public String getClassName() {
        return className;
    }

    public String getRouter() {
        return router;
    }

    public TableInfoProperty tableName(String tableName) {
        this.tableName = tableName;
        return this;
    }

    public TableInfoProperty moduleName(String moduleName) {
        this.moduleName = moduleName;
        return this;
    }

    public TableInfoProperty className(String className) {
        this.className = className;
        return this;
    }

    public TableInfoProperty router(String router) {
        this.router = router;
        return this;
    }
}
