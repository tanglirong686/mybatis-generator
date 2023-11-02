package com.example.config;

import com.zaxxer.hikari.HikariConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class HikariConfiguration {

    // 自动装配数据源
    @Autowired
    private DataSourceProperties dataSource;

    @Bean
    public HikariConfig hikariConfig() {
        try {
            HikariConfig dsc = new HikariConfig();
            dsc.setJdbcUrl(dataSource.getUrl());
            dsc.setDriverClassName(dataSource.getDriverClassName());
            dsc.setUsername(dataSource.getUsername());
            dsc.setPassword(dataSource.getPassword());
            dsc.setMinimumIdle(2);
            dsc.setMaximumPoolSize(5);
            //设置可以获取tables的描述备注信息
            dsc.addDataSourceProperty("useInformationSchema", "true");
            return dsc;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}