import * as types from "../action-types";

const initData = {
    ${cfg.Model.prefixName}Info: {
        dataList: [],
        total: 0,
        pagination: {
          current: 1,
          pageSize: 10,
        },
        activeIndex: "",
        treeList: [],
        selectList: [],
        info: {
            <#list table.fields as field>
            ${field.propertyName}: ""<#if field_has_next>,</#if>
            </#list>
        }
    }
};
export default function ${cfg.Model.prefixName}(state = initData, action) {
  switch (action.type) {
    case types.${cfg.Model.entity?upper_case}_SET_LIST:
      return {
        ...state,
        ${cfg.Model.prefixName}Info: {
          ...state.${cfg.Model.prefixName}Info,
          dataList: action.data.dataList,
          total: action.data.total,
          pagination: action.data.pagination
        }
      };
    case types.${cfg.Model.entity?upper_case}_SET_TREE_LIST:
      return {
        ...state,
        ${cfg.Model.prefixName}Info: {
          ...state.${cfg.Model.prefixName}Info,
          treeList: action.data.treeList
        }
      };
    case types.${cfg.Model.entity?upper_case}_SET_INFO:
      return {
        ...state,
        ${cfg.Model.prefixName}Info: {
          ...state.${cfg.Model.prefixName}Info,
          info: action.data
        }
      };
    case types.${cfg.Model.entity?upper_case}_RESET_INFO:
      return {
        ...state,
        ${cfg.Model.prefixName}Info: {
          ...state.${cfg.Model.prefixName}Info,
          info: initData.${cfg.Model.prefixName}Info.info
        }
      };
    default:
      return state;
  }
}

export const ${cfg.Model.entity?upper_case}_SET_LIST = "${cfg.Model.entity?upper_case}_SET_LIST";
export const ${cfg.Model.entity?upper_case}_SET_TREE_LIST = "${cfg.Model.entity?upper_case}_SET_TREE_LIST";
export const ${cfg.Model.entity?upper_case}_SET_INFO = "${cfg.Model.entity?upper_case}_SET_INFO";
export const ${cfg.Model.entity?upper_case}_RESET_INFO = "${cfg.Model.entity?upper_case}_RESET_INFO";