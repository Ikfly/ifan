/*---------------------------- Ajax 请求对象 ----------------------------*/
		
/**************************************************
 -- 属性：
	 url: 请求地址；
	 method: 请求方法（GET 或者 POST），默认为 GET；
	 flag: 异步或者同步请求（true 或者 false），默认为 true；
	 info: 请求参数，默认为 null，注：只有当请求方法为 POST 时，才被使用；
	 //isEval: 是否调用 eval() 函数（true 或者 false），默认为为 false；
	 //callback: 是否设置回调函数（true或者false），默认为 true;
	 result: Ajax 请求的响应结果
 
 -- 方法：
	 executeRequest: 执行 Ajax 请求的方法；
	 onReady: 绑定函数到 req.onreadystatechange 事件；
	 dealResult: 只提供了函数名称，用来设置用户自己的函数。注：在用户自己的函数中，用来处理 Ajax 请求的返回结果。
**************************************************/
function Ajax(url, method, flag, info) {
	this.url = url;
	this.method = method || "GET";
	this.flag = (flag === false) ? false : (flag || true);
	this.info = info || null;
	//this.isEval = false;
	//this.callback = true;
	this.result = null;
	var req = null;	 // req: XMLHttpRequest 对象；
	
	// 实例化 req 对象
	(function() {
		if (window.XMLHttpRequest) {
			req = new XMLHttpRequest();
			if (req.overrideMimeType) {
				// 针对某些特定版本的 Mozilla 浏览器的 BUG 进行修正，保证浏览器发送的串行化数据长度正确。
				// MIME 类型就是设定某种扩展名的文件用一种应用程序来打开的方式类型，当该扩展名文件被访问的时候，浏览器会自动使用指定应用程序来打开。
				//req.overrideMimeType("text/xml");
			}
		} else if (window.ActiveXObject) {
			try {
				req = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					req = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					alert("该浏览器不支持 Ajax ！");
					req = null;
				}
			}
			
			/* Msxml2.XMLHTTP.5.0, 4.0, 3.0 都可以，2.0 和 1.0 不可以
			for (var i = 5; i; i--) {
				try {
					alert(i);
					if (i != 2) {
						req = new ActiveXObject("Msxml2.XMLHTTP." + i + ".0");
					}
					
				} catch (e) {
					alert(e);
					continue;
				}
			}*/
		}
	}());
	this.executeRequest = function () {
		if (!req || !this.url) {
			alert("Ajax 对象为空或者 url 为空！");
			return;
		}
		
		
		// 保证每次请求的 URL 都不一样，防止缓存
		if (this.url.indexOf("_id_=") != -1) {
			// 不改变
		} else {
			var rand = "_id_=" + Math.random();
			if (this.url.indexOf("?") != -1) {
				this.url += "&" + rand;
			} else {
				this.url += "?" + rand;
			}
		}
		
		/*// 判断，是否设置回调函数
		if (this.callback) {
			this.onReady(req);
		}*/
		
		// 调用函数（该函数在后面回调设置）
		this.onReady(this);
		// 初始化 req 对象
		req.open(this.method, this.url, this.flag);
		
		// 判断，是否为 POST 请求
		if ((this.method.toUpperCase() == "POST") && this.info) {
			req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		}
		// 向服务器端发送请求
		req.send(this.info);
		
		/*// 判断，是否执行 eval() 函数
		if (this.isEval) {
			eval(req.responseText);
		}*/
	};
	
	// 设置回调函数
	this.onReady = function (ajax) {
		req.onreadystatechange = function () {
			//alert("onReady()" + req.readyState);
			if (req.readyState == 4) {
				var result = req.responseText;
				if (req.status == 200) {
					ajax.result = result;
					//alert(ajax.dealResult);
					if (ajax.dealResult) {
						ajax.dealResult(result);
					} else {
						var message = "请为 Ajax对象的 dealResult 设置回调函数！";
						message += "\r\n例如：Ajax对象.dealResult=function(result) { Your Code }";
						message += "\r\n其中，result 参数为服务器端返回的响应数据。";
						alert(message);
					}
				} else {
					//alert("响应错误！");
					//alert(result);
				}
			}
		};
	};
	
	this.dealResult;	// = function(result) { };
}
