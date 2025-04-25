<<<<<<< .mine
$(function() {    
    // ページ内スクロールリンク
    // ---------------------------------------
    $('a[href^=#]').click(function(){
		var speed = 500;
		var href= $(this).attr("href");
		var target = $(href == "#" || href == "" ? 'html' : href);
		var position = target.offset().top;
		// 移動先を調整する場合 var position = target.offset().top - 調整値;
		$("html, body").animate({scrollTop:position}, speed, "swing");
		return false;
	});
});||||||| .r4174
$(function () {
	var w = $("#keyv").width();

	var h = $(".keyv_foot_text").offset().top;
	$("#myCanvas").attr("width", w);
	$("#myCanvas").attr("height", h);

	let canvas = document.getElementById("myCanvas");
	let ctx = canvas.getContext("2d");
	let ballRadius = 20;

	let color = ["#FFECE2", "#FFEF87", "#FEECBD"];
	let x = [canvas.width / 2, canvas.width / 8, canvas.width / 4];
	let y = [canvas.height / 3, canvas.height / 2, canvas.height / 8];
	let dx = [0.6, -0.3, 0.5];
	let dy = [-0.4, 0.5, 0.2];

	function drawBall1() {
		for (let i = 0; i < x.length; i++) {
			ctx.beginPath();
			ctx.arc(x[i], y[i], h / 10, 0, Math.PI * 2);
			ctx.fillStyle = color[i];
			ctx.fill();
		}
		ctx.closePath();
	}

	function draw() {
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		drawBall1();
		for (let i = 0; i < x.length; i++) {
			if (x[i] + dx[i] > canvas.width - ballRadius || x[i] + dx[i] < ballRadius) {
				dx[i] = -dx[i];
			}
			if (
				y[i] + dy[i] > canvas.height - ballRadius - 60 ||
				y[i] + dy[i] < ballRadius
			) {
				dy[i] = -dy[i];
			}

			x[i] += dx[i];
			y[i] += dy[i];
		}
	}

	setInterval(draw, 10);
});
=======
$(function () {
	var w = $("#keyv").width();
	var h = $(".keyv_foot_text").offset().top;
	$("#myCanvas").attr("width", w - 1);
	$("#myCanvas").attr("height", h + 10);

	let canvas = document.getElementById("myCanvas");
	let ctx = canvas.getContext("2d");
	let ballRadius = 20;
	let color = ["#FFECE2", "#FFEF87", "#FEECBD"];
	let x = [w * 0.2, w * 0.9, w * 0.4];
	let y = [h * 0.3, h * 0.2, h * 0.6];
	let dx = [0.8, -0.4, -0.8];
	let dy = [-1.2, 0.2, 0.4];

	function drawBall1() {
		for (let i = 0; i < x.length; i++) {
			ctx.beginPath();
			ctx.arc(x[i], y[i], w / 10, 0, Math.PI * 2);
			ctx.fillStyle = color[i];
			ctx.fill();
		}
		ctx.closePath();
	}

	function draw() {
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		drawBall1();
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
>>>>>>> .r4216
