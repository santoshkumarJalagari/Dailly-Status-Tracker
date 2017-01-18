<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="javax.swing.text.Document"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.updateToDB.GetPageData"%>
<html>
<head>
	<meta charset="utf-8" />
	<title>Automation Team Status Tracker</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
</head>
<%!

GetPageData pageData=new GetPageData();
List<String> empDetails=null;
List<String> empProject=null;
List<String> empTaskDetails=null;
String pageHeader="";
String selectedEmpName="";
String noRecordFound="";

%>
<%
noRecordFound = (String) request.getAttribute("NODataFound");
System.out.println("NODataFound: "+noRecordFound);
if(noRecordFound=="YES"){
	System.out.println("status: "+noRecordFound);
}
%>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.2.js"></script>
<script type= "text/javascript">

$(document).ready(function () {
	$("#selectProject").change(function() {
	if($(this).data('options') == undefined){
	    /*Taking an array of all options of selectEmpName and kind of embedding it on the selectProject*/
	    $(this).data('options',$('#selectEmpName option').clone());
	    }
	var id = $(this).val();
	var options = $(this).data('options').filter('[value*=' + id + ']');
	$('#selectEmpName').html(options);
	});
	
	
});
</script>
<script type="text/javascript">
	function SetDate()
	{
		var recordFound="<%=noRecordFound%>";
		
		if(recordFound=="YES"){
			document.getElementById("confimationSucessBlock").setAttribute("class", "areaFail");
			document.getElementById("confimationSucessBlock").style["visibility"] = 'visible';
			document.getElementById("confimationSucessBlock").innerHTML ="No Data Found For Selected Inputs"
		}
		var date = new Date();
		var day = date.getDate();
		var month = date.getMonth() + 1;
		var year = date.getFullYear();
		
		if (month < 10) month = "0" + month;
		if (day < 10) day = "0" + day;
		var today = year + "-" + month + "-" + day;
		/* document.getElementById("effortField").value = today; */
		document.getElementById('dateField').innerHtml = today;
		
	}
</script>

<style>

.areaFail { 
  width: 350px; 
  height: 20px; 
  background-color:#ff5b3a; 
  text-align: center;
  font-size: 18px;
  horizontal-align:center;
  margin-left: auto ;
  margin-right: auto ;
  position: center;
}
.linkStype { 
  color: #2da1c1;
  font-size: small;
  text-decoration: none;
  float: right;
}


</style>

<%	
empProject=pageData.getProjectNames();
pageHeader=pageData.getPageHeader();
%>
<body class="blurBg-false" style="background-color:#EBEBEB" onload="SetDate();">

<!-- Start Formoid form-->
<link rel="stylesheet" href="autodeskstatustracker_files/formoid1/formoid-solid-blue.css" type="text/css" />
<div class="linkStype"> <a href="statusTracker.jsp">Record Individual Status</a></div>
<script type="text/javascript" src="autodeskstatustracker_files/formoid1/jquery.min.js"></script>
<div  id= "confimationSucessBlock" style= "visibility :hidden" class="areaSucess">
          <p>Recorded your data Successfully</p>
</div>

<%-- <p id="hiddenPara" name="" style= "visibility :hidden"><%=request.getAttribute("upload_Sucessfull")%></p> --%>

<form class="formoid-solid-blue" action="getDataFromDB" style="background-color:#ffffff;font-size:14px;font-family:'Roboto',Arial,Helvetica,sans-serif;color:#34495E;max-width:480px;min-width:150px" method="post"><div class="title">
<h2><%=pageHeader%></h2></div>
	<div class="element-select" title="Select Project">
	<label class="title"><span class="required"></span></label><div class="item-cont"><div class="medium"><span>
	<select id ="selectProject" name="selectProject" required="required">

		<option value="" selected="true" disabled selected>Select Project</option>
		<%for(int i=0;i<empProject.size();i++){
			System.out.println("Project Names: "+empProject.get(i));
			if(!(empProject.get(i)==null)){	
		%>
			<option value=<%=empProject.get(i).replace(" ", "_")%>><%=empProject.get(i)%>	</option>	
		<%}}%>
		</select><i></i><span class="icon-place"></span></span></div></div></div>
		
	<div class="element-select" title="Select your Name">
	<label class="title"><span class="required"></span></label><div class="item-cont"><div class="medium"><span>
	<select multiple id ="selectEmpName" name="selectEmpName" required="required">

		<option value="" selected="true" disabled selected>Select Name</option>
		<%for(int i=0;i<empProject.size();i++){
			if(!(empProject.get(i)==null)){
				List<String> empNames=pageData.getEmpDetails(empProject.get(i));
				for(int j=0;j<empNames.size();j++){
					if(!(empNames.get(j)==null)){
		%>
			<option value=<%=empProject.get(i).replace(" ", "_")+"-"+empNames.get(j).replace(" ", "_")%>><%=empNames.get(j)%>	</option>	
		<%}}}}%>
		</select multiple><i></i><span class="icon-place"></span></span></div></div></div>
	<div class="element-date"><label class="title"><span class="required"></span></label><div class="item-cont"><input class="large" data-format="yyyy-mm-dd" type="date" name="startDate" required="required" placeholder="Start Date"/><span class="icon-place"></span></div></div>
	<div class="element-date"><label class="title"></label><div class="item-cont"><input class="large" data-format="yyyy-mm-dd" type="date" name="endDate" placeholder="End Date"/><span class="icon-place"></span></div></div>
<div class="submit"><input type="submit" value="Submit"/></div></form><p class="frmd"><a href="http://formoid.com/v29.php">bootstrap form</a> Formoid.com 2.9</p><script type="text/javascript" src="autodeskstatustracker_files/formoid1/formoid-solid-blue.js"></script>

<!-- Stop Formoid form-->



</body>
</html>

