package com.example.property;

/**
 * 自定义Freekmaker对象指令
 *
 * @Date 2020/11/17
 */
public class ModuleProperty {

	private String entity;
	private String mapper;
	private String service;
	private String serviceImpl;
	private String controller;
	private String vo;
	private String condition;
	private String modulePackage;
	private String serviceInstance;
	private String conditionInstance;
	private String router;

	public String getEntity() {
		return entity;
	}

	public void setEntity(String entity) {
		this.entity = entity;
	}

	public String getMapper() {
		return mapper;
	}

	public void setMapper(String mapper) {
		this.mapper = mapper;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getServiceImpl() {
		return serviceImpl;
	}

	public void setServiceImpl(String serviceImpl) {
		this.serviceImpl = serviceImpl;
	}

	public String getVo() {
		return vo;
	}

	public void setVo(String vo) {
		this.vo = vo;
	}

	public String getController() {
		return controller;
	}

	public void setController(String controller) {
		this.controller = controller;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public String getModulePackage() {
		return modulePackage;
	}

	public void setModulePackage(String modulePackage) {
		this.modulePackage = modulePackage;
	}

	public String getConditionInstance() {
		return conditionInstance;
	}

	public void setConditionInstance(String conditionInstance) {
		this.conditionInstance = conditionInstance;
	}

	public String getServiceInstance() {
		return serviceInstance;
	}

	public void setServiceInstance(String serviceInstance) {
		this.serviceInstance = serviceInstance;
	}

	public String getRouter() {
		return router;
	}

	public void setRouter(String router) {
		this.router = router;
	}
}
