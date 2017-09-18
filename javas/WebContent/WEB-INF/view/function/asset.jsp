<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<html>
<head>
<title>Insert title here</title>
<style>
th {
	background-color: lightgray;
	padding-left: 5px;
}
td {
	border-bottom: 1px solid lightgray;
	padding-left: 15px;
	padding-right: 7px;
}
</style>
</head>
<body>
<div class="row" style="margin-top: 20px;">
<div class="col-md-3 col-sm-3" style="padding: 0;">

<button id="back" style="background-color: white; border: 0; height: 22px; width: 22px;"><i class="fa fa-angle-left" style="font-size: 22px;"></i></button>
<span id="date" style="font-size: 22px;"></span>
<button id="front" style="background-color: white; border: 0; height: 22px; width: 22px;"><i class="fa fa-angle-right" style="font-size: 22px;"></i></button>

<table id=list style="width: 90%; margin-top: 15px; margin-left: 12px;"></table>
</div>
<div class="col-md-1 col-sm-1"></div>
<div class="col-md-4 col-sm-4" id="piechart" style="width: 600px; height: 350px; position: absolute; top: 175px; left: 550px;"></div>
<div class="col-md-4 col-sm-4" id="piechart2" style="width: 600px; height: 350px; position: absolute; top: 175px; left: 1000px;"></div>
</div>
</body>
</html>
<script>
	var today = new Date();
	var month = today.getMonth()+1 >= 10 ? today.getMonth()+1 : "0"+(today.getMonth()+1);
	var year = today.getYear();
	var first = String(year).substring(1)+"/"+month+"/"+"01";
	var last = String(year).substring(1)+"/"+month+"/"+new Date(year, month, 0).getDate();
	var date = first + " ~ " + last;
	
	$("#date").html(date);
	$("#back").click(function(){
		month = month-1 >= 10 ? month-1 : "0"+(month-1);
		if(month == 00) {
			month = 12;
			year -= 1;
		}
		
		var first = String(year).substring(1)+"/"+month+"/"+"01";
		var last = String(year).substring(1)+"/"+month+"/"+new Date(year, month, 0).getDate();
		var date = first + " ~ " + last;
		$("#date").html(date);
		getAsset(first, last);
	});
	$("#front").click(function(){
		month *= 1;
		month = month+1 >= 10 ? month+1 : "0"+(month+1); 
		if(month == 13) {
			month = "01";
			year += 1;
		}
		var first = String(year).substring(1)+"/"+month+"/"+"01";
		var last = String(year).substring(1)+"/"+month+"/"+new Date(year, month, 0).getDate();
		var date = first + " ~ " + last;
		$("#date").html(date);
		getAsset(first, last);
	});
	var week = new Array(' (일)', ' (월)', ' (화)', ' (수)', ' (목)', ' (금)', ' (토)');
	var getAsset = function(first, last) {
		$.ajax({
			url : "/function/assetListAjax.jv",
			data : {
				"first" : first,
				"last" : last
			}
		}).done(function(rst){
			var list = "";
			var income = 0;
			var expense = 0;
			if(rst.length == 0) {
				list += "<tr><td colspan=\"2\" style=\"border: 0; text-align: center; color: gray;\">소비/지출 내역이 없습니다.</td></tr>"
			}else {
			for(var i=0; i<rst.length; i++) {
				income += rst[i].INCOME;
				expense += rst[i].EXPENSE;
				var adate = new Date(rst[i].ADATE);
				var lday = (adate.getMonth()+1) + "월 " + adate.getDate() +"일" + week[adate.getDay()];
				if(i == 0 || (rst[i].ADATE != rst[i-1].ADATE)) {
					list += "<tr><th colspan=\"2\" style=\"text-align: left;\">"+lday+"</th></tr>";
				}
				if(rst[i].INCOME != 0) {
					list += "<tr><td style=\"text-align: left; color: gray;\">"+rst[i].ICONTENT+"</td>"
						 + "<td style=\"text-align: right; color: blue;\">"+rst[i].INCOME.format()+"</td></tr>";
				}
				if(rst[i].EXPENSE != 0) {
					list += "<tr><td style=\"text-align: left; color: gray;\">"+rst[i].ECONTENT+"</td>"
						 + "<td style=\"text-align: right; color: red;\">"+rst[i].EXPENSE.format()+"</td></tr>";
				}
			}
				list += "<tr><td style=\"text-align: left; border-top: 2px solid black; font-weight: 700;\">"
					 + "월수입</td><td style=\"text-align: right; color: blue; font-weight: 700;" 
					 + "border-top: 2px solid black;\">"
					 + income.format()+"</td></tr>";
				list += "<tr><td style=\"text-align: left; border-top: 2px solid black; font-weight: 700;\">"
					 + "월지출</td><td style=\"text-align: right; color: red; font-weight: 700;" 
					 + "border-top: 2px solid black;\">"
					 + expense.format()+"</td></tr>";
				list += "<tr><td style=\"text-align: left; border-top: 2px solid black; border-bottom: 0; font-weight: 700;\">"
				     + "잔액</td><td style=\"text-align: right; color: ";
				     
				     if((income-expense) >= 0) {
				    	 list += "green";
				     }else {
				    	 list += "orange";
				     }
					 list += "; font-weight: 700; border-top: 2px solid black; border-bottom: 0;\">"
					 + (income-expense).format()+"</td></tr>";
				}
			$("#list").html(list);
		});
	}
	Number.prototype.format = function(){
	    if(this==0) return 0;
	 
	    var reg = /(^[+-]?\d+)(\d{3})/;
	    var n = (this + '');
	 
	    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
	 
	    return n;
	};
	
	String.prototype.format = function(){
	    var num = parseFloat(this);
	    if( isNaN(num) ) return "0";
	 
	    return num.format();
	};
	
	getAsset(first, last);
	
	google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var data = google.visualization.arrayToDataTable([
        ['Task', 'Hours per Day'],
        ['Work',     11],
        ['Eat',      2],
        ['Commute',  2],
        ['Watch TV', 2],
        ['Sleep',    7]
      ]);

      var options = {
        title: '지출현황',
        pieHole: 0.5,
        titleTextStyle : {
        	fontSize: 24,
        	bold: false
        	
        }
      };

      var chart = new google.visualization.PieChart(document.getElementById('piechart'));
      var chart2 = new google.visualization.PieChart(document.getElementById('piechart2'));
      chart.draw(data, options);
      chart2.draw(data, options);
    }
</script>	