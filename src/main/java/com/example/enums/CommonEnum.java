package com.example.enums;

/**
 * 枚举类
 */
public class CommonEnum {

    /**
     * 前端模板类型
     */
    public enum FrontType{
        REACT("react"), VUE("vue"), VUE3("vue3");
        private String value;

        public String getValue() {
            return value;
        }
        FrontType(String value) {
            this.value = value;
        }
    }

    /**
     * React 生成代码的模板页面枚举
     */
    public enum ReactPage{
        INDEX("index.js.ftl"),
        ADD_FORM("add-form.js.ftl"),
        EDIT_FORM("edit-form.js.ftl"),
        SIMPLE_TREE("simple_tree.js.ftl"),
        TREE_NODE("tree_node.js.ftl"),
        COMPLEX_TREE_CHILD_ADD("add-child-form.js.ftl"),
        COMPLEX_TREE_CHILD_EDIT("edit-child-form.js.ftl"),
        COMPLEX_TREE("complex_tree.js.ftl");
        private String value;

        public String getValue() {
            return value;
        }
        ReactPage(String value) {
            this.value = value;
        }
    }

    /**
     * api 相关模板文件
     */
    public enum ApiPage{
        API("api.js.ftl"),
        ACTION("action.js.ftl"),
        REDUCERS("reducers.js.ftl");
        private String value;

        public String getValue() {
            return value;
        }
        ApiPage(String value) {
            this.value = value;
        }
    }
}