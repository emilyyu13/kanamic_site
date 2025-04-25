package net.kanamic.website.recruit;

import java.util.Map;

import net.kanamic.framework.mail.AbstractMailText;
import net.kanamic.website.recruit.Params;

public class RecruitMailText extends AbstractMailText {
	private Map sendData;
	
	/**
	 * コンストラクタ
	 * @param bean
	 */
	public RecruitMailText(Map sendData) {
		this.sendData = sendData;
	}
	
	/**
	 * 本文領域をフォーマットする。
	 */
	protected void Format() {
		
		String[] name = (String[])this.sendData.get(Params.NAME);
		String[] kana = (String[])this.sendData.get(Params.KANA);
		String[] sex = (String[])this.sendData.get(Params.SEX);
		String[] b_year = (String[])this.sendData.get(Params.B_YEAR);
		String[] b_month = (String[])this.sendData.get(Params.B_MONTH);
		String[] b_day = (String[])this.sendData.get(Params.B_DAY);
		String[] age = (String[])this.sendData.get(Params.AGE);
		String[] zip = (String[])this.sendData.get(Params.ZIP);
		String[] tdfk = (String[])this.sendData.get(Params.TDFK);
		String[] address = (String[])this.sendData.get(Params.ADDRESS);
		String[] tel = (String[])this.sendData.get(Params.TEL);
		String[] mobile = (String[])this.sendData.get(Params.MOBILE);
		String[] email = (String[])this.sendData.get(Params.EMAIL);
		String[] school = (String[])this.sendData.get(Params.SCHOOL);
		String[] school_name = (String[])this.sendData.get(Params.SCHOOL_NAME);
		String[] department = (String[])this.sendData.get(Params.DEPARTMENT);
		String[] cource = (String[])this.sendData.get(Params.COURSE);
		String[] entrance = (String[])this.sendData.get(Params.ENTRANCE);
		String[] graduate = (String[])this.sendData.get(Params.GRADUATE);
		String[] jobtype = (String[])this.sendData.get(Params.JOB_TYPE);
		String[] seminar = (String[])this.sendData.get(Params.SEMINAR);
		String[] license = (String[])this.sendData.get(Params.LICENSE);
		String[] reason = (String[])this.sendData.get(Params.REASON);
		
		//本文作成
		this.putEnter();
		this.putLine("エントリーフォームに投稿がありました。");
		this.putLine("==========エントリー内容===========");
		
		this.putLine(String.format("名前（漢字）　　　　：%1s",this.getValue(name)));
		this.putLine(String.format("名前（カナ）　　　　 ：%1s",this.getValue(kana)));
		this.putLine(String.format("性別         　　　　 ：%1s",this.getValue(sex)));
		this.putLine(String.format("生年月日             ：%1s年%2s月%3s日"
				,this.getValue(b_year),this.getValue(b_month),this.getValue(b_day)));
		this.putLine(String.format("年齢         　　　　 ：%1s歳",this.getValue(age)));
		this.putLine(String.format("郵便番号   　　　　 ：%1s",this.getValue(zip)));
		this.putLine(String.format("住所         　　　　 ：%1s%2s"
				,this.getValue(tdfk),this.getValue(address)));
		this.putLine(String.format("電話番号              ：%1s",this.getValue(tel)));
		this.putLine(String.format("携帯電話番号       ：%1s",this.getValue(mobile)));
		this.putLine(String.format("E-mail      　         ：%1s",this.getValue(email)));
		this.putLine(String.format("学校         　         ：%1s",this.getValue(school)));
		this.putLine(String.format("学校名      　         ：%1s",this.getValue(school_name)));
		this.putLine(String.format("学部名      　         ：%1s",this.getValue(department)));
		this.putLine(String.format("学科名および専攻  ：%1s",this.getValue(cource)));
		this.putLine(String.format("入学年月日           ：%1s",this.getValue(entrance)));
		this.putLine(String.format("卒業（見込）年月日 ：%1s",this.getValue(graduate)));
		this.putLine(String.format("希望する職種        ：%1s",this.getValue(jobtype)));
		this.putLine(String.format("会社説明会           ：%1s",this.getValue(seminar)));
		this.putLine(String.format("--保有する資格--\n%1s",this.getValue(license)));
		this.putEnter();
		this.putLine(String.format("--志望理由--\n%1s",this.getValue(reason)));
		this.putEnter();
		
		
	}
	
	private String getValue(String[] param)
	{
		if(param == null)
		{
			return "";
		}
		
		StringBuffer sb = new StringBuffer();
		for(String val : param)
		{
			sb.append(val);
			sb.append(",");
		}
		
		sb.deleteCharAt(sb.length()-1);
		
		return sb.toString();
	}
}
