package net.kanamic.website.request;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import net.kanamic.framework.validator.*;
import net.kanamic.framework.validator.impl.*;

public class RequestValidation {

	public static ExeContainerPackageImpl getPackage(HttpServletRequest request)
	{
		//Validatorの初期化
		   ValidateIsSetImpl isSet = new ValidateIsSetImpl();//必須入力
		   ValidateIsEmsizeImpl isEmsize = new ValidateIsEmsizeImpl();//全角
		   ValidateIsMultisetImpl isMultiset = new ValidateIsMultisetImpl();//いずれか選択
		   //ValidateIsNumericImpl isNum = new ValidateIsNumericImpl();//数値
		   ValidateIsZipImpl isZip = new ValidateIsZipImpl();//郵便番号
		   ValidateIsTelImpl isTel = new ValidateIsTelImpl();//電話番号
		   ValidateIsMailImpl isMail = new ValidateIsMailImpl();//メール
		   ValidateStrLengthImpl strLen = new ValidateStrLengthImpl(2000);//文字列長
		   
		   //コンテナのインスタンス化
		      List<ExeValidateContainerImpl> ContList = new LinkedList<ExeValidateContainerImpl>();
		      ExeValidateContainerImpl vCont;
		   
		      //法人名に対するValidate
		      vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameter(Params.CORPORATENAME));
			      vCont.setTargetName(Params.CORPORATENAME);
			      vCont.pushValidator(isSet);
			      vCont.pushValidator(isEmsize);
			      vCont.pushValidator(strLen);
		      ContList.add(vCont);
		      
		      //担当者名に対するValidate
		      vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameter(Params.CHARGENAME));
			      vCont.setTargetName(Params.CHARGENAME);
			      vCont.pushValidator(isSet);
			      vCont.pushValidator(isEmsize);
			      vCont.pushValidator(strLen);
		      ContList.add(vCont);
		      
		      //CIC・HAM（請求資料）に対するValidate
		      vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(new String[] {
					  			request.getParameter(Params.CIC),
					  			request.getParameter(Params.HAM),
                                request.getParameter(Params.TRITRUS)});
			      vCont.setTargetName(Params.HAM);
			      vCont.pushValidator(isMultiset);
		      ContList.add(vCont);
		      
		      //郵便番号に対するValidate
		      vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameter(Params.ADDNUM));
			      vCont.setTargetName(Params.ADDNUM);
			      vCont.pushValidator(isZip);
		      ContList.add(vCont);
		      
		      //住所２に対するValidate
		      vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameter(Params.ADD2));
			      vCont.setTargetName(Params.ADD2);
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

		      //FAX番号に対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.FAX));
		          vCont.setTargetName(Params.FAX);
		          vCont.pushValidator(isTel);
		      ContList.add(vCont);		      
		      
		      //Emailに対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.MAIL));
		          vCont.setTargetName(Params.MAIL);
		          vCont.pushValidator(isSet);
		          vCont.pushValidator(isMail);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);

		      //お問い合わせに対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.INQUIRY));
		          vCont.setTargetName(Params.INQUIRY);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);		
		      
		   //コンテナパッケージのインスタンス化
		   ExeContainerPackageImpl vPkg = new ExeContainerPackageImpl();
		   for(ExeValidateContainerImpl cont : ContList) 
			   vPkg.pushContainers(cont);
		   
		   return vPkg;
	}
}
