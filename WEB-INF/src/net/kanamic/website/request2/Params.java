package net.kanamic.website.request2;

/**
 *
 * @author kanamicdev
 *
 */
/**
 * 定数ユーティリティクラス
 */
public class Params {
    private Params() {}  // インスタンス化させない

//TODO 入力項目の名前を列挙
    public static class DL {
		public static String CORPORATENAME = "corporateNameReqDL";
		public static String CHARGENAME = "yourNameReqDL";
		public static String TEL = "phoneNumberReqDL";
		public static String MAIL = "emailReqDL";
		public static String INQUIRY = "contentReqDL";
    }
    public static class POST {
		public static String CORPORATENAME = "corporateNameReqPost";
		public static String CHARGENAME = "yourNameReqPost";
		public static String MAIL = "emailReqPost";
		public static String ADDNUM = "postalCodeReqPost";
		public static String ADD1 = "addr11ReqPost";
		public static String TEL = "phoneNumberReqPost";
		public static String INQUIRY = "contentReqPost";
    }
    public static class OTHER {
		public static String CORPORATENAME = "corporateNameReqOther";
		public static String CHARGENAME = "yourNameReqOther";
		public static String MAIL = "emailReqOther";
		public static String TEL = "phoneNumberReqOther";
		public static String INQUIRY = "contentReqOther";
    }

	public static String MAIL_REC_KBN = "MAIL_REC";
    public static class MAIL_REC {
		public static String DL = "DL";
		public static String POST = "POST";
		public static String OTHER = "OTHER";
    }


	public static String CORPORATENAME = "CORPORATENAME";
	public static String CHARGENAME = "CHARGENAME";
	public static String HAM = "HAM";
	public static String CIC = "CIC";
    //2009/10/15 narita 追加
    public static String TRITRUS = "TRITRUS";
	public static String ADDNUM = "ADDNUM";
	public static String ADD1 = "ADD1";
	public static String ADD2 = "ADD2";
	public static String TEL = "TEL";
	public static String FAX = "FAX";
	public static String MAIL = "MAIL";
	public static String INQUIRY = "INQUIRY";
	public static String NEXT = "NEXT";
	public static String BACK = "BACK";
	public static String SEND = "SEND";
}

/*
public interface Params {
	public static String NEXT = "NEXT";
	public static String BACK = "BACK";
	public static String SEND = "SEND";
}
*/