$(function () {
	// ページ内スクロールリンク
	// ---------------------------------------
	$("a[href^=#]").click(function () {
		var speed = 500;
		var href = $(this).attr("href");
		var target = $(href == "#" || href == "" ? "html" : href);
		var position = target.offset().top;
		// 移動先を調整する場合 var position = target.offset().top - 調整値;
		$("html, body").animate({ scrollTop: position }, speed, "swing");
		return false;
	});
});

$(function () {
	// 描画するエリアの大きさ設定
	var w = $("#keyv").width();
	var h = $(".keyv_foot_text").offset().top;
	$("#myCanvas").attr("width", w - 1);
	$("#myCanvas").attr("height", h + 10);

	// 描画する図形、色、初期座標の設定
	let canvas = document.getElementById("myCanvas");
	let ctx = canvas.getContext("2d");
	// 図形が占有する領域(0だと図形中心)
	let ballRadius = 20;
	let color = ["#FFECE2", "#FFEF87", "#FEECBD"];
	let x = [w * 0.2, w * 0.9, w * 0.4];
	let y = [h * 0.3, h * 0.2, h * 0.6];
	let dx = [0.8, -0.4, -0.8];
	let dy = [-1.2, 0.2, 0.4];

	function drawBall1() {
		for (let i = 0; i < x.length; i++) {
			ctx.beginPath();
			// arc(中心x座標, 中心y座標, 半径, 円弧の開始角, 円弧の終了角, 描画の方向)
			ctx.arc(x[i], y[i], w / 10, 0, Math.PI * 2);
			ctx.fillStyle = color[i];
			ctx.fill();
		}
		ctx.closePath();
	}

	function draw() {
		// エリア上の図形を消す
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		// 次の図形を描画
		drawBall1();
		// 画面の端っこか.keyv_foot_textまで到達したら跳ね返るようにする
		for (let i = 0; i < x.length; i++) {
			if (
				x[i] + dx[i] > canvas.width - ballRadius ||
				x[i] + dx[i] < ballRadius
			) {
				dx[i] = -dx[i];
			}
			if (
				y[i] + dy[i] > canvas.height - ballRadius - w / 10 ||
				y[i] + dy[i] < ballRadius
			) {
				dy[i] = -dy[i];
			}

			x[i] += dx[i];
			y[i] += dy[i];
		}
	}

	// PCなどで画面幅が変更された際に描画エリアも変更する
	$(window).resize(function () {
		w = $("#keyv").width();
		h = $(".keyv_foot_text").offset().top;

		$("#myCanvas").attr("width", w - 1);
		$("#myCanvas").attr("height", h + 10);

		x = [w * 0.2, w * 0.8, w * 0.4];
		y = [h * 0.3, h * 0.2, h * 0.6];
		draw();
	});

	setInterval(draw, 10);
});
