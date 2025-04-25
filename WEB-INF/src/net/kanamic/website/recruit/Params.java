package net.kanamic.website.recruit;

/**
 * パラメータ名を定義したinterface
 * @author narita
 *
 */
public interface Params {
	/**
	 * 名前（漢字）
	 */
	String NAME = "kanji";
	/**
	 * 名前（カナ）
	 */
	String KANA = "furigana";
	/**
	 * 性別
	 */
	String SEX = "sex";
	/**
	 * 生年月日　年
	 */
	String B_YEAR = "year";
	/**
	 * 生年月日　月
	 */
	String B_MONTH = "month";
	/**
	 * 生年月日　日
	 */
	String B_DAY = "day";
	/**
	 * 年齢
	 */
	String AGE = "age";
	/**
	 * 郵便番号
	 */
	String ZIP = "addNum";
	/**
	 * 住所　都道府県
	 */
	String TDFK = "add1";
	/**
	 * 住所
	 */
	String ADDRESS = "add2";
	/**
	 * 電話番号
	 */
	String TEL = "tel";
	/**
	 * 携帯電話番号
	 */
	String MOBILE = "mobile";
	/**
	 * E-mail
	 */
	String EMAIL = "mail";
	/**
	 * 学校
	 */
	String SCHOOL = "school";
	/**
	 * 学校名
	 */
	String SCHOOL_NAME = "schoolName";
	/**
	 * 学部
	 */
	String DEPARTMENT = "department";
	/**
	 * 学科名および専攻
	 */
	String COURSE = "course";
	/**
	 * 入学年月日
	 */
	String ENTRANCE = "enterSchoolDate";
	/**
	 * 卒業年月日（卒業見込み年月日）
	 */
	String GRADUATE = "graduateDate";
	/**
	 * 希望する職種
	 */
	String JOB_TYPE = "jobtype";
	/**
	 * 会社説明会
	 */
	String SEMINAR = "seminar";
	/**
	 * 保有する資格
	 */
	String LICENSE = "item";
	/**
	 * 当社を志望される理由
	 */
	String REASON = "reason";
}
