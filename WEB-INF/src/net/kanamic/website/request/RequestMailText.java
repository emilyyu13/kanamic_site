package net.kanamic.website.request;

import java.util.Map;
import net.kanamic.framework.mail.*;
import net.kanamic.framework.util.DoText;

/**
 * 
 * @author kanamicdev
 *
 */
public class RequestMailText extends AbstractMailText {
	private Map sendData;
	
	/**
	 * コンストラクタ
	 * @param bean
	 */
	public RequestMailText(Map sendData) {
		this.sendData = sendData;
	}
	
	/**
	 * 本文領域をフォーマットする。
	 */
	protected void Format() {
		String[] ham = (String[])this.sendData.get(Params.HAM);
		String[] cic = (String[])this.sendData.get(Params.CIC);
        String[] tritrus = (String[])this.sendData.get(Params.TRITRUS);
		String[] corporatename = (String[])this.sendData.get(Params.CORPORATENAME);
		String[] chargename = (String[])this.sendData.get(Params.CHARGENAME);
		String[] addnum = (String[])this.sendData.get(Params.ADDNUM);
		String[] add1 = (String[])this.sendData.get(Params.ADD1);
		String[] add2 = (String[])this.sendData.get(Params.ADD2);
		String[] tel = (String[])this.sendData.get(Params.TEL);
		String[] fax = (String[])this.sendData.get(Params.FAX);
		String[] mail = (String[])this.sendData.get(Params.MAIL);
		String[] inquiry = (String[])this.sendData.get(Params.INQUIRY);
		
		putEnter();
		putLine("===== 【カタログ請求】 =====");
		// 請求資料
		if (!DoText.purgeNull(ham[0]).equals("")) {
			putLine("HAM資料請求");
		}
		if (!DoText.purgeNull(cic[0]).equals("")) {
			putLine("CIC資料請求");
		}
        if (!DoText.purgeNull(tritrus[0]).equals("")) {
            putLine("TRITRUS資料請求");
        }
		putEnter();
		putLine("=====問い合わせ詳細=====");
		// 事業所名
		putLine(String.format("事業所名（漢字）         ：%1s",
				DoText.purgeNull(corporatename[0])));
		// 担当者名
		putLine(String.format("担当者名（漢字）         ：%1s",
				DoText.purgeNull(chargename[0])));
		// 郵便番号
		putLine(String.format("郵便番号                   ：%1s",
				DoText.purgeNull(addnum[0])));
		// 住所１
		putLine(String.format("住所１                       ：%1s",
				DoText.purgeNull(add1[0])));
		// 住所２
		putLine(String.format("住所２                       ：%1s",
				DoText.purgeNull(add2[0])));
		// 電話番号
		putLine(String.format("電話番号                   ：%1s",
				DoText.purgeNull(tel[0])));
		// ファックス番号
		putLine(String.format("ファックス番号               ：%1s",
				DoText.purgeNull(fax[0])));
		// E-mail
		putLine(String.format("E-mail          ：%1s",
				DoText.purgeNull(mail[0])));
		// 問い合わせ内容
		putLine(String.format("問い合わせ内容          ：%1s",
				DoText.purgeNull(inquiry[0])));
	}
}
