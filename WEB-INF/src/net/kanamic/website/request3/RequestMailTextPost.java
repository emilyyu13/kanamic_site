package net.kanamic.website.request3;

import java.util.Map;
import net.kanamic.framework.mail.*;
import net.kanamic.framework.util.DoText;

/**
 *
 * @author kanamicdev
 *
 */
public class RequestMailTextPost extends AbstractMailText {
	private Map sendData;

	/**
	 * コンストラクタ
	 * @param bean
	 */
	public RequestMailTextPost(Map sendData) {
		this.sendData = sendData;
	}

	/**
	 * 本文領域をフォーマットする。
	 */
	protected void Format() {
		String[] corporatename = (String[])this.sendData.get(Params.POST.CORPORATENAME);
		String[] chargename = (String[])this.sendData.get(Params.POST.CHARGENAME);
		String[] mail = (String[])this.sendData.get(Params.POST.MAIL);
		String[] tel = (String[])this.sendData.get(Params.POST.TEL);
		String[] addnum = (String[])this.sendData.get(Params.POST.ADDNUM);
		String[] add1 = (String[])this.sendData.get(Params.POST.ADD1);
		String[] inquiry = (String[])this.sendData.get(Params.POST.INQUIRY);

		putLine("=====資料請求（郵送）=====");
		// 事業所名
		putLine(String.format("事業所名（漢字）         ：%1s",
				DoText.purgeNull(corporatename[0])));
		// 担当者名
		putLine(String.format("担当者名（漢字）         ：%1s",
				DoText.purgeNull(chargename[0])));
		// E-mail
		putLine(String.format("E-mail          ：%1s",
				DoText.purgeNull(mail[0])));
		// 郵便番号
		putLine(String.format("郵便番号                   ：%1s",
				DoText.purgeNull(addnum[0])));
		// 住所１
		putLine(String.format("住所１                       ：%1s",
				DoText.purgeNull(add1[0])));
		// 電話番号
		putLine(String.format("電話番号                   ：%1s",
				DoText.purgeNull(tel[0])));
		// 問い合わせ内容
		putLine(String.format("問い合わせ内容          ：%1s",
				DoText.purgeNull(inquiry[0])));
	}
}
