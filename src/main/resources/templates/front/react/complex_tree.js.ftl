import { connect } from "react-redux";
import React, { useState, useEffect } from "react";
import { Card, Button, Table, message, Divider, Pagination, Tag, Modal, Row, Col } from "antd";
import { EditOutlined, DeleteOutlined, PlusCircleOutlined } from '@ant-design/icons';
// 导入action接口
import {
    ${cfg.Model.prefixName}DataList,${cfg.Model.prefixName}TreeList,${cfg.Model.prefixName}SelectList,
    get${cfg.Model.entity}, add${cfg.Model.entity},save${cfg.Model.entity}, delete${cfg.Model.entity},
    get${cfg.Model.entity}Children, add${cfg.Model.entity}Children,save${cfg.Model.entity}Children, delete${cfg.Model.entity}Children
} from "@/store/actions";

import TreeNode from "./component/treeNode";
import Add${cfg.Model.entity}Form from "./component/add-form";
import Edit${cfg.Model.entity}Form from "./component/edit-form";
// 子级表单组件
import Add${cfg.Model.entity}ChildrenForm from "./component/add-child-form";
import Edit${cfg.Model.entity}ChildrenForm from "./component/edit-child-form";

const ${cfg.Model.entity}Page = (props)=> {
    // 定义数据接口
    const {
        ${cfg.Model.prefixName}Info,
        ${cfg.Model.prefixName}DataList,${cfg.Model.prefixName}TreeList,${cfg.Model.prefixName}SelectList,
        get${cfg.Model.entity}, add${cfg.Model.entity},save${cfg.Model.entity}, delete${cfg.Model.entity},
        get${cfg.Model.entity}Children, add${cfg.Model.entity}Children,save${cfg.Model.entity}Children, delete${cfg.Model.entity}Children
    } = props;
    // 从state中取出数据
    const { dataList, total, pagination, dataInfo,${cfg.Model.entity}ChildrenInfo , treeList , selectList , activeIndex } = ${cfg.Model.prefixName}Info;

    const [loading, setLoading] = useState(false);
    // 是否打开新增表单
    const [addVisible, setAddVisible] = useState(false);
    // 是否打开编辑表单
    const [editVisible, setEditVisible] = useState(false);
    // 是否打开子级表单
    const [childVisible, setChildVisible] = useState(false);
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
        // 节点树数据
        ${cfg.Model.prefixName}TreeList.then((resp) => {});
        // 父级下拉选择数据
        ${cfg.Model.prefixName}SelectList.then((resp) => {});
    };
    // 点击行高亮设置
    const setClassName = (record, index) => {
        // 判断索引相等时添加行的高亮样式
        if (activeIndex) {
            return record.${cfg.Model.prefixName}Id === activeIndex ? 'selected' : "";
        }
        return "";
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
        setChildVisible(false);
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
    const handleEdit = () => {
        if (activeIndex) {
            const param = { ${cfg.Model.prefixName}Id: activeIndex };
            get${cfg.Model.entity}(param).then((res) => {
                setEditVisible(true);
            });
        } else {
            message.warning("请选中一行数据后再进行本操作!")
        }
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
    const handleDelete = () => {
        if (activeIndex) {
            const param = { ${cfg.Model.prefixName}Id: activeIndex };
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
        } else {
            message.warning("请选中一行数据后再进行本操作!")
        }
    };
    // 打开新增子级表单
    const handleAddChildren = () => {
        add${cfg.Model.entity}Children().then((res) => {
            setChildVisible(true);
        });
    };
    // 新增保存子级数据
    const handleAddSaveChildren = async () => {
        const formValues = await dataFormRef.current.validateFields();
        console.log(formValues);
        save${cfg.Model.entity}Children(formValues).then((resp) => {
            setChildVisible(false);
            message.success("添加成功!")
            fetchTable();
        }).catch(e => {
            message.success("添加失败,请重试!")
        });
    };
    // 打开编辑子级表单
    const handleEditChildren = () => {
        if (activeIndex) {
            const param = { childrenId: activeIndex };
            get${cfg.Model.entity}Children(param).then((res) => {
                setChildVisible(true);
            });
        } else {
            message.warning("请选中一行数据后再进行本操作!")
        }
    };
    // 编辑保存子级数据
    const handleEditSaveChildren = async () => {
        const formValues = await dataFormRef.current.validateFields();
        console.log(formValues);
        save${cfg.Model.entity}Children(formValues).then((resp) => {
            setChildVisible(false);
            message.success("修改成功!")
            fetchTable();
        }).catch(e => {
            message.success("修改失败,请重试!")
        });
    };
    // 删除数据
    const handleDeleteChildren = () => {
        if (activeIndex) {
            const param = { childrenId: activeIndex };
            Modal.confirm({
                title: "删除",
                content: "确定要删除数据吗?",
                okText: "确定",
                cancelText: "取消",
                onOk: () => {
                    delete${cfg.Model.entity}Children(param)
                    .then(res => {
                        message.success("删除成功")
                        fetchTable();
                    }).catch((error) => {
                        message.error(error.msg);
                    });
                },
            });
        } else {
            message.warning("请选中一行数据后再进行本操作!")
        }
    };
    // 定义操作按钮
    const title = (
        <span>
            <Button type='primary' shape="circle" icon={<PlusCircleOutlined/>} title="新增" onClick={handleAdd} />
            <Divider type="vertical"/>
            <Button type="primary" shape="circle" icon={<EditOutlined/>} title="编辑" onClick={handleEdit} />
            <Divider type="vertical"/>
            <Button type="danger"  shape="circle" icon={<DeleteOutlined/>} title="删除" onClick={handleDelete} />
            <Divider type="vertical"/>
            <Button type="primary" shape="circle" icon={<PlusCircleOutlined/>} title="新增子级" onClick={handleAddChildren} />
        </span>
    );
    const onSelect = (keys, info) => {
        const node = info.node;
        if(info.selected && node.children){
            const key = node.key;
            // 设置条件参数
            //pagination.parentId = key;
            fetchTable();
        }else if(info.selected && node.isLeaf){
            // 选中了子级树节点
            const key = node.key;
        }else{
            // 清空参数
            //pagination.parentId = "";
            fetchTable();
        }
    };
    // 返回组件内容
    return (
    <div className="app-container">
        <Card>
            <Row gutter={24}>
                <Col span={4}>
                    <TreeNode treeData={treeList} onSelect={onSelect} rightDom={document.getElementsByClassName("table-card")} />
                </Col>
                <Col span={20}>
                <Card title={title} className="table-card">
                    <Table
                        bordered
                        rowKey={(record)=> record.${cfg.Model.prefixName}Id}
                        dataSource={dataList}
                        loading={loading}
                        pagination={false}
                        size="small">
                    <#list table.fields as field>
                        <#if !field.keyFlag>
                            <#if (logicDeleteFieldName!"") == field.name>
                            <#else >
                        <Column title="${field.comment}" dataIndex="${field.propertyName}" key="${field.propertyName}" align="center"/>
                            </#if>
                        </#if>
                    </#list>
                    </Table>
                    <br/>
                    <Pagination
                        total={total}
                        pageSizeOptions={["10", "20", "40"]}
                        showTotal={(total) => `共{total}条数据`}
                        onChange={changePage}
                        current={pagination.current}
                        pageSize={pagination.pageSize}
                        onShowSizeChange={changePageSize}
                        showSizeChanger
                    />
                </Card>
                </Col>
            </Row>
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
        <Add${cfg.Model.entity}ChildrenForm
            currentRowData={${cfg.Model.entity}ChildrenInfo}
            wrappedComponentRef={dataFormRef}
            open={childVisible}
            onCancel={handleCancel}
            onOk={handleAddSaveChildren}
        />
        <Edit${cfg.Model.entity}ChildrenForm
            currentRowData={${cfg.Model.entity}ChildrenInfo}
            wrappedComponentRef={dataFormRef}
            open={childVisible}
            onCancel={handleCancel}
            onOk={handleEditSaveChildren}
        />
    </div>
  );
}

const request = {
    ${cfg.Model.prefixName}DataList,${cfg.Model.prefixName}TreeList,${cfg.Model.prefixName}SelectList,
    get${cfg.Model.entity}, add${cfg.Model.entity},save${cfg.Model.entity}, delete${cfg.Model.entity},
    get${cfg.Model.entity}Children, add${cfg.Model.entity}Children,save${cfg.Model.entity}Children, delete${cfg.Model.entity}Children,
};
export default connect((state) => state.${cfg.Model.prefixName}, request)(${cfg.Model.entity});