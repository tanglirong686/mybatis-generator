package com.example.property;

/**
 * 自定义配置注入的参数
 */
public class InjectionProperty {
    // 模块名称
    private String moduleName ;
    // 输出路径
    private String outlet ;
    private ModuleProperty moduleProperty;
    private FrontProperty frontProperty;

    public InjectionProperty() {
    }

    public InjectionProperty(String moduleName, String outlet, ModuleProperty moduleProperty, FrontProperty frontProperty) {
        this.moduleName = moduleName;
        this.outlet = outlet;
        this.moduleProperty = moduleProperty;
        this.frontProperty = frontProperty;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getOutlet() {
        return outlet;
    }

    public void setOutlet(String outlet) {
        this.outlet = outlet;
    }

    public ModuleProperty getModuleProperty() {
        return moduleProperty;
    }

    public void setModuleProperty(ModuleProperty moduleProperty) {
        this.moduleProperty = moduleProperty;
    }

    public FrontProperty getFrontProperty() {
        return frontProperty;
    }

    public void setFrontProperty(FrontProperty frontProperty) {
        this.frontProperty = frontProperty;
    }
}