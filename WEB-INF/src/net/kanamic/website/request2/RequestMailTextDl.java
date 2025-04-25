package net.kanamic.website.request2;

import java.util.Map;
import net.kanamic.framework.mail.*;
import net.kanamic.framework.util.DoText;

/**
 *
 * @author kanamicdev
 *
 */
public class RequestMailTextDl extends AbstractMailText {
	private Map sendData;

	/**
	 * コンストラクタ
	 * @param bean
	 */
	public RequestMailTextDl(Map sendData) {
		this.sendData = sendData;
	}

	/**
	 * 本文領域をフォーマットする。
	 */
	protected void Format() {
		String[] corporatename = (String[])this.sendData.get(Params.DL.CORPORATENAME);
		String[] chargename = (String[])this.sendData.get(Params.DL.CHARGENAME);
		String[] mail = (String[])this.sendData.get(Params.DL.MAIL);
		String[] tel = (String[])this.sendData.get(Params.DL.TEL);
		String[] inquiry = (String[])this.sendData.get(Params.DL.INQUIRY);

		putEnter();
		putLine("=====資料請求（ダウンロード）=====");
		// 事業所名
		putLine(String.format("事業所名         ：%1s",
				DoText.purgeNull(corporatename[0])));
		// 担当者名
		putLine(String.format("担当者名         ：%1s",
				DoText.purgeNull(chargename[0])));
		// E-mail
		putLine(String.format("E-mail          ：%1s",
				DoText.purgeNull(mail[0])));
		// 電話番号
		putLine(String.format("電話番号                   ：%1s",
				DoText.purgeNull(tel[0])));
		// 問い合わせ内容
		putLine(String.format("問い合わせ内容          ：%1s",
				DoText.purgeNull(inquiry[0])));
	}
}
