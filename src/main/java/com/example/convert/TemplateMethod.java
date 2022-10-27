package com.example.convert;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.generator.config.po.TableField;

/**
 * 模板内使用的方法
 *
 * @Author
 * @Date 2020/11/17
 */
public class TemplateMethod {

	// 下划线的匹配规则定义
	private static Pattern UNDER_LINE_PATTERN = Pattern.compile("_(\\w)");

	// 驼峰字母的匹配规则定义
	private static Pattern HUMP_PATTERN = Pattern.compile("[A-Z]");

	// 下划线标识定义
	private static final String UNDER_LINE = "_";

	/**
	 * 下划线转驼峰
	 *
	 * @param str 待转换的字符串
	 * @return 转换后的字符串
	 */
	public static String underlineToHump(String str) {
		// 判断字符串是否包含下划线，如果不包含下划线，不处理直接返回
		if (!str.contains(UNDER_LINE)) {
			return str;
		}
		str = str.toLowerCase();
		Matcher matcher = UNDER_LINE_PATTERN.matcher(str);
		StringBuffer sb = new StringBuffer();
		// 判断如果正则查找匹配到了下划线，则进行替换操作
		while (matcher.find()) {
			matcher.appendReplacement(sb, matcher.group(1).toUpperCase());
		}
		matcher.appendTail(sb);
		return sb.toString();
	}

	/**
	 * 驼峰转下划线
	 *
	 * @param str 待转换的字符串
	 * @return 转换后的字符串
	 */
	public static String humpToUnderline(String str) {
		Matcher matcher = HUMP_PATTERN.matcher(str);
		StringBuffer sb = new StringBuffer();
		// 判断正则如果匹配查找到了大写的字母，则进行下划线的替换拼接
		while (matcher.find()) {
			matcher.appendReplacement(sb, UNDER_LINE + matcher.group(0).toLowerCase());
		}
		matcher.appendTail(sb);
		return sb.toString();
	}

	/**
	 * 类名
	 *
	 * @param tableName
	 * @return
	 */
	public String className(String tableName) {
		if (StringUtils.isBlank(tableName)) {
			return "";
		}
		String str = tableName.toLowerCase();
		String[] strs = str.split("_");
		String result = "";
		if (strs.length > 1) {
			for (int i = 1; i < strs.length; i++) {
				result += firstUpper(strs[i]);
			}
		} else {
			result = "表命名不规范";
		}

		return result;
	}

	/**
	 * 获取属性名称
	 *
	 * @param columnName
	 * @return
	 */
	public String propertyName(String columnName) {
		if (StringUtils.isBlank(columnName)) {
			return "";
		}
		return firstLower(columnName);
	}

	public String propertyValidAnnotation(TableField field) {
		if (field.getType().startsWith("varchar")) {
			String len = field.getType().replace("varchar(", "").replace(")", "").trim();
			return "@Size(max = " + len + ")";
		}
		return " ";
	}

	/**
	 * 输入字符串首字母大写
	 *
	 * @param str 输入字符
	 * @return
	 */
	public String firstUpper(String str) {
		String result = "";
		if (StringUtils.isNotBlank(str)) {
			result += str.substring(0, 1).toUpperCase();
		}
		if (str.length() > 1) {
			result += str.substring(1);
		}
		return result;
	}

	/**
	 * 输入字符串首字母小写
	 *
	 * @param str 输入字符
	 * @return
	 */
	public String firstLower(String str) {
		String result = "";
		if (StringUtils.isNotBlank(str)) {
			result += str.substring(0, 1).toLowerCase();
		}
		if (str.length() > 1) {
			result += str.substring(1);
		}
		return result;
	}
}
