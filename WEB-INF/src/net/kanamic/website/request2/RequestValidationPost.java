package net.kanamic.website.request2;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import net.kanamic.framework.validator.*;
import net.kanamic.framework.validator.impl.*;

public class RequestValidationPost {

	public static ExeContainerPackageImpl getPackage(HttpServletRequest request)
	{
		//Validatorの初期化
		   ValidateIsSetImpl isSet = new ValidateIsSetImpl();//必須入力
//		   ValidateIsEmsizeImpl isEmsize = new ValidateIsEmsizeImpl();//全角
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
			      vCont.setTargetValue(request.getParameter(Params.POST.CORPORATENAME));
			      vCont.setTargetName(Params.POST.CORPORATENAME);
			      vCont.pushValidator(isSet);
			      vCont.pushValidator(strLen);
		      ContList.add(vCont);

		      //担当者名に対するValidate
		      vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameter(Params.POST.CHARGENAME));
			      vCont.setTargetName(Params.POST.CHARGENAME);
			      vCont.pushValidator(isSet);
			      vCont.pushValidator(strLen);
		      ContList.add(vCont);

		      //Emailに対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.POST.MAIL));
		          vCont.setTargetName(Params.POST.MAIL);
//		          vCont.pushValidator(isMail);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);

		      //電話番号に対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.POST.TEL));
		          vCont.setTargetName(Params.POST.TEL);
		          vCont.pushValidator(isSet);
//		          vCont.pushValidator(isTel);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);

		      //郵便番号に対するValidate
		      vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameter(Params.POST.ADDNUM));
			      vCont.setTargetName(Params.POST.ADDNUM);
//			      vCont.pushValidator(isZip);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);

		      //住所に対するValidate
		      vCont = new ExeValidateContainerImpl();
			      vCont.setTargetValue(request.getParameter(Params.POST.ADD1));
			      vCont.setTargetName(Params.POST.ADD1);
			      vCont.pushValidator(isSet);
			      vCont.pushValidator(strLen);
		      ContList.add(vCont);

		      //お問い合わせに対するValidate
		      vCont = new ExeValidateContainerImpl();
		          vCont.setTargetValue(request.getParameter(Params.POST.INQUIRY));
		          vCont.setTargetName(Params.POST.INQUIRY);
		          vCont.pushValidator(strLen);
		      ContList.add(vCont);

		   //コンテナパッケージのインスタンス化
		   ExeContainerPackageImpl vPkg = new ExeContainerPackageImpl();
		   for(ExeValidateContainerImpl cont : ContList)
			   vPkg.pushContainers(cont);

		   return vPkg;
	}
}
