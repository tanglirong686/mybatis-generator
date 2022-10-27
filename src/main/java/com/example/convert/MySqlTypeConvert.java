package com.example.convert;

import static com.baomidou.mybatisplus.generator.config.rules.DbColumnType.BIG_DECIMAL;
import static com.baomidou.mybatisplus.generator.config.rules.DbColumnType.BLOB;
import static com.baomidou.mybatisplus.generator.config.rules.DbColumnType.BOOLEAN;
import static com.baomidou.mybatisplus.generator.config.rules.DbColumnType.BYTE;
import static com.baomidou.mybatisplus.generator.config.rules.DbColumnType.BYTE_ARRAY;
import static com.baomidou.mybatisplus.generator.config.rules.DbColumnType.CLOB;
import static com.baomidou.mybatisplus.generator.config.rules.DbColumnType.DOUBLE;
import static com.baomidou.mybatisplus.generator.config.rules.DbColumnType.FLOAT;
import static com.baomidou.mybatisplus.generator.config.rules.DbColumnType.INTEGER;
import static com.baomidou.mybatisplus.generator.config.rules.DbColumnType.LONG;
import static com.baomidou.mybatisplus.generator.config.rules.DbColumnType.STRING;

import com.baomidou.mybatisplus.generator.config.GlobalConfig;
import com.baomidou.mybatisplus.generator.config.ITypeConvert;
import com.baomidou.mybatisplus.generator.config.converts.select.BranchBuilder;
import com.baomidou.mybatisplus.generator.config.converts.select.Selector;
import com.baomidou.mybatisplus.generator.config.rules.DbColumnType;
import com.baomidou.mybatisplus.generator.config.rules.IColumnType;

/**
 * MYSQL 数据库字段类型转换 bit类型数据转换 bit(1) -> Boolean类型 bit(2->64) -> Byte类型
 *
 * @author
 * @since 2017-01-20
 */
public class MySqlTypeConvert implements ITypeConvert {

	/**
	 * @inheritDoc
	 */
	@Override
	public IColumnType processTypeConvert(GlobalConfig config, String fieldType) {
		return use(fieldType).test(containsAny("char", "text", "json", "enum").then(STRING))
			.test(contains("bigint").then(LONG)).test(containsAny("tinyint(1)", "bit(1)").then(BOOLEAN))
			.test(contains("bit").then(BYTE)).test(contains("int").then(INTEGER))
			.test(contains("decimal").then(BIG_DECIMAL)).test(contains("clob").then(CLOB))
			.test(contains("blob").then(BLOB)).test(contains("binary").then(BYTE_ARRAY))
			.test(contains("float").then(FLOAT)).test(contains("double").then(DOUBLE))
			.test(containsAny("date", "time", "year").then(t -> toDateType(config, t))).or(STRING);
	}

	/**
	 * 转换为日期类型
	 *
	 * @param config 配置信息
	 * @param type   类型
	 * @return 返回对应的列类型
	 */
	public static IColumnType toDateType(GlobalConfig config, String type) {
		String dateType = type.replaceAll("\\(\\d+\\)", "");
		switch (config.getDateType()) {
		case ONLY_DATE:
			return DbColumnType.DATE;
		case SQL_PACK:
			switch (dateType) {
			case "date":
			case "year":
				return DbColumnType.DATE_SQL;
			case "time":
				return DbColumnType.TIME;
			default:
				return DbColumnType.TIMESTAMP;
			}
		case TIME_PACK:
			switch (dateType) {
			case "date":
				return DbColumnType.LOCAL_DATE;
			case "time":
				return DbColumnType.LOCAL_TIME;
			case "year":
				return DbColumnType.YEAR;
			default:
				return DbColumnType.LOCAL_DATE_TIME;
			}
		}
		return STRING;
	}

	/**
	 * 使用指定参数构建一个选择器
	 *
	 * @param param 参数
	 * @return 返回选择器
	 */
	static Selector<String, IColumnType> use(String param) {
		return new Selector<>(param.toLowerCase());
	}

	/**
	 * 这个分支构建器用于构建用于支持 {@link String#contains(CharSequence)} 的分支
	 *
	 * @param value 分支的值
	 * @return 返回分支构建器
	 * @see #containsAny(CharSequence...)
	 */
	static BranchBuilder<String, IColumnType> contains(CharSequence value) {
		return BranchBuilder.of(s -> s.contains(value));
	}

	/**
	 * @see #contains(CharSequence)
	 */
	static BranchBuilder<String, IColumnType> containsAny(CharSequence... values) {
		return BranchBuilder.of(s -> {
			for (CharSequence value : values) {
				if (s.contains(value))
					return true;
			}
			return false;
		});
	}
}