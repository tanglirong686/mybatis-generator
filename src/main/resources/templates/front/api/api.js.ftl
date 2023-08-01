import request from '@/utils/request';

export const get${cfg.Model.entity}List = (data) => request.post('/api/business/${cfg.Model.prefixName}/queryList', data);
export const get${cfg.Model.entity}TreeList = (data) => request.post('/api/business/${cfg.Model.prefixName}/queryTreeList', data);
export const get${cfg.Model.entity}Info = (params) => request.get('/api/business/${cfg.Model.prefixName}/queryById', { params });
export const save${cfg.Model.entity}Info = (data) => request.post('/api/business/${cfg.Model.prefixName}/saveOrUpdate', data);
export const delete${cfg.Model.entity}Info = (data) => request.post('/api/business/${cfg.Model.prefixName}/deleteById', data);