package com.example.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.github.xiaoymin.knife4j.spring.annotations.EnableKnife4j;

import io.swagger.annotations.ApiOperation;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * swagger配置
 */
@Configuration
@EnableSwagger2
@EnableKnife4j
public class SwaggerConfiguration {

	/**
	 * @desc: swagger配置注入
	 * @return
	 */
	@Bean
	public Docket createApi() {
		return new Docket(DocumentationType.SWAGGER_2).apiInfo(apiInfo()).select()
			.apis(RequestHandlerSelectors.withMethodAnnotation(ApiOperation.class)).paths(PathSelectors.any()).build();
	}

	/**
	 * @desc: 创建api配置
	 * @return
	 */
	private ApiInfo apiInfo() {
		return new ApiInfoBuilder().title("代码生成").description("相关接口文档").version("0.0.1").build();
	}
}