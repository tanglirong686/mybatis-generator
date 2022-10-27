package com.example.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.baomidou.mybatisplus.generator.config.DataSourceConfig;

@Configuration
public class DatabaseConfiguration {

	// 自动装配数据源
	@Autowired
	private DataSourceProperties dataSource;

	@Bean
	public DataSourceConfig dataSourceConfig() {
		try {
			DataSourceConfig dsc = new DataSourceConfig();
			dsc.setUrl(dataSource.getUrl());
			dsc.setDriverName(dataSource.getDriverClassName());
			dsc.setUsername(dataSource.getUsername());
			dsc.setPassword(dataSource.getPassword());
			return dsc;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}