$(document).ready(function(){
	$("#swepimg").click(function() {  
		swep();
	});
	$("#swepimg").addClass("swepimg");
	
})

// 说明：
// oarcont  是展开左边时右侧的CSS
// oarcont2 是隐藏左边时右侧的CSS
function swep(){
	if($("#leftbar").css("display")=="none"){
		$("#swepimg").attr("src","images/icon_marrow3.gif");
		$("#leftbar").css("display","block");
		$("#rightbar").removeClass("oarcont2");
		$("#rightbar").addClass("oarcont");
	}else{
		$("#swepimg").attr("src","images/icon_marrow3c.gif");
		$("#leftbar").css("display","none");
		$("#rightbar").removeClass("oarcont");
		$("#rightbar").addClass("oarcont2");
	}
}

// 左侧菜单栏
function show(c_Str){
	if(document.getElementById(c_Str).style.display=='none'){
		document.getElementById(c_Str).style.display='block';
		document.getElementById("t"+c_Str).className="oalnav_cur";
	}else{
		document.getElementById(c_Str).style.display='none';
		document.getElementById("t"+c_Str).className="oalnav"
	}
}
function high(){
if (this.className=="k"){
this.style.background="316cbd"
this.style.color="white"
}
}
function low(){
if (this.className=="k"){
this.style.background="edf0f8"
this.style.color=""
}
}

// 中间箭头
var currentChoice = true;
arrow1=new Image;
arrow2=new Image;
arrow1.src="images/icon_marrow3.gif";
arrow2.src="images/icon_marrow3c.gif";
function hidFrame(){

	if($("#img1").attr("src") == arrow1.src){
		$("#img1").attr("src", arrow2.src);
		$("#img1").attr("alt", "显示菜单");
		window.parent.document.getElementById("setyou").cols = "0,5,*";
	} else {
		$("#img1").attr("src", arrow1.src);
		$("#img1").attr("alt", "隐藏菜单");
		window.parent.document.getElementById("setyou").cols="168,5,*";
	}
	currentChoice = !currentChoice;
}


//弹出层
function pup(title){
	$("#popMask").css({"display":"","height":document.documentElement.scrollHeight+"px"});
	$("#popBox").css("display","");
	$("#"+title+"").css("display","");
}
//关闭弹出层
function closeLayer(){
document.getElementById("popMask").style.display = "none";
document.getElementById("popBox").style.display = "none";
return false;
}

//弹出层
function pup2(title){
	$("#popMask2").css({"display":"","height":document.documentElement.scrollHeight+"px"});
	$("#popBox2").css("display","");
	$("#"+title+"").css("display","");
}
//关闭弹出层
function closeLayer2(){
document.getElementById("popMask2").style.display = "none";
document.getElementById("popBox2").style.display = "none";
return false;
}

//搜索下拉列表
$(function(){
	$(".xiala").click(function(){
		$(".pupZ").hide();
		$(".clik").removeClass("clikOver");
		$("iframe.yjb_navMask").remove();
		$(this).parent("div").css("position","relative");
		$(this).parents("div").children(".pupZ").show();
		$(this).parents("div").children(".clik").addClass("clikOver");
		$(this).parent("div").append("<iframe class='yjb_navMask' style='position:absolute;top:22px;left:-1px;z-index:8;' frameborder='0' scrolling='no'></iframe>");
		$(this).parents("div").children("iframe.yjb_navMask").width($(this).parents("div").children(".pupZ").outerWidth()); 
		$(this).parents("div").children("iframe.yjb_navMask").height($(this).parents("div").children(".pupZ").outerHeight());
		return false;
	});
	
	$(".pupZ").click(function(e){
		if(e.preventDefault) {
			e.stopPropagation();
		} else {
			e.cancelBubble=true;
		}
	});
	
	$(".pupZ .close").click(function(){
		$(this).parents(".pupZ").hide();
		$(".clik").removeClass("clikOver");
		$(".xiala").parent("div").css("position","static");
		$("iframe.yjb_navMask").remove();
	});
	
	$("html").click(function(e){
		if(e.target.getAttribute("class")!="pupZ" && e.target.getAttribute("class")!="xiala"){
			$(".pupZ").hide();
			$(".clik").removeClass("clikOver");
			$(".xiala").parent("div").css("position","static");
			$("iframe.yjb_navMask").remove();
		}
	});
	
	$(".memberdialog .text").click(function(){
		$(this).hide();
		$(this).parents(".memberdialog").find("div.operate").hide();
		$(this).parents(".memberdialog").find("textarea").show();
		$(this).parents(".memberdialog").find("p.bann").show();
		$(this).parents(".memberdialog").find("textarea").val($(this).find(".trend").html());
	});
	$(".memberdialog .banner2").click(function(){
		$(this).parents(".memberdialog").find("div.text").show();
		$(this).parents(".memberdialog").find("div.operate").show();
		$(this).parents(".memberdialog").find("textarea").hide();
		$(this).parents(".memberdialog").find("p.bann").hide();
		$(this).parents(".memberdialog").find("div.text span.trend").html($(this).parents(".memberdialog").find("textarea").val());
	});
	$(".memberdialog .banner3").click(function(){
		$(this).parents(".memberdialog").find("div.text").show();
		$(this).parents(".memberdialog").find("div.operate").show();
		$(this).parents(".memberdialog").find("textarea").hide();
		$(this).parents(".memberdialog").find("p.bann").hide();
	});
});

//标签切换
$(document).ready(function(){
	
	//// 适用三个的 ///////////////////////////////
	$("#searchtab3").click(function(){
		$("#tab").val(1);
		cutover2('searchtab3','bustab3','drivetab3','fragment-1')					
	})
	
	
	$("#bustab3").click(function(){
		$("#tab").val(2);
		cutover2('bustab3','searchtab3','drivetab3','fragment-2')	
	})
	
	$("#drivetab3").click(function(){
		$("#tab").val(3);
		cutover2('drivetab3','searchtab3','bustab3','fragment-3')	
	})
})

	

//tab切换
function cutover (tabid,infoid){
	$(".lseartop li").removeClass("cur"); 
	$("#"+tabid).addClass("cur");
	
	for(var i = 1; i <=3; i++)
	{
		$("#fragment-"+i).css("display","none");
	}
	$("#"+infoid).css("display","block");
}
function cutover1 (tabid,tabidno,infoid){
	$("#"+tabidno).removeClass("cur"); 
	$("#"+tabid).addClass("cur");
	
	$("#"+tabidno).removeClass("curnav");
	$("#"+tabid).addClass("curnav");


	for(var i = 1; i <=3; i++)
	{
		$("#fragment-"+i).css("display","none");
	}
	$("#"+infoid).css("display","block");
}
function cutover2 (tabid,tabidno,tabidno1,infoid){
	$("#"+tabidno).removeClass("cur"); 
	$("#"+tabidno1).removeClass("cur"); 
	$("#"+tabid).addClass("cur");
	
	$("#"+tabidno).removeClass("curnav");
	$("#"+tabidno1).removeClass("curnav");
	$("#"+tabid).addClass("curnav");


	for(var i = 1; i <=3; i++)
	{
		$("#fragment-"+i).css("display","none");
	}
	$("#"+infoid).css("display","block");
}
