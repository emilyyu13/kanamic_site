﻿/*
	レシピシミュレーター Ver1.0
	Copyright 2005 Kanamic Network

	無断複製、無断転載を禁じます
 */
var sn = new Array(15);
sn[0]="無し";
sn[1]="エネルギー";
sn[2]="たんぱく質";
sn[3]="脂質";
sn[4]="炭水化物";
sn[5]="カルシウム";
sn[6]="鉄";
sn[7]="ビタミンＡ";
sn[8]="ビタミンＢ１";
sn[9]="ビタミンＢ２";
sn[10]="ビタミンＣ";
sn[11]="ビタミンＥ";
sn[12]="食塩相当量";
sn[13]="食物繊維";
sn[14]="作り方";


/*　メニュー数設定　*/
var a1 = new Array(21);
var a2 = new Array(21);
var a3 = new Array(21);

/* 食事ＤＢ */
/* 朝食 */
a1[0]="なし|0|t|t|t|t|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|||||||||||||||||||||||||||||||||||||||||||||||";
a1[1]="キノコのスクランブルエッグ|1|t|t|f|t|0|0|0|0|0|0|0|410.5|20.6|16.2|47.8|191.5|2.2|221.3|0.3|0.6|72.4|2.6|2.2|5.5|food02/001.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[2]="ポーチドエッグ|1|t|t|f|t|0|0|0|0|0|0|0|472.6|21.4|10.589|74.5|198.5|2.5|249.7|0.3|0.6|96.2|2.2|2.8|6|food02/003.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[3]="チキンサラダ|1|t|t|f|t|0|0|0|0|0|0|0|598.9|32.9|14.7|84.6|323.3|2.4|407|0.5|0.5|55.4|1.1|3|9.1|food02/005.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[4]="チーズトースト|1|t|t|f|t|0|0|0|0|0|0|0|549.6|21.6|20.4|71|467.4|1.3|456.9|0.2|0.5|66.9|2.8|3.8|6.6|food02/007.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[5]="春キャベツとわかめのおひたし|1|t|t|t|f|0|0|0|0|0|0|0|435|16.8|6.4|78.4|149.7|3.2|26.4|0.2|0.3|34|1.6|3.4|8.1|food01/006.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[6]="炒り豆腐あっさり風味|1|t|t|t|f|0|0|0|0|0|0|0|424.3|16.9|9.2|67.2|224|2.6|178|0.25|0.16|16|1.5|2.8|4.7|food01/008.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[7]="サニーサイドアップ|1|t|t|f|t|0|0|0|0|0|0|0|619.4|26.9|11.8|105.2|393|4|434|0.49|0.76|236|2.6|2.3|12.4|food02/008.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[8]="ちらし寿司|1|t|t|t|f|0|0|0|0|0|0|0|623|43.4|12.061|91.5|224.8|21.2|526.4|0.4|0.6|101.4|44.1|6.9|7.8|food01/002.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[9]="牛肉と野菜のソテー|1|t|t|f|t|0|0|0|0|0|0|0|553.6|27|9.777|87.9|192.6||77.5|0.4|0.4|156.3|2.8|3.2|4.9|food02/004.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[10]="カツオのたたき|1|t|t|t|f|0|0|0|0|0|0|0|500.6|29.2|5.9|80.7|111.3|4|52.2|0.3|0.3|48.8|1.5|3.1|4.1|food01/001.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[11]="スープスパゲティ|1|t|t|f|t|0|0|0|0|0|0|0|619.5|24.5|13.2|101.2|289.3|2.4|817.7|0.6|0.5|136.6|8.4|3.4|9.8|food02/002.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[12]="生揚げと野菜の網焼き|1|t|t|t|f|0|0|0|0|0|0|0|470.7|15.3|7.6|87.2|219|3.5|1038.1|0.4|0.2|105.7|2.2|3|6.9|food01/004.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[13]="豚の生姜焼き|1|t|t|t|f|0|0|0|0|0|0|0|576.6|30.1|8.6|90.9|233|8.6|505|0.98|0.51|107|2.6|4.8|9.6|food01/003.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[14]="牛モモ肉のポトフ風|1|t|t|f|t|0|0|0|0|0|0|0|688.8|39.3|12.9|106.3|290.8|5.4|360.4|0.5|0.7|197.3|1.7|6.2|12.6|food02/006.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[15]="さわらのふき味噌風味|1|t|t|t|f|0|0|0|0|0|0|0|563.9|23.4|8.6|95.5|171.6|4.4|329.6|0.4|0.5|75.8|2.6|2.4|6.4|food01/005.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[16]="炒り鳥|1|t|t|t|f|0|0|0|0|0|0|0|603.8|29.8|11.1|96.8|105.2|3.4|369.5|0.4|0.5|120.2|3|3.1|9.3|food01/007.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[17]="イカの松笠焼き|1|t|t|t|f|0|0|0|0|0|0|0|513.4|35.1|7.4|72.6|113|2.5|498|0.25|0.19|45|5.2|4.6|4.2|food01/009.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[18]="ゆで豚の冷しゃぶ|1|t|t|t|f|0|0|0|0|0|0|0|578|24.6|12.9|86.1|124|2.9|357|0.86|0.27|57|1.8|3.5|7.3|food01/010.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[19]="きんめだいの煮付け|1|t|t|t|f|0|0|0|0|0|0|0|622.9|23.5|13.3|96.3|183|2.9|74|0.26|0.16|38|4.2|4.1|7.4|food01/011.html||||||||||||||||||||||||||||||||||||||||||||||||";
a1[20]="スパゲティボロネーゼ|1|t|t|f|t|0|0|0|0|0|0|0|718.4|33.7|22.2|90.7|317|2.7|245|0.38|0.5|63|3.1|3.5|7.1|food02/009.html||||||||||||||||||||||||||||||||||||||||||||||||";

/* 昼食 */
a2[0]="なし|0|t|t|t|t|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|||||||||||||||||||||||||||||||||||||||||||||||";
a2[1]="キノコのスクランブルエッグ|1|t|t|f|t|0|0|0|0|0|0|0|410.5|20.6|16.2|47.8|191.5|2.2|221.3|0.3|0.6|72.4|2.6|2.2|5.5|food02/001.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[2]="ポーチドエッグ|1|t|t|f|t|0|0|0|0|0|0|0|472.6|21.4|10.589|74.5|198.5|2.5|249.7|0.3|0.6|96.2|2.2|2.8|6|food02/003.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[3]="チキンサラダ|1|t|t|f|t|0|0|0|0|0|0|0|598.9|32.9|14.7|84.6|323.3|2.4|407|0.5|0.5|55.4|1.1|3|9.1|food02/005.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[4]="チーズトースト|1|t|t|f|t|0|0|0|0|0|0|0|549.6|21.6|20.4|71|467.4|1.3|456.9|0.2|0.5|66.9|2.8|3.8|6.6|food02/007.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[5]="春キャベツとわかめのおひたし|1|t|t|t|f|0|0|0|0|0|0|0|435|16.8|6.4|78.4|149.7|3.2|26.4|0.2|0.3|34|1.6|3.4|8.1|food01/006.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[6]="炒り豆腐あっさり風味|1|t|t|t|f|0|0|0|0|0|0|0|424.3|16.9|9.2|67.2|224|2.6|178|0.25|0.16|16|1.5|2.8|4.7|food01/008.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[7]="サニーサイドアップ|1|t|t|f|t|0|0|0|0|0|0|0|619.4|26.9|11.8|105.2|393|4|434|0.49|0.76|236|2.6|2.3|12.4|food02/008.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[8]="ちらし寿司|1|t|t|t|f|0|0|0|0|0|0|0|623|43.4|12.061|91.5|224.8|21.2|526.4|0.4|0.6|101.4|44.1|6.9|7.8|food01/002.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[9]="牛肉と野菜のソテー|1|t|t|f|t|0|0|0|0|0|0|0|553.6|27|9.777|87.9|192.6||77.5|0.4|0.4|156.3|2.8|3.2|4.9|food02/004.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[10]="カツオのたたき|1|t|t|t|f|0|0|0|0|0|0|0|500.6|29.2|5.9|80.7|111.3|4|52.2|0.3|0.3|48.8|1.5|3.1|4.1|food01/001.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[11]="スープスパゲティ|1|t|t|f|t|0|0|0|0|0|0|0|619.5|24.5|13.2|101.2|289.3|2.4|817.7|0.6|0.5|136.6|8.4|3.4|9.8|food02/002.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[12]="生揚げと野菜の網焼き|1|t|t|t|f|0|0|0|0|0|0|0|470.7|15.3|7.6|87.2|219|3.5|1038.1|0.4|0.2|105.7|2.2|3|6.9|food01/004.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[13]="豚の生姜焼き|1|t|t|t|f|0|0|0|0|0|0|0|576.6|30.1|8.6|90.9|233|8.6|505|0.98|0.51|107|2.6|4.8|9.6|food01/003.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[14]="牛モモ肉のポトフ風|1|t|t|f|t|0|0|0|0|0|0|0|688.8|39.3|12.9|106.3|290.8|5.4|360.4|0.5|0.7|197.3|1.7|6.2|12.6|food02/006.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[15]="さわらのふき味噌風味|1|t|t|t|f|0|0|0|0|0|0|0|563.9|23.4|8.6|95.5|171.6|4.4|329.6|0.4|0.5|75.8|2.6|2.4|6.4|food01/005.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[16]="炒り鳥|1|t|t|t|f|0|0|0|0|0|0|0|603.8|29.8|11.1|96.8|105.2|3.4|369.5|0.4|0.5|120.2|3|3.1|9.3|food01/007.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[17]="イカの松笠焼き|1|t|t|t|f|0|0|0|0|0|0|0|513.4|35.1|7.4|72.6|113|2.5|498|0.25|0.19|45|5.2|4.6|4.2|food01/009.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[18]="ゆで豚の冷しゃぶ|1|t|t|t|f|0|0|0|0|0|0|0|578|24.6|12.9|86.1|124|2.9|357|0.86|0.27|57|1.8|3.5|7.3|food01/010.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[19]="きんめだいの煮付け|1|t|t|t|f|0|0|0|0|0|0|0|622.9|23.5|13.3|96.3|183|2.9|74|0.26|0.16|38|4.2|4.1|7.4|food01/011.html||||||||||||||||||||||||||||||||||||||||||||||||";
a2[20]="スパゲティボロネーゼ|1|t|t|f|t|0|0|0|0|0|0|0|718.4|33.7|22.2|90.7|317|2.7|245|0.38|0.5|63|3.1|3.5|7.1|food02/009.html||||||||||||||||||||||||||||||||||||||||||||||||";

/* 夕食 */
a3[0]="なし|0|t|t|t|t|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|||||||||||||||||||||||||||||||||||||||||||||||";
a3[1]="キノコのスクランブルエッグ|1|t|t|f|t|0|0|0|0|0|0|0|410.5|20.6|16.2|47.8|191.5|2.2|221.3|0.3|0.6|72.4|2.6|2.2|5.5|food02/001.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[2]="ポーチドエッグ|1|t|t|f|t|0|0|0|0|0|0|0|472.6|21.4|10.589|74.5|198.5|2.5|249.7|0.3|0.6|96.2|2.2|2.8|6|food02/003.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[3]="チキンサラダ|1|t|t|f|t|0|0|0|0|0|0|0|598.9|32.9|14.7|84.6|323.3|2.4|407|0.5|0.5|55.4|1.1|3|9.1|food02/005.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[4]="チーズトースト|1|t|t|f|t|0|0|0|0|0|0|0|549.6|21.6|20.4|71|467.4|1.3|456.9|0.2|0.5|66.9|2.8|3.8|6.6|food02/007.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[5]="春キャベツとわかめのおひたし|1|t|t|t|f|0|0|0|0|0|0|0|435|16.8|6.4|78.4|149.7|3.2|26.4|0.2|0.3|34|1.6|3.4|8.1|food01/006.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[6]="炒り豆腐あっさり風味|1|t|t|t|f|0|0|0|0|0|0|0|424.3|16.9|9.2|67.2|224|2.6|178|0.25|0.16|16|1.5|2.8|4.7|food01/008.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[7]="サニーサイドアップ|1|t|t|f|t|0|0|0|0|0|0|0|619.4|26.9|11.8|105.2|393|4|434|0.49|0.76|236|2.6|2.3|12.4|food02/008.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[8]="ちらし寿司|1|t|t|t|f|0|0|0|0|0|0|0|623|43.4|12.061|91.5|224.8|21.2|526.4|0.4|0.6|101.4|44.1|6.9|7.8|food01/002.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[9]="牛肉と野菜のソテー|1|t|t|f|t|0|0|0|0|0|0|0|553.6|27|9.777|87.9|192.6||77.5|0.4|0.4|156.3|2.8|3.2|4.9|food02/004.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[10]="カツオのたたき|1|t|t|t|f|0|0|0|0|0|0|0|500.6|29.2|5.9|80.7|111.3|4|52.2|0.3|0.3|48.8|1.5|3.1|4.1|food01/001.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[11]="スープスパゲティ|1|t|t|f|t|0|0|0|0|0|0|0|619.5|24.5|13.2|101.2|289.3|2.4|817.7|0.6|0.5|136.6|8.4|3.4|9.8|food02/002.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[12]="生揚げと野菜の網焼き|1|t|t|t|f|0|0|0|0|0|0|0|470.7|15.3|7.6|87.2|219|3.5|1038.1|0.4|0.2|105.7|2.2|3|6.9|food01/004.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[13]="豚の生姜焼き|1|t|t|t|f|0|0|0|0|0|0|0|576.6|30.1|8.6|90.9|233|8.6|505|0.98|0.51|107|2.6|4.8|9.6|food01/003.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[14]="牛モモ肉のポトフ風|1|t|t|f|t|0|0|0|0|0|0|0|688.8|39.3|12.9|106.3|290.8|5.4|360.4|0.5|0.7|197.3|1.7|6.2|12.6|food02/006.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[15]="さわらのふき味噌風味|1|t|t|t|f|0|0|0|0|0|0|0|563.9|23.4|8.6|95.5|171.6|4.4|329.6|0.4|0.5|75.8|2.6|2.4|6.4|food01/005.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[16]="炒り鳥|1|t|t|t|f|0|0|0|0|0|0|0|603.8|29.8|11.1|96.8|105.2|3.4|369.5|0.4|0.5|120.2|3|3.1|9.3|food01/007.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[17]="イカの松笠焼き|1|t|t|t|f|0|0|0|0|0|0|0|513.4|35.1|7.4|72.6|113|2.5|498|0.25|0.19|45|5.2|4.6|4.2|food01/009.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[18]="ゆで豚の冷しゃぶ|1|t|t|t|f|0|0|0|0|0|0|0|578|24.6|12.9|86.1|124|2.9|357|0.86|0.27|57|1.8|3.5|7.3|food01/010.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[19]="きんめだいの煮付け|1|t|t|t|f|0|0|0|0|0|0|0|622.9|23.5|13.3|96.3|183|2.9|74|0.26|0.16|38|4.2|4.1|7.4|food01/011.html||||||||||||||||||||||||||||||||||||||||||||||||";
a3[20]="スパゲティボロネーゼ|1|t|t|f|t|0|0|0|0|0|0|0|718.4|33.7|22.2|90.7|317|2.7|245|0.38|0.5|63|3.1|3.5|7.1|food02/009.html||||||||||||||||||||||||||||||||||||||||||||||||";

/*  */
var n1 = new Array(sn.length + 12);
var n2 = new Array(sn.length + 12);
var n3 = new Array(sn.length + 12);
var n4 = new Array(sn.length + 12);
var n5 = new Array(sn.length + 12);
var s1 = new Array(sn.length + 12);
var s2 = new Array(sn.length + 12);
var s3 = new Array(sn.length + 12);
var s4 = new Array(sn.length + 12);
var s5 = new Array(sn.length + 12);
var t = new Array(sn.length);
var ef = new Array(sn.length);
for (i = 1; i<sn.length+1; i++) {
	n1[i+12] = "";
	n2[i+12] = "";
	n3[i+12] = "";
	n4[i+12] = "";
	n5[i+12] = "";
	s1[i] = "";
	s2[i] = "";
	s3[i] = "";
	t[i] = "";
	ef[i] = "";
}
for (i = 0; i< 13; i++) {
	n1[i] = "";
	n2[i] = "";
	n3[i] = "";
	n4[i] = "";
	n5[i] = "";
}
function intv(val) {
	if (val < 0 || val > 0) {
		return val;
	}
	return 0;
}
function check(loc) {
	var total = 0;
	if (loc < 14) {
		total = Math.round((eval(intv(s1[loc])) + eval(intv(s2[loc])) + eval(intv(s3[loc])))*100);
		total = eval(total/100);
	} else {
		if (s1[loc] == 0) {
			s1[loc] = "";
		}

		if (s2[loc] == 0) {
			s2[loc] = "";
		}

		if (s3[loc] == 0) {
			s3[loc] = "";
		}
	}

	t[loc] = total;
	if (total == 0) {
		total = "";

	}

	eval("document.myform.breakfast" + loc + ".value = s1[loc]");
	eval("document.myform.lunch" + loc + ".value = s2[loc]");
	eval("document.myform.dinner" + loc + ".value = s3[loc]");
	if (loc < 14) {
		eval("document.myform.total" + loc + ".value = total");
	}
}

function setdata(type, no) {
/********************************************/
/*関数詳細                                  */
/* 選択されているメニューを評価して         */
/* フォームに結果をセットする               */
/********************************************/
	var data;
	if (no == "") { no = 0; }
	if (no == -1) { no = 0; }
	if (nodisp) { return; }
	eval ("data = a" + type + "[" + no + "];");
	var n = data.split("|");
	var total = "";
	eval ("n"+type+" = n;");
	for (i = 1; i < sn.length; i++) {
		if (eval("s" + type + "[" + i + "]") != n[i+12]) {
			eval("s" + type + "[" + i + "] = n[i+12]");
			check(i);
		}
		if (intv(t[i]) != 0) {
			var sname = sn[i];
			if (intv(t[i]) > 0) {
				if (i > 59) {
					total += sname + "\n";
				} else {
					total += sname + " " + intv(t[i]) + "\n";
				}
			} else {
				total += sname + " " + intv(t[i]) + "\n";
			}
			if (ef[i] != "") {
			}
		}
	}
}

function init() {
	loadfromcookie();
}

function equip_edit(type, mode) {
/********************************************/
/*関数詳細                                  */
/* ↓保存ボタン押下時にして                 */
/* 候補の保存を行う                         */
/********************************************/
	if (mode == "↓保存") {
		eval("var stock = document.myform.stock"+type+";");
		eval("equip = document.myform.equip"+type+".value;");
		eval("opt = document.myform.equip"+type+".options;");
		var find = false;
		for (i = 0; i < stock.options.length; i++) {
			if (stock.options[i].value == equip) {
				find = true;
				stock.options[i].selected = true;
			}
		}
		if (!find) {
			var next = stock.options.length;
			stock.options.length = next + 1;
			stock.options[next].value = equip;
			stock.options[next].text = getdisplayname(type, equip);
			stock.options[next].selected = true;
			if (next = 1) {
				stock.options[0].text = "なし";
			}
		}
	} else {
		eval("var stock = document.myform.stock"+type+";");
		if (stock.value > 0) {
			for (i = 0; i < stock.options.length; i++) {
				if (stock.options[i].selected = true) {
					for (j = i + 1; j < stock.options.length - 1; j++) {
						find = true;
						stock.options[j].value = stock.options[j+1].value;
						stock.options[j].text = stock.options[j+1].text;
					}
					i = stock.options.length;
					stock.options.length = stock.options.length - 1;
				}
			}
		}
	}
	saveto	();
}

function copydata(type, no) {
	eval("var equip = document.myform.equip"+type+";");
	var find = false;
	for (i = 0; i < equip.options.length; i++) {
		if (equip.options[i].value == no) {
			equip.options[i].selected = true;
			find = true;
		}
	}
	if (!find) {
		var next = equip.options.length;
		equip.options.length = next + 1;
		equip.options[next].value = no;
		equip.options[next].text = getdisplayname(type, no);
		equip.options[next].selected = true;
	}
}

function saveto	() {
/********************************************/
/*関数詳細                                  */
/* 保存ボタン押下時に選択したメニューを     */
/* クッキーファイルに書き込む               */
/********************************************/

	var data = document.myform.type.value+",t,1,0";
	for (type = 1; type < 4; type++) {
		eval("var equip = document.myform.equip"+type+".value;");
		eval("var stock = document.myform.stock"+type+";");
		data += "|"+equip;
		for (i = 1; i < stock.options.length; i++) {
			data += "," + stock.options[i].value;
		}
	}
	exp=new Date();
	exp.setTime(exp.getTime()+1000*60*60*24*30);
	document.cookie = "stock=" + data + "; expires=" + exp.toGMTString();
}

function formselect(sform, value) {
	for (i = 0; i < sform.options.length; i++) {
		if (sform.options[i].value == value) {
			sform.options[i].selected = true;
		}
	}
}

function loadfromcookie(){
/********************************************/
/*関数詳細                                  */
/* クッキーの値を取得し、                   */
/* フィルター条件とストック内容をセットする */
/********************************************/
	cookies = document.cookie.split(";");
	var data = "w,male,5,0|0|0|0";
	filter();
	i = 0;
	while (cookies[i]){
		if (cookies[i].substr(0,4) == "stock="){
			data = cookies[i].substr(6,cookies[i].length);
			break;
		}
		i++;
	}
	var typedata = data.split("|");
	var formdata = typedata[0].split(",");
	formselect(document.myform.type, formdata[0]);
	filter();
	
	for (type = 1; type < typedata.length; type++) {
		var stockdata = typedata[type].split(",");
		eval("var stock = document.myform.stock"+type+";");
		eval("var equip = document.myform.equip"+type+";");
		eval("var opt = document.myform.equip"+type+".options;");
		if (!nodisp) {
			var find = false;
			for (i = 0; i < equip.options.length; i++) {
				if (equip.options[i].value == stockdata[0]) {
					equip.options[i].selected = true;
					find = true;
				}
			}
			if (!find) {
				if (stockdata[0] == -1) {
					stockdata[0] = 0;
				}
				var next = equip.options.length;
				equip.options.length = next + 1;
				equip.options[next].value = stockdata[0];
				equip.options[next].selected = true;
				equip.options[next].text = getdisplayname(type, stockdata[0]);
			}
		}
		for (s = 1; s < stockdata.length; s++) {
			var next = stock.options.length;
			stock.options.length = next + 1;
			stock.options[next].value = stockdata[s];
			stock.options[next].text = getdisplayname(type, stockdata[s]);
			if (next = 1) {
				stock.options[0].text = "なし";
			}
		}
		setdata(type, stockdata[0]);
	}
}

function filter() {
/********************************************/
/*関数詳細                                  */
/* 画面のフィルター条件にあったメニュー     */
/* プルダウンにセットする                   */
/********************************************/
	var etype = document.myform.type.value;

	for (type = 1; type < 4; type++) {
		eval("var equip = document.myform.equip" + type + ".options;");
		eval("var armor = a" + type + ";");
		var next = 0;
		if (equip[next].value == "-1") {
			next++;
		}
		for (a = 0; a < armor.length; a++) {
			var data = armor[a];
			if (data == null) { continue; }
			var n = data.split("|");
			var disp = true;
			if (eval("n"+type+"[0]") != n[0]) {
				if (etype == "w" && n[4] == "f") { continue; }
				if (etype == "g" && n[5] == "f") { continue; }
				if (equip.length < next + 1) {
					equip.length = next + 1;
				}
				if (equip[next].value != a) {
					equip[next].value = a;
					equip[next].text = getdisplaynamefromarray(n);
				}
			} else {
				if (equip.length < next + 1) {
					equip.length = next + 1;
				}
				if (equip[next].value != a) {
					equip[next].value = a;
					equip[next].text = getdisplaynamefromarray(n);
				}
				equip[next].selected = true;
			}
			next++;
		}
		if (equip.length > next) {
			equip.length = next;
		}
	}
}

function getdisplayname(type, no) {
	var data = "";
	if (no == "") { no = 0; }
	eval ("data = a" + type + "[" + no + "];");
	var n = data.split("|");
	return getdisplaynamefromarray(n);
}

function getdisplaynamefromarray(n) {
/********************************************/
/*関数詳細                                  */
/* DBのデータを加工してプルダウンに表示する */
/* 文字列を生成する                         */
/********************************************/
	var disp = n[0] + " ";
	var kakko = " (";

	if (n[13] != "") {
		disp += kakko;
		kakko = " ";
		var sname = sn[1];
//		disp += sname + intv(n[13]) + "kcal\n";
		disp += intv(n[13]) + "kcal\n";
	}
	if (kakko != " (") {
		disp += ")";
	}
	return disp;
}

function makingOpen(url) {
/********************************************/
/*関数詳細                                  */
/* 選択したメニューのURLを別画面に表示する  */
/*                                          */
/********************************************/
	if (url != "") {
		if (document.layers) { addr='NewWindow-Dummy.html'; }
		window.open(url,"PopUp","width=700, height=550, toolbar=1, location=0, directories=0, status=1, menubar=0, scrollbars=1, resizable=1");
		return;
	} else {
		alert('メニューを選んでください。'); 
	}
}

var nodisp = false;