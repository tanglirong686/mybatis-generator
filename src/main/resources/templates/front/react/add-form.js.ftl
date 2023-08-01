import React, { Component } from "react";
import { Form, Input, Modal, Select , Radio, InputNumber , DatePicker } from "antd";

class Add${cfg.Model.entity}Form extends Component {
  render() {
    // 从props取出父组件传入的参数
    const { open, onCancel, onOk, wrappedComponentRef, currentRowData } = this.props;
    // 表单字段
    const {
    <#list table.fields as field>
    <#if !field.keyFlag>
        ${field.propertyName},
    </#if>
    </#list>
    } = currentRowData;
    // 表单布局
    const formItemLayout = {
      labelCol: {
        sm: { span: 4 },
      },
      wrapperCol: {
        sm: { span: 16 },
      },
    };
    return (
      <Modal title="新增"
         open={open}
         onCancel={onCancel}
         onOk={onOk}
         destroyOnClose
      >
          <Form {...formItemLayout} ref={wrappedComponentRef}>
            <Form.Item name="${cfg.Model.prefixName}Id" initialValue={${cfg.Model.prefixName}Id} hidden={true} />
          <#list table.fields as field>
              <#if field.propertyType=="Integer">
            <Form.Item label="${field.comment}:" name="${field.propertyName}" initialValue={${field.propertyName} ? ${field.propertyName} : 1}>
                <InputNumber style={{width:"100%"}} placeholder="请输入${field.comment}" />
            </Form.Item>
              </#if>
              <#if field.propertyType=="String">
            <Form.Item label="${field.comment}:" name="${field.propertyName}" initialValue={${field.propertyName}}
               rules={[{ required: true, message: "请输入${field.comment} !" }]}>
                <Input placeholder="请输入${field.comment}" />
            </Form.Item>
              </#if>
              <#if field.propertyType=="Boolean">
            <Form.Item label="${field.comment}:" name="${field.propertyName}" initialValue={${field.propertyName}}>
                <Radio.Group>
                    <Radio value={true}>是</Radio>
                    <Radio value={false}>否</Radio>
                </Radio.Group>
            </Form.Item>
              </#if>
              <#if field.propertyType=="LocalDateTime" || field.propertyType=="Date" >
            <Form.Item label="${field.comment}:" name="${field.propertyName}" initialValue={${field.propertyName}}>
                <DatePicker placeholder="请选择${field.comment}" />
            </Form.Item>
              </#if>
              <#if field.propertyName=="selected" >
            <Form.Item label="Select">
                <Select>
                    <Select.Option value="demo">Demo</Select.Option>
                </Select>
            </Form.Item>
              </#if>
          </#list>
          </Form>
      </Modal>
    );
  }
}

export default Add${cfg.Model.entity}Form;