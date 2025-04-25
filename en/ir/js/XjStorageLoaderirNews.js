//========================================================
//
// ■XJStorageLoaderクラス定義
//
//========================================================

if (!Array.prototype.indexOf)
{
	Array.prototype.indexOf = function(elt /*, from*/)
	{
		var len = this.length;

		var from = Number(arguments[1]) || 0;
		from = (from < 0)
				 ? Math.ceil(from)
				 : Math.floor(from);
		if (from < 0)
			from += len;

		for (; from < len; from++)
		{
			if (from in this &&
					this[from] === elt)
				return from;
		}
		return -1;
	};
}

(function() {

	/*========================================================
	 コンストラクタ AS80746
	========================================================*/
	XjStorageLoaderNews = function(s)
	{
		var defaults =
		{
			domain:'//www.xj-storage.jp',
			company:'AS80746',
			pdf:'1',
			len:'',
			documents_all:'',
			documents_Disclosure:'0,5,6,8,9,13,15,24,25,28',
			documents_Fresults:'1,2,3,4,16,17,18,19,20,21',
			documents_Sreport:'99,105,106,107,108,1030,1040,1080,1090,1100,1120,1130,1135,1136,1140,1150,1160,1170,1180,1190,1200,1210,1220,1230,1235,1236,1240,1250,1260,1270,1280,1290,1300,1310,1320,1350,1360',
			documents_Ir:'34,90,91,92,93,95,96,97,98,101,102,103,104,110,111,112,113,114,115,116,117,118,119,120',
			documents_Info:'14,200'
		};

		this.settings = $.extend ( defaults, s ) ;
		this.fdate;
		this.pdate;
		this.documents;
		this.select_latest = '';
		this.select_oldest = '';

		this.ary_doc_no ;
		this.ary_doc_Disclosure ;
		this.ary_doc_Fresults ;
		this.ary_doc_Sreport ;
		this.ary_doc_Ir ;
		this.ary_doc_Info ;

		XjStorageLoaderNews.prototype.init.call(this);
 	};

	/*========================================================
	 初期設定
	========================================================*/
	XjStorageLoaderNews.prototype.init = function()
	{
		$.ajaxSetup ( { scriptCharset:'utf-8' } ) ;

		//$.ajaxSetup({scriptCharset:'shift_jis'});
		this.ary_doc_Disclosure  = this.settings.documents_Disclosure.split ( "," ) 
		this.ary_doc_Fresults	= this.settings.documents_Fresults.split ( "," ) ;
		this.ary_doc_Sreport  = this.settings.documents_Sreport.split ( "," ) ;
		this.ary_doc_Ir  = this.settings.documents_Ir.split ( "," ) ;
		this.ary_doc_Info  = this.settings.documents_Info.split ( "," ) ;
		
		//全部
		this.settings.documents_all =
					this.settings.documents_Disclosure + ',' +
					this.settings.documents_Fresults + ',' +
					this.settings.documents_Sreport + ',' +
					this.settings.documents_Ir + ',' +
					this.settings.documents_Info ;

		//初期読み込み対象指定
		this.ary_doc_no = this.settings.documents_all.split ( "," ) ;

		//記事年範囲取得
		this.setMaxMinYear ( this.documents ) ;
	};

	/*========================================================
	 年選択ボタン生成
	========================================================*/
	XjStorageLoaderNews.prototype.setMaxMinYear = function(code)
	{
		var self = this;
		var xjurl = '';

		//URL生成
		xjurl += self.settings.domain + '/public-list/GetList.aspx?company=';
		xjurl += self.settings.company;
		xjurl += '&len=10000';

		// タイプ指定
		if ( this.documents && this.documents.length > 0 )
		{
			xjurl += '&doctype=' + this.documents;
		}

		xjurl += '&output=json&callback=?';

		$.ajax (
		{
			url: xjurl,
			dataType: 'json',

			success : function ( data )
			{
				if ( undefined == data.items )
				{
					return ;
				}

				$.each ( data.items, function ( i, item )
				{
					// 目的の文書番号でなかったら
					if ( -1 == self.ary_doc_no.indexOf ( item.disclosureCode ) )
					{
						return true ;
					}

					var date = item.publishDate.split(' ')[ 0 ].split( '/' ) ;
					var entry_year = date[ 0 ] ;

					//最新の年月期と最古の年月期を取得
					if ( self.select_latest === '' || self.select_latest < entry_year )
					{
						self.select_latest = entry_year ;
					}

					if ( self.select_oldest === '' || self.select_oldest >= entry_year )
					{
						self.select_oldest = entry_year ;
					}
				});
			},
			complete : function ( )
			{
				self.setDateButton ( ) ;
				self.setDocumentButton ( ) ;
				self.show ( ) ;
			}
		}
		);
	}

	/*========================================================
	 年選択ボタン生成
	========================================================*/
	XjStorageLoaderNews.prototype.setDateButton = function ( )
	{
		var self = this ;

		var ul = $( '#xj-select-year_s' ) ;
		var tmp = $( '<option value="">年を選択してください</option>' ) ;
		ul.append ( tmp ) ;

		//年範囲分年メニュー生成
		for ( var i = self.select_latest; i >= self.select_oldest; i-- )
		{
			if ( i == self.active_select )
			{
				tmp = $( '<option value="' + i + '" selected>' + i + '年</option>' ) ;
			}
			else
			{
				tmp = $( '<option value="' + i + '">' + i + '年</option>' ) ;
			}

			ul.append ( tmp ) ;
		}

		ul.change ( function ( )
		{
			var year = $( '#xj-select-year_s option:selected' ).val ( ) ;

			$( '#xj-select-year_s').val ( year ) ;

			if ( "" == year )
			{
				self.fdate = "" ;
				self.pdate = "" ;
				self.setDuration ( year, year ) ;
				self.show ( ) ;
				return ;
			}

			self.setDuration ( year + '1231', year + '0101' ) ;
		}) ;
	}

	/*========================================================
	 カテゴリー選択ボタン生成
	========================================================*/
	XjStorageLoaderNews.prototype.setDocumentButton = function ( )
	{
		var self = this;

		//カテゴリーボタン生成
		//var ul = $( '#xj-select-category_s' ) ;

		var ul = $( '<ul id="type"></ul>' ) ;
		
		ul.append (
				$( '<li class="active"></li>' ).click ( function ( )
				{
					self.setDocument ( self.settings.documents_all ) ;
				}
				).append ( '<a href="javascript:void(0);" >全て</a>' ) ) ;

		ul.append (
				$('<li></li>').click ( function ( )
				{
					self.setDocument ( self.settings.documents_Disclosure ) ;
				}
				).append ( '<a href="javascript:void(0);">適時開示</a>' ) ) ;

		ul.append (
				$( '<li></li>' ).click ( function ( )
				{
					self.setDocument ( self.settings.documents_Fresults ) ;
				}
				).append ( '<a href="javascript:void(0);">Financial Results</a>' ) ) ;

		ul.append (
				$( '<li></li>' ).click ( function ( )
				{
					self.setDocument ( self.settings.documents_Sreport ) ;
				}
				).append ( '<a href="javascript:void(0);">法定開示</a>' ) ) ;

		ul.append (
				$ ( '<li></li>' ).click ( function ( )
				{
					self.setDocument ( self.settings.documents_Ir ) ;
				}
				).append ( '<a href="javascript:void(0);">IR資料</a>' ) ) ;
				
		ul.append (
				$ ( '<li></li>' ).click ( function ( )
				{
					self.setDocument ( self.settings.documents_Info ) ;
				}
				).append ( '<a href="javascript:void(0);">お知らせ</a>' ) ) ;


		$( '#xj-select-category' ).append ( ul ) ;


		
		//カテゴリー選択ボタンロールオーバー等
		$ ( '#xj-select-category li' ).click ( function ( )
		{
			$( '#xj-select-category li.active' ).removeClass ( 'active') ;
			$( this ).addClass( 'active' ) ;
		});
		
	}

	/*========================================================
	 絞込み期間更新
	========================================================*/
	XjStorageLoaderNews.prototype.setDuration = function ( f, p )
	{
		this.fdate = f;
		this.pdate = p;
		this.show();
	}

	/*========================================================
	 絞込みカテゴリー更新
	========================================================*/
	XjStorageLoaderNews.prototype.setDocument = function ( d )
	{
		this.documents = d;
		this.show();
	}

	/*========================================================
	 表示処理
	========================================================*/
	XjStorageLoaderNews.prototype.show = function()
	{
		var self = this;
		var is_first = true;

		var url =  this.settings.domain + '/public-list/GetList.aspx?company=';

		url += this.settings.company;

		// 日付範囲指定
		if ( this.fdate && this.fdate.length > 0 )
		{
			url+= '&fdate=' + this.fdate;
		}

		if ( this.pdate && this.pdate.length > 0 )
		{
			url+= '&pdate=' + this.pdate;
		}

		
		// 取得個数指定
		if ( !( this.pdate && this.pdate.length > 0 ) &&
				!( this.fdate && this.fdate.length > 0 ) )
		{
			url+= '&len=' + self.settings.len;
		}
		else
		{
			url+= '&len=10000';
		}


		// タイプ指定
		if ( this.documents && this.documents.length > 0 )
		{
			url+= '&doctype=' + this.documents;
		}

		//url+= '&filetype=PDF-GENERAL';
		url+= '&output=json&callback=?';

		$.getJSON ( url, function ( data )
		{
			$('#xj-mainlist').empty ( ) ;

			var cont = '';

			if ( data.items )
			{

				var j = 0 ;
				var now_dd = new Date ( ) ;

				$.each ( data.items, function ( i, item )
				{
					// 目的の文書番号でなかったら
					if ( -1 == self.ary_doc_no.indexOf ( item.disclosureCode ) )
					{
						return true;
					}

					if ( ( '' == self.fdate || !self.fdate ) && j > 19 )
					{
						return true ;
					}

					var entrytype = '';
					var url = '';
					var size = '';
					var page = '';

					if ( item.files )
					{
						$.each ( item.files, function ( j, file )
						{
							if ( file.type == 'PDF-GENERAL')
							{
								url = file.url ;
								size = parseInt ( file.size ) ;
								page = file.page ;
							}
							else if ( file.type == 'HTML-GENERAL')
							{
								url = file.url ;
								
							}
						});
					}

					// サイズ設定
					if ( size > 0 )
					{
						if ( size > 1000000)
						{
							size = parseInt ( size / 1000000 ) + 'M' ;
						}
						else if ( size > 1000 )
						{
							size = parseInt ( size / 1000 ) + 'K' ;
						}
					}
					else
					{
						size = '－' ;
					}


					// アイコンファイル設定
					var icon_class = '' ;
					var icon_alt = '' ;

					if ( -1 != self.ary_doc_Disclosure.indexOf ( item.disclosureCode ) )
					{
						icon_class = 'icon_discro';
						icon_alt = '適時開示';
					}
					else if ( -1 != self.ary_doc_Fresults.indexOf ( item.disclosureCode ) )
					{
						icon_class = 'icon_result';
						icon_alt = 'Financial Results';
					}
					else if ( -1 != self.ary_doc_Sreport.indexOf ( item.disclosureCode ) )
					{
						icon_class = 'icon_legal';
						icon_alt = '法定開示';
					}
					else if ( -1 != self.ary_doc_Ir.indexOf ( item.disclosureCode ) )
					{
						icon_class = 'icon_ir';
						icon_alt = 'IR資料';
					}
					else if ( -1 != self.ary_doc_Info.indexOf ( item.disclosureCode ) )
					{
						icon_class = 'icon_info';
						icon_alt = 'お知らせ';
					}

					// 日付設定
					var date = item.publishDate.split(' ')[0].split('/');
					var dateStr = date[0] + '年' + date[1] + '月' + date[2] + '日' ;
					var date_dd = new Date ( parseInt ( date[0], 10 ),
							parseInt ( date[1], 10 ) - 1,
							parseInt ( date[2], 10 ) ) ;
					

					// 画面表示
					
					cont += '<dt>' + dateStr + '' ;
					
					cont += '<span class="label '+ icon_class +'">'+ icon_alt +'</span></dt>' ;
					
					cont += '<dd>' ;
					
					
					
					if ( url != '' && size != '－' ) {
						
					cont += '<a href="' + url + '" target="_blank" class="pdf">';
					
					}
					
					else if  ( url != '')
					{
						cont += '<a href="' + url + '" target="_blank">';
					}
					
					cont += item.title ;
					
					
					
					if ( url != '' && size != '－' )
					{
						cont += ' [' + size + 'B]' ;
					}
					
					if ( url != '' )
					{
						cont += '</a>' ;
					}
					
										
					cont += '</dd>' ;

					j++ ;
				});
			}

			if ( '' == cont )
			{
				cont += '<dd class="nodate">ただいま掲載すべき事項はございません。</dd>' ;
			}

			

			$('#xj-mainlist').append ( cont ) ;
		});
	}

}());