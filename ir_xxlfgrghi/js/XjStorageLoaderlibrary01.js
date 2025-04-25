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
			documents_Kessan:'1,2,3,4,16,17,18,19,20,21'
		};

		this.settings = $.extend ( defaults, s ) ;
		this.fdate;
		this.pdate;
		this.documents;
		this.select_latest = '';
		this.select_oldest = '';

		this.ary_doc_no ;
		this.ary_doc_Kessan ;

		XjStorageLoaderNews.prototype.init.call(this);
 	};

	/*========================================================
	 初期設定
	========================================================*/
	XjStorageLoaderNews.prototype.init = function()
	{
		$.ajaxSetup ( { scriptCharset:'utf-8' } ) ;

		//$.ajaxSetup({scriptCharset:'shift_jis'});

		this.ary_doc_Kessan  = this.settings.documents_Kessan.split ( "," ) ;
		this.settings.documents_all = this.settings.documents_Kessan ;

		//初期読み込み対象指定
		this.documents = this.settings.documents_all;
		this.ary_doc_no = this.documents.split ( "," ) ;

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
						return true;
					}

					var entry_year = self.getFiscalYear ( item.title ) ;

					if ( "" == entry_year )
					{
						var date = item.publishDate.split(' ')[0].split('/');
						entry_year = Number ( date[ 0 ] ) ;
						

					}

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

				//self.active_select = self.select_latest ;
			},
			complete : function()
			{
				self.setDateButton ( ) ;
				//self.setDocumentButton ( ) ;
				self.show ( ) ;
			}
		}
		);
	}

	/*========================================================
	 0000年5月期取得（戻り値：0000）
	========================================================*/
	XjStorageLoaderNews.prototype.getFiscalYear = function ( title )
	{
		var self = this ;
		var fiscalyear = '' ;
		var res ;

		//スペース削除
		title = self.spaceTrim ( title ) ;

		//判定パターン
		var regexp1 = /平成([0-9０-９]{2})年([1-9１-９]{1,2})月期/ ;
		var regexp2 = /([0-9０-９]{4})年([1-9１-９]{1,2})月期/ ;

		var ki ;

		if ( ( res = regexp1.exec ( title ) ) !== null )
		{
			ki = Number ( self.zen2han ( res[ 1 ] ) ) ;
			fiscalyear = self.heiseiToSeireki ( ki ) ;
		}
		else if ( ( res = regexp2.exec ( title ) ) !== null )
		{
			ki = Number ( self.zen2han ( res[ 1 ] ) ) ;
			fiscalyear = ki ;
		}

		return fiscalyear ;

	}

	/*============================================
	 空白除去
	============================================*/
	XjStorageLoaderNews.prototype.spaceTrim = function(str) {
		return str.replace(/[ 　\t\r\n]+/g, "");
	}

	/*============================================

	 全角英数を半角に変換
	============================================*/
	XjStorageLoaderNews.prototype.zen2han = function(str){
		return str.replace(/[０-ｚ]/g,function($0){
			return String.fromCharCode(parseInt($0.charCodeAt(0))-65248);
		});
	}

	/*============================================
	 平成を西暦に変換
	============================================*/
	XjStorageLoaderNews.prototype.heiseiToSeireki = function ( y )
	{
		if ( ( y > 0 ) && ( y < 99 ) )
		{
			 return ( 1988 + y ) ;
		}
	}

	/*============================================
	 西暦を平成に変換
	============================================*/
	XjStorageLoaderNews.prototype.SeirekiToHeisei = function ( y )
	{
		if ( y > 1988 )
		{
			return ( y - 1988 ) ;
		}

		return y ;
	}

	/*========================================================
	 年選択ボタン生成
	========================================================*/
	XjStorageLoaderNews.prototype.setDateButton = function ( )
	{
		var self = this ;
		self.active_select = self.select_latest;
		var ul = $( '#xj-select-year_s' ) ;
		
		//年範囲分年メニュー生成
		for ( var i = self.select_latest; i >= self.select_oldest; i-- )
		{

			if ( i == '' )
			{
				$( '#xj-select-year_s' ).css('display','none') ;
			}
			
			if ( i == self.active_select )
			{
				var tmp = $( '<option value="' + i + '" selected>' + i + '年9月期</option>' ) ;
			}
			else
			{
				var tmp = $( '<option value="' + i + '">' + i + '年9月期</option>' ) ;
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
				return ;
			}

			//self.setDuration ( year + '1231', year + '0101' ) ;
			self.setDuration ( year, year ) ;
			
		}) ;
		self.setDuration(self.active_select);
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
		url += '&len=10000';

		// タイプ指定
		if ( this.documents && this.documents.length > 0 )
		{
			url+= '&doctype=' + this.documents;
		}

		//url+= '&filetype=PDF-GENERAL';
		url+= '&output=json&callback=?';

		$.getJSON ( url, function ( data, title )
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

					
					// 日付設定
					var date = item.publishDate.split(' ')[0].split('/');
					var dateStr = date[0] + '年' + date[1] + '月' + date[2]  + '日';
					var date_dd = new Date ( parseInt ( date[0], 10 ),
							parseInt ( date[1], 10 ) - 1,
							parseInt ( date[2], 10 ) ) ;

					// 年度の算出
					var entry_year = self.getFiscalYear ( item.title ) ;
					if ( "" == entry_year )
					{
						var date = item.publishDate.split(' ')[0].split('/');
						entry_year = Number ( date[ 0 ] ) ;

					}
					if ( ( '' == self.fdate || !self.fdate ) )
					{
						if ( j < 0 )
						{
							return true ;
						}
					}
					
					else if ( self.fdate != entry_year )
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

						});
					}

					if ( size > 0)
					{
						if ( size > 1000 && size < 1000000 )
						{
							size = parseInt ( size / 1000 ) + 'K' ;
						}
						else if ( size > 1000000 )
						{
							size = parseInt ( size / 1000000 ) + 'M' ;
						}
					}
					else
					{
						size = '－' ;
					}

					//ページ数の生成
					if ( page <= 0 )
					{
						page = '－';
					}

					// 画面表示



					cont += '<dt>' + dateStr + '</dt>' ;
					
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

			if ( cont == '' )
			{
			cont += '<dd class="nodate">ただいま掲載すべき事項はございません。</dd>' ;
			}

			$('#xj-mainlist').append ( cont ) ;
		});
	}

}());