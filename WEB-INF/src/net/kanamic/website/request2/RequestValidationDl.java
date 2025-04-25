package net.kanamic.website.request2;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import net.kanamic.framework.validator.*;
import net.kanamic.framework.validator.impl.*;

public class RequestValidationDl {

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
			      vCont.setTargetValue(request.getParameter(Params.DL.CORPORATENAME));
			      vCont.setTargetName(Params.DL.CORPORATENAME);
			      vCont.pushValidator(isSet);
			      vCont.pushValidator(strLen);
		      ContList.add(vCont);

		      //担当者名に対するValidate
		      vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameter(Params.DL.CHARGENAME));
			      vCont.setTargetName(Params.DL.CHARGENAME);
			      vCont.pushValidator(isSet);
			      vCont.pushValidator(strLen);
		      ContList.add(vCont);

		      //Emailに対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.DL.MAIL));
		          vCont.setTargetName(Params.DL.MAIL);
		          vCont.pushValidator(isSet);
//		          vCont.pushValidator(isMail);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);

		      //電話番号に対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.DL.TEL));
		          vCont.setTargetName(Params.DL.TEL);
		          vCont.pushValidator(isSet);
//		          vCont.pushValidator(isTel);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);

		      //お問い合わせに対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.DL.INQUIRY));
		          vCont.setTargetName(Params.DL.INQUIRY);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);

		   //コンテナパッケージのインスタンス化
		   ExeContainerPackageImpl vPkg = new ExeContainerPackageImpl();
		   for(ExeValidateContainerImpl cont : ContList)
			   vPkg.pushContainers(cont);

		   return vPkg;
	}
}
