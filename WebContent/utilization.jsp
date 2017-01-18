<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="javax.swing.text.Document"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.updateToDB.GetPageData"%>
<html>
<head>
	<meta charset="utf-8" />
	<title>UtilizationReport</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
</head>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.2.js"></script>
<html>
	<head>
		<%!

		GetPageData pageData=new GetPageData();
		List<String> empDetails=null;
		List<String> empTaskDetails=null;
		String pageHeader="";
		String selectedEmpName="";
		String checkUpdateConfirmation="";
		
		%>
		<%	
			empDetails=pageData.getEmpDetails("");	
			
		%>
		<title>Utilization Report</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<style type="text/css">
		body{
			margin: 20px;
			padding: 0;
			overflow: hidden;
			height: 100%; 
			max-height: 100%; 
			font-family:Sans-serif;
			line-height: 1.5em;
		}
		nav{
			position: fixed;
			top: 0;
			bottom: 400px; 
			left: 0;
			width: 100%; /* Width of navigation frame */
			height: 10%;
			overflow: visible; /* Disables scrollbars on the navigation frame. To enable scrollbars, change "hidden" to "scroll" */
			background: #eee;
			border: 2px solid gray;
			display:inline;
		}
		chat{
			position: fixed;
			top: 260px;
			bottom: 0; 
			left: 0;
			width: 500px; /* Width of navigation frame */
			overflow: auto; /* Disables scrollbars on the navigation frame. To enable scrollbars, change "hidden" to "scroll" */
			background: #eee;
			border: 2px solid gray
		}
		
		main{
			position: fixed;
			top: 10%; 
			left: 0; /* Set this to the width of the navigation frame */
			right: 0;
			bottom: 0;
			overflow: auto; 
			background: #fff;
			border: 2px solid gray
		}
		.banner{
			margin-top: 15px
			margin-left: 10px;
		    margin-right: 10px;
		    text-align: center;
			vertical-align: center;
		}
		
		</style>
		
				
		<script type= "text/javascript">
			function updateDateType(){
				var option=document.getElementById("selectPeriod").value;
				document.getElementById("UtlizationPeriod").setAttribute("type", option);
			}
		</script>
		<script type="text/javascript">
		 function updateData(){
			 
			 alert(document.getElementsByName("weekDate").prototype);
		 }
		</script>
		<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	    <script type="text/javascript">
	      google.load("visualization", "1", {packages:["corechart"]});
	      google.setOnLoadCallback(drawChart);
	      function drawChart() {
	        var data = google.visualization.arrayToDataTable([
	          ['Pac Man', 'Percentage'],
	          ['Santosh Kumar Jalagari ', 33.33],
	          ['Pooraj NA', 33.33],
			  ['Ragavendra G ', 33.33],
			  
	        ]);var options = {legend: 'none',pieSliceText: 'label',pieStartAngle: 135,tooltip: { trigger: 'none' },slices: {
	            0: { color: 'green' },
	            1: { color: 'green' },
				2: { color: 'red' }
	          }};var chart = new google.visualization.PieChart(document.getElementById('pacman'));chart.draw(data, options);}</script>
	</head>
	
	<body class="blurBg-false" style="background-color:#EBEBEB"">	
			
	<!-- Start Formoid form-->
<link rel="stylesheet" href="autodeskstatustracker_files/formoid1/formoid-solid-blue.css" type="text/css" />
<script type="text/javascript" src="autodeskstatustracker_files/formoid1/jquery.min.js"></script>
		<main>
			<div class="innertube">
				<table><tr><td style = 'height:300;width:400;vertical-align:top;'><table><tr valign='top' height='1'><td style = 'height:300;width:375;vertical-align:top;'><table><tr><td>
											<table cellspacing=3 cellpadding=3   border=0>    
												<tr><h1><FONT COLOR='660000' FACE='Arial' SIZE=3></h1>
												  <td width=150 align='left' bgcolor='#a6caf0'><FONT FACE='Arial' SIZE=2.75><b>Project</b></td>
												  <td width=150 align='left' bgcolor='#eeeee0'><FONT FACE='Arial' SIZE=2.75>Autodesk</td>
												</tr>
												<tr  border=1>
													  <td width=150 align='left' bgcolor='#a6caf0'><FONT FACE='Arial' SIZE=2.75><b>Selected Name</b></td>
													  <td width=150 align='left' bgcolor='#eeeee0'><FONT FACE='Arial' SIZE=2.75>All</td>
												</tr>
												<tr  border=1>
													<td width=150 align='left' bgcolor='#a6caf0'><FONT FACE='Arial' SIZE=2.75><b>Time </b></td>      
													<td width=150 align='left' bgcolor='#eeeee0'><FONT FACE='Arial' SIZE=2.75></td>
												</tr>
											</table>
										</td></tr><tr><td><p> </p></td></tr><tr><td><p> </p></td></tr><tr><td>
										
											<table border=0 cellspacing=3 cellpadding=3 >
												<tr> 
												<th width=80  align='center' bgcolor='#a6caf0'><FONT FACE='Arial' SIZE=2><b>S.No#</b></th>
												<th width=200 align='center' bgcolor='#a6caf0'><FONT FACE='Arial' SIZE=2><b>Associate Name</b></th>
												<th width=75 align='center' bgcolor='#a6caf0'><FONT FACE='Arial' SIZE=2><b>BL%</b></th>
												<th width=75 align='center' bgcolor='#a6caf0'><FONT FACE='Arial' SIZE=2><b>NBL%</b></th>
												</tr>
												<tr>
															<td width=80 align='center' bgcolor='#eeeee0'><FONT FACE='Arial' SIZE=2>1</td>
															<td width=75 align='center' bgcolor=#eeeee0><FONT FACE='Arial' SIZE=2>Santosh Kumar Jalagari</td>
															<td width=80 align='center' bgcolor='green'><FONT FACE='Arial' SIZE=2>95%</td>
															<td width=100 align='center' bgcolor='#eeeee0'><FONT FACE='Arial' SIZE=2>5%</td>
												</tr>  
												<tr>
															<td width=80 align='center' bgcolor='#eeeee0'><FONT FACE='Arial' SIZE=2>1</td>
															<td width=75 align='center' bgcolor=#eeeee0><FONT FACE='Arial' SIZE=2>Pooraj NA</td>
															<td width=80 align='center' bgcolor='green'><FONT FACE='Arial' SIZE=2>95%</td>
															<td width=100 align='center' bgcolor='#eeeee0'><FONT FACE='Arial' SIZE=2>5%</td>
												</tr> 
												<tr>
															<td width=80 align='center' bgcolor='#eeeee0'><FONT FACE='Arial' SIZE=2>1</td>
															<td width=75 align='center' bgcolor=#eeeee0><FONT FACE='Arial' SIZE=2>Raghavendra G</td>
															<td width=80 align='center' bgcolor='green'><FONT FACE='Arial' SIZE=2>95%</td>
															<td width=100 align='center' bgcolor='#eeeee0'><FONT FACE='Arial' SIZE=2>5%</td>
												</tr> 
																					
												
											</table></td></tr></table></td></table></td><td><div id="pacman" style="width: 900px; height: 500px;"></div></td></tr></table>
			</div>
		</main>	
	
		<nav id="nav">
		<form class="formoid-solid-blue" onsubmit="return updateData()" style="display:-webkit-inline-box;box-shadow: 0 0px 0px rgba(0, 0, 0, 0.65) ;font-size:14px;font-family:'Roboto',Arial,Helvetica,sans-serif;color:#34495E;max-width:450px;min-width:120px" method="post">

			<div class="element-select" style="width:40%" title="Select your Name"><label class="title"><span class="required"></span></label><div class="item-cont"><div class="medium" style="width:inherit"><span>
			<select  id ="selectEmpName" name="selectEmpName" required="required" placeholder="Select Project Test" >
		
				<option value="" selected="true" disabled selected>Select Project Test</option>
				<option value="Select Name" >Autodesk</option>
				<option value="Select Name" >Select Name</option>
				<option value="Select Name" >Select Name</option>
				
				</select><i></i><span class="icon-place"></span></span></div></div></div>
				<div class="element-select" style="width:40%" title="Select your Name"><label class="title"><span class="required"></span></label><div class="item-cont"><div class="medium" style="width:inherit" ><span>
				<select  multiple id ="selectEmpName" name="selectEmpName" required="required">
		
					<option value="" selected="true" disabled selected>Select Name</option>
					<%for(int i=0;i<empDetails.size();i++){
						System.out.println("Emp Names: "+empDetails.get(i));
						if(!(empDetails.get(i)==null)){	
					%>
						<option value=<%=empDetails.get(i).replace(" ", "_")%>><%=empDetails.get(i)%>	</option>	
					<%}}%>
				
				</select multiple><i></i><span class="icon-place"></span></span></div></div></div>
				
			</select><i></i><span class="icon-place"></span></span></div></div></div>
					<div class="element-select" style="width:40%" title="Select your Name"><label class="title"><span class="required"></span></label><div class="item-cont"><div class="medium" style="width:inherit" ><span>
					<select  onchange="updateDateType()" id ="selectPeriod" name="selectPeriod" required="required">
			
					<option value="Select Name" selected="true" disabled selected>Data By</option>
					<option value="date" >Date</option>
					<option value="week" >Week</option>
					<option value="month" >Month</option>
					
					
				</select ><i></i><span class="icon-place"></span></span></div></div></div>
			<div class="element-week"><label class="title"><span class="required"></span></label><div class="item-cont"><input class="large" id="UtlizationPeriod" data-format="yyyy-mm-dd" type="month" name="startDate" required="required" placeholder="Start Date" style="
			    text-align: left;
			    border: 0;
			    cursor: pointer;
			    width: 100%;
			    height: 100%;
			    padding: 5px 10px 9px 2.3em;
			    outline: none;
			    -webkit-transition: 0.5s;
			    transition: 0.5s;
			    -o-box-sizing: border-box;
			    box-sizing: border-box;
			    -webkit-appearance: none;
			    -moz-appearance: none;
			    appearance: normal;
			    border-radius: 3px;
			    border: 2px solid #BDC3C7;
			    background-color: #fff;
			    font-size: 1em;
" /><span class="icon-place"></span></div></div>
		<div class="submittemp"><input type="submit" value="Submit"/></div>
		</form><p class="frmd"><a href="http://formoid.com/v29.php">bootstrap form</a> Formoid.com 2.9</p><script type="text/javascript" src="autodeskstatustracker_files/formoid1/formoid-solid-blue.js"></script>

				
			
		</nav>
		
		
		
		
	
