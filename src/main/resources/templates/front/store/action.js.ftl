import * as types from "../action-types";
import {
    get${cfg.Model.entity}List ,get${cfg.Model.entity}TreeList,
    get${cfg.Model.entity}Info ,save${cfg.Model.entity}Info ,delete${cfg.Model.entity}Info
} from "@/api/${cfg.Model.prefixName}";

const exportFunc = {
    ${cfg.Model.prefixName}DataList ,${cfg.Model.prefixName}TreeList ,
    get${cfg.Model.entity} ,add${cfg.Model.entity} ,save${cfg.Model.entity} ,delete${cfg.Model.entity}
};

export const ${cfg.Model.prefixName}DataList = (param) => (dispatch) => {
  return new Promise((resolve, reject) => {
    get${cfg.Model.entity}List(param)
      .then((response) => {
        const { data } = response;
        if (data.code === 1) {
          const list = {
            dataList: data.data.records,
            total: data.data.total,
            pagination: param
          }
          dispatch(set${cfg.Model.entity}List(list));
          resolve(data);
        } else {
          reject(data);
        }
      })
      .catch((error) => {
        reject(error);
      });
  });
};

export const ${cfg.Model.prefixName}TreeList = (param) => (dispatch) => {
  return new Promise((resolve, reject) => {
    get${cfg.Model.entity}TreeList(param)
      .then((response) => {
        const { data } = response;
        if (data.code === 1) {
          const list = {
            treeList: data.data
          }
          dispatch(set${cfg.Model.entity}TreeList(list));
          resolve(data);
        } else {
          reject(data);
        }
      })
      .catch((error) => {
        reject(error);
      });
  });
};

export const get${cfg.Model.entity} = (param) => (dispatch) => {
  return new Promise((resolve, reject) => {
    get${cfg.Model.entity}Info(param)
      .then((response) => {
        const { data } = response;
        if (data.code === 1) {
          const ${cfg.Model.prefixName}Info = data.data;
          dispatch(set${cfg.Model.entity}Info(${cfg.Model.prefixName}Info));
          resolve(data);
        } else {
          reject(data);
        }
      })
      .catch((error) => {
        reject(error);
      });
  });
};
export const add${cfg.Model.entity} = () => (dispatch) => {
  return new Promise((resolve) => {
    dispatch(resetInfo());
    resolve();
  });
};
export const save${cfg.Model.entity} = (param) => (dispatch) => {
  return new Promise((resolve, reject) => {
    save${cfg.Model.entity}Info(param)
      .then((response) => {
        const { data } = response;
        if (data.code === 1) {
          dispatch(resetInfo());
          resolve(data);
        } else {
          reject(data);
        }
      })
      .catch((error) => {
        reject(error);
      });
  });
};
export const delete${cfg.Model.entity} = (param) => (dispatch) => {
  return new Promise((resolve, reject) => {
    delete${cfg.Model.entity}Info(param)
      .then((response) => {
        const { data } = response;
        if (data.code === 1) {
          dispatch(resetInfo());
          resolve(data);
        } else {
          const msg = data.message;
          reject(msg);
        }
      })
      .catch((error) => {
        reject(error);
      });
  });
};

export const set${cfg.Model.entity}List = (data) => {
  return {
    type: types.${cfg.Model.entity?upper_case}_SET_LIST,
    data
  };
};
export const set${cfg.Model.entity}TreeList = (data) => {
  return {
    type: types.${cfg.Model.entity?upper_case}_SET_TREE_LIST,
    data
  };
};
export const set${cfg.Model.entity}Info = (data) => {
  return {
    type: types.${cfg.Model.entity?upper_case}_SET_INFO,
    data,
  };
};
export const resetInfo = () => {
  return {
    type: types.${cfg.Model.entity?upper_case}_RESET_INFO,
  };
};