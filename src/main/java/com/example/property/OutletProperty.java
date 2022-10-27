package com.example.property;

/**
 * @Author: tang lirong
 * @Description: 生成输出参数封装
 * @Date: Created in 2022/7/22 14:49
 */
public class OutletProperty {

    // 项目目录
    private String projectPath;
    // 作者
    private String author;
    // 项目模块包名
    private String basePackage;

    public String getProjectPath() {
        return projectPath;
    }

    public String getAuthor() {
        return author;
    }

    public String getBasePackage() {
        return basePackage;
    }

    public OutletProperty projectPath(String projectPath) {
        this.projectPath = projectPath;
        return this;
    }

    public OutletProperty author(String author) {
        this.author = author;
        return this;
    }

    public OutletProperty basePackage(String basePackage) {
        this.basePackage = basePackage;
        return this;
    }
}
