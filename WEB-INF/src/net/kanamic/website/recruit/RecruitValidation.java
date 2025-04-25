package net.kanamic.website.recruit;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import net.kanamic.framework.validator.*;
import net.kanamic.framework.validator.impl.*;

public class RecruitValidation {

	public static ExeContainerPackageImpl getPackage(HttpServletRequest request)
	{
		//Validatorの初期化
		   ValidateIsSetImpl isSet = new ValidateIsSetImpl();//必須入力
		   ValidateIsEmsizeImpl isEmsize = new ValidateIsEmsizeImpl();//全角
		   ValidateIsMultisetImpl isMultiset = new ValidateIsMultisetImpl();//いずれか選択
		   ValidateIsNumericImpl isNum = new ValidateIsNumericImpl();//数値
		   ValidateIsZipImpl isZip = new ValidateIsZipImpl();//郵便番号
		   ValidateIsTelImpl isTel = new ValidateIsTelImpl();//電話番号
		   ValidateIsMailImpl isMail = new ValidateIsMailImpl();//メール
		   ValidateStrLengthImpl strLen = new ValidateStrLengthImpl(2000);//文字列長
		   
		   //コンテナのインスタンス化
		      List<ExeValidateContainerImpl> ContList = new LinkedList<ExeValidateContainerImpl>();
		   
		      //名前に対するValidate
		      ExeValidateContainerImpl vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameter(Params.NAME));
			      vCont.setTargetName(Params.NAME);
			      vCont.pushValidator(isSet);
			      vCont.pushValidator(isEmsize);
			      vCont.pushValidator(strLen);
		      ContList.add(vCont);
		      
		      //名前カナに対するValidate
		      vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameter(Params.KANA));
			      vCont.setTargetName(Params.KANA);
			      vCont.pushValidator(isSet);
			      vCont.pushValidator(isEmsize);
			      vCont.pushValidator(strLen);
		      ContList.add(vCont);
		      
		      //生年月日　年に対するValidate
		      vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameter(Params.B_YEAR));
			      vCont.setTargetName(Params.B_YEAR);
			      vCont.pushValidator(isSet);
			      vCont.pushValidator(isNum);
			      vCont.pushValidator(strLen);
			  ContList.add(vCont);
		      
			  //生年月日　月に対するValidate
			  vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameter(Params.B_MONTH));
			      vCont.setTargetName(Params.B_MONTH);
			      vCont.pushValidator(isSet);
			      vCont.pushValidator(isNum);
			      vCont.pushValidator(strLen);
		      ContList.add(vCont);
		      
		      //生年月日　日に対するValidate
		      vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameter(Params.B_DAY));
			      vCont.setTargetName(Params.B_DAY);
			      vCont.pushValidator(isSet);
			      vCont.pushValidator(isNum);
			      vCont.pushValidator(strLen);
		      ContList.add(vCont);
		      
		      //年齢に対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.AGE));
		          vCont.setTargetName(Params.AGE);
		          vCont.pushValidator(isSet);
		          vCont.pushValidator(isNum);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);
		      
		      //郵便番号に対するValidate
		      vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameter(Params.ZIP));
			      vCont.setTargetName(Params.ZIP);
			      vCont.pushValidator(isZip);
		      ContList.add(vCont);
		      
		      //住所に対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.ADDRESS));
		          vCont.setTargetName(Params.ADDRESS);
		          vCont.pushValidator(isSet);
		          //vCont.pushValidator(isEmsize);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);
		      
		      //電話番号に対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.TEL));
		          vCont.setTargetName(Params.TEL);
		          vCont.pushValidator(isSet);
		          vCont.pushValidator(isTel);
		      ContList.add(vCont);
		      
		      //携帯電話番号に対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.MOBILE));
		          vCont.setTargetName(Params.MOBILE);
		          vCont.pushValidator(isTel);
		      ContList.add(vCont);
		      
		      //Emailに対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.EMAIL));
		          vCont.setTargetName(Params.EMAIL);
		          vCont.pushValidator(isSet);
		          vCont.pushValidator(isMail);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);
		      
		      //学校名に対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.SCHOOL_NAME));
		          vCont.setTargetName(Params.SCHOOL_NAME);
		          vCont.pushValidator(isSet);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);
		  
		      
		      //学部名に対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.DEPARTMENT));
		          vCont.setTargetName(Params.DEPARTMENT);
		          //vCont.pushValidator(isSet);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);
		      
		      //学科名に対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.COURSE));
		          vCont.setTargetName(Params.COURSE);
		          vCont.pushValidator(isSet);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);
		      
		      //入学年月日に対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.ENTRANCE));
		          vCont.setTargetName(Params.ENTRANCE);
		          vCont.pushValidator(isSet);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);
		      
		      //卒業年月日に対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.GRADUATE));
		          vCont.setTargetName(Params.GRADUATE);
		          vCont.pushValidator(isSet);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);
		      
		      //希望する職種に対するValidate
		      vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameterValues(Params.JOB_TYPE));
			      vCont.setTargetName(Params.JOB_TYPE);
			      vCont.pushValidator(isMultiset);
		      ContList.add(vCont);
		      
		      //資格に対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.LICENSE));
		          vCont.setTargetName(Params.LICENSE);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);
		      
		      //理由に対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.REASON));
		          vCont.setTargetName(Params.REASON);
		          vCont.pushValidator(isSet);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);
		   
		   //コンテナパッケージのインスタンス化
		   ExeContainerPackageImpl vPkg = new ExeContainerPackageImpl();
		   for(ExeValidateContainerImpl cont : ContList)
		   {
		    vPkg.pushContainers(cont);
		   }
		   
		   return vPkg;
	}
}
