import { connect } from "react-redux";
import React, { useState, useEffect } from "react";
import { Card, Button, Table, message, Divider, Pagination, Tag, Modal, Row, Col } from "antd";
import { EditOutlined, DeleteOutlined, PlusCircleOutlined } from '@ant-design/icons';
// 导入action接口
import {
    ${cfg.Model.prefixName}DataList get${cfg.Model.entity}, add${cfg.Model.entity},save${cfg.Model.entity}, delete${cfg.Model.entity}
} from "@/store/actions";

import Add${cfg.Model.entity}Form from "./component/add-form";
import Edit${cfg.Model.entity}Form from "./component/edit-form";

const ${cfg.Model.entity}Page = (props)=> {
    const {
        ${cfg.Model.prefixName}Info,
        ${cfg.Model.prefixName}DataList,get${cfg.Model.entity}, add${cfg.Model.entity},
        save${cfg.Model.entity}, delete${cfg.Model.entity}
    } = props;
    // 从state中取出数据
    const { dataList, total, pagination, dataInfo } = ${cfg.Model.prefixName}Info;

    const [loading, setLoading] = useState(false);
    // 是否打开新增表单
    const [addVisible, setAddVisible] = useState(false);
    // 是否打开编辑表单
    const [editVisible, setEditVisible] = useState(false);
    // 查询表单
    const queryFormRef = React.createRef();
    // 数据表单
    const dataFormRef = React.createRef();

    // 初始化调用
    useEffect(() => {
        fetchTable();
    }, []);
    // 加载表格数据
    const fetchTable = () => {
        setLoading(true);
        ${cfg.Model.prefixName}DataList(pagination)
        .then((resp) => {
            setLoading(false);
        }).catch((error) => {
            message.error(error.msg);
        });
    };
    // 翻页相关
    const changePage = (pageNumber, pageSize) => {
        pagination.current = pageNumber;
        fetchTable();
    };
    const changePageSize = (current, pageSize) => {
        pagination.pageSize = pageSize;
        fetchTable();
    };
    // 表单关闭
    const handleCancel = () => {
        setAddVisible(false);
        setEditVisible(false);
    };
    // 打开新增表单
    const handleAdd = () => {
        add${cfg.Model.entity}().then((res) => {
            setAddVisible(true);
        });
    };
    // 新增保存数据
    const handleAddSave = async () => {
        const formValues = await dataFormRef.current.validateFields();
        console.log(formValues);
        save${cfg.Model.entity}(formValues).then((resp) => {
            setAddVisible(false);
            message.success("添加成功!")
            fetchTable();
        }).catch(e => {
            message.success("添加失败,请重试!")
        });
    };
    // 打开编辑表单
    const handleEdit = (row) => {
        const param = { ${cfg.Model.prefixName}Id: row.${cfg.Model.prefixName}Id };
        get${cfg.Model.entity}(param).then((res) => {
            setEditVisible(true);
        });
    };
    // 编辑保存数据
    const handleEditSave = async () => {
        const formValues = await dataFormRef.current.validateFields();
        console.log(formValues);
        save${cfg.Model.entity}(formValues).then((resp) => {
            setEditVisible(false);
            message.success("修改成功!")
            fetchTable();
        }).catch(e => {
            message.success("修改失败,请重试!")
        });
    };
    // 删除数据
    const handleDelete = (row) => {
        const param = { ${cfg.Model.prefixName}Id: row.${cfg.Model.prefixName}Id };
        Modal.confirm({
            title: "删除",
            content: "确定要删除数据吗?",
            okText: "确定",
            cancelText: "取消",
            onOk: () => {
                delete${cfg.Model.entity}(param)
                .then(res => {
                    message.success("删除成功")
                    fetchTable();
                }).catch((error) => {
                    message.error(error.msg);
                });
            },
        });
    };
    // 定义操作按钮
    const title = (
        <span>
            <Button type='primary' shape="circle" icon={<PlusCircleOutlined/>} title="新增" onClick={handleAdd} />
        </span>
    );
    // 返回组件内容
    return (
    <div className="app-container">
        <Collapse defaultActiveKey={["1"]}>
            <Panel header="筛选" key="1">
                <Form ref={queryFormRef}>
                    <Row gutter={24}>
                    <#list table.fields as field>
                        <#if field.propertyType=="String">
                        <Col span={4}>
                        <Form.Item label="${field.comment}:" name="${field.propertyName}">
                            <Input placeholder="请输入${field.comment}" />
                        </Form.Item>
                        </Col>
                        </#if>
                    </#list>
                    </Row>
                    <Row gutter={24}>
                        <Col span={2} push={20}>
                        <Form.Item>
                            <Button type="primary" icon={<SearchOutlined/>} onClick={filterQuery}>搜索</Button>
                        </Form.Item>
                        </Col>
                        <Col span={2} push={0}>
                        <Form.Item>
                            <Button type="button" icon={<ReloadOutlined/> } onClick={reloadQuery}>重置</Button>
                        </Form.Item>
                        </Col>
                    </Row>
                </Form>
            </Panel>
        </Collapse>
        <br/>
        <Card title={title}>
            <Table
                bordered
                rowKey={(record)=> record.${cfg.Model.prefixName}Id}
                dataSource={dataList}
                loading={loading}
                pagination={false}
                size="small"
            >
            <#list table.fields as field>
                <#if !field.keyFlag>
                    <#if (logicDeleteFieldName!"") == field.name>
                    <#else >
                <Column title="${field.comment}" dataIndex="${field.propertyName}" key="${field.propertyName}" align="center"/>
                    </#if>
                </#if>
            </#list>
                <Column title="操作" key="action" width={100} align="center" render={(text, row)=> (
                    <span>
                      <Button type="primary" shape="circle" icon={<EditOutlined/>} title="编辑" onClick={handleEdit.bind(null, row)} />
                      <Divider type="vertical"/>
                      <Button type="primary" danger shape="circle" icon={<DeleteOutlined/>} title="删除" onClick={handleDelete.bind(null, row)} />
                    </span>
                )} />
            </Table>
            <br/>
            <Pagination
                total={total}
                pageSizeOptions={["10", "20", "40"]}
                showTotal={(total) => "共{total}条数据"}
                onChange={changePage}
                current={pagination.current}
                pageSize={pagination.pageSize}
                onShowSizeChange={changePageSize}
                showSizeChanger
            />
        </Card>
        <Add${cfg.Model.entity}Form
            currentRowData={dataInfo}
            wrappedComponentRef={dataFormRef}
            open={addVisible}
            onCancel={handleCancel}
            onOk={handleAddSave}
        />
        <Edit${cfg.Model.entity}Form
            currentRowData={dataInfo}
            wrappedComponentRef={dataFormRef}
            open={editVisible}
            onCancel={handleCancel}
            onOk={handleEditSave}
        />
    </div>
  );
}

const request = {
    ${cfg.Model.prefixName}DataList,get${cfg.Model.entity}, add${cfg.Model.entity},
    save${cfg.Model.entity}, delete${cfg.Model.entity}
};
export default connect((state) => state.${cfg.Model.prefixName}, request)(${cfg.Model.entity});