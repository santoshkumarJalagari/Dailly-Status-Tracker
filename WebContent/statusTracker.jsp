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
String checkUpdateConfirmation="";

%>

<%	
checkUpdateConfirmation = (String) request.getAttribute("upload_Sucessfull");
System.out.println("status: "+checkUpdateConfirmation);
if(checkUpdateConfirmation=="YES"){
	System.out.println("status: "+checkUpdateConfirmation);
}
empProject=pageData.getProjectNames();
empDetails=pageData.getEmpDetails("");	
pageHeader=pageData.getPageHeader();
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
<script type= "text/javascript">
$(document).ready(function () {
	$("#selectEmpName").change(function() {
	if($(this).data('options') == undefined){
	    /*Taking an array of all options of selectEmpTask and kind of embedding it on the selectEmpName*/
	    $(this).data('options',$('#selectEmpTask option').clone());
	    } 
	var id = $(this).val();
	var options = $(this).data('options').filter('[value*=' + id + ']');
	$('#selectEmpTask').html(options);
	});
});

$(document).ready(function () {
	$("#selectEmpTask").change(function() {
		hideAllElements();
	    var val = this.options[this.selectedIndex].value;
	    if(val.indexOf("Defect") != -1){
	   		$("#dynamic-defectID").css('display', 'block');
	   		$("#dynamic-defectDec").css('display', 'block');
	   		$("#defectID").attr("required","required");
	   		$("#defectDec").attr("required","required");
	    }else if((val.indexOf("Regression") != -1)|| (val.indexOf("Sanity") != -1) ||  (val.indexOf("Execution") != -1)){
	    	$("#dynamic-totalCount").css('display', 'block');
	    	$("#dynamic-passcount").css('display', 'block');
	    	$("#dynamic-failcount").css('display', 'block');
	    	$("#dynamic-blockcount").css('display', 'block');
	    	$("#totalCount").attr("required","required");
	   		$("#passCount").attr("required","required");
	   		$("#failCount").attr("required","required");
	   		$("#blockCount").attr("required","required");
	    }else if((val.indexOf("Stories_Automation") != -1)){
	    	$("#dynamic-userStory").css('display', 'block');
	    	$("#dynamic-testCaseCount").css('display', 'block');
	    	$("#userStoryNumber").attr("required","required");
	    	$("#testCaseCount").attr("required","required");
	    }else if((val.indexOf("Fixing") != -1) ||  (val.indexOf("Updating") != -1)){
	    	$("#dynamic-fixedTestCaseCount").css('display', 'block');
	    	$("#dynamic-reasonForFixed").css('display', 'block');
	    	$("#updatedTestCaseCount").attr("required","required");
	    	$("#reasonForUpdate").attr("required","required");
	    }else if((val.indexOf("Test_Data_Creation") != -1) ||  (val.indexOf("Adhoc") != -1)){
	    	$("#dynamic-requestFrom").css('display', 'block');
	    	$("#dynamic-textarea").css('display', 'block');
	    	$("#dynamic-status").css('display', 'block');
	    	$("#taskRequestFrom").attr("required","required");
	    	$("#taskDesc").attr("required","required");
	    	$("#taskStatus").attr("required","required");
	    }else if((val.indexOf("Call") != -1) ||  (val.indexOf("Leave") != -1)){
	    	$("#dynamic-textarea").css('display', 'block');
	    	$("#taskDesc").attr("required","required");
	    }else{
	    	$("#dynamic-textarea").css('display', 'block');
	    	$("#dynamic-status").css('display', 'block');
	    	$("#taskDesc").attr("required","required");
	    	$("#taskStatus").attr("required","required");
	    }
	    
		
	});	
});	
</script>

<script type="text/javascript">

	function hideAllElements(){
		var els = document.getElementsByClassName("dynamicElemenet");
		for(i=0;i<els.length;i++){
			els[i].style.display= 'none';
		}
		var searchEles = document.getElementsByTagName("input");
		for(var i = 0; i < searchEles.length; i++) {
			
		    if(searchEles[i].hasAttribute("dynamic")) {
		        searchEles[i].removeAttribute("required");
		    }
		}
		
		searchEles = document.getElementsByTagName("select");
		for(var i = 0; i < searchEles.length; i++) {
			
		    if(searchEles[i].hasAttribute("dynamic")) {
		        searchEles[i].removeAttribute("required");
		    }
		}
		
		searchEles = document.getElementsByTagName("textarea");
		for(var i = 0; i < searchEles.length; i++) {
			
		    if(searchEles[i].hasAttribute("dynamic")) {
		        searchEles[i].removeAttribute("required");
		    }
		}
	}
	function SetDate()
	{
		var checkConfirmation="<%=checkUpdateConfirmation%>";
		
		if(checkConfirmation=="YES"){
			document.getElementById("confimationSucessBlock").setAttribute("class", "areaSucess");
			document.getElementById("confimationSucessBlock").style["visibility"] = 'visible';
			document.getElementById("confimationSucessBlock").innerHTML ="Recorded data successfully"
			
		}else if(checkConfirmation=="NO"){
			document.getElementById("confimationSucessBlock").setAttribute("class", "areaFail");
			document.getElementById("confimationSucessBlock").style["visibility"] = 'visible';
			document.getElementById("confimationSucessBlock").innerHTML ="Fail to record data"
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

<script type="text/javascript">
function validateForm()
{
  var x=document.getElementById("effortField").value;
  if(isNaN(x))
  {
    alert("Effor field must be Integer");
    return false;
  }
}
</script>

<style>
.areaSucess { 
  width: 200px; 
  height: 20px; 
  background-color:#3c60ff; 
  text-align: center;
  font-size: 18px;
  horizontal-align:center;
  margin-left: auto ;
  margin-right: auto ;
  position: center;
}

.areaFail { 
  width: 200px; 
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

<body class="blurBg-false" style="background-color:#EBEBEB" onload="SetDate();">


<div class="linkStype"> <a href="getStatus.jsp">Get Individual Status</a></div>
<!-- Start Formoid form-->
<link rel="stylesheet" href="autodeskstatustracker_files/formoid1/formoid-solid-blue.css" type="text/css" />
<script type="text/javascript" src="autodeskstatustracker_files/formoid1/jquery.min.js"></script>
<div  id= "confimationSucessBlock" style= "visibility :hidden" class="areaSucess">
          <p>Recorded your data Successfully</p>
</div>

<%-- <p id="hiddenPara" name="" style= "visibility :hidden"><%=request.getAttribute("upload_Sucessfull")%></p> --%>
<form class="formoid-solid-blue" name="statusTrackerForm" action="ADDDATA" onsubmit="return validateForm()" style="background-color:#ffffff;font-size:14px;font-family:'Roboto',Arial,Helvetica,sans-serif;color:#34495E;max-width:480px;min-width:150px" method="post"><div class="title">

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
	<select  id ="selectEmpName" name="selectEmpName" required="required">

		<option value="" selected="true" disabled selected>Select Name</option>
		<%for(int i=0;i<empProject.size();i++){
			if(!(empProject.get(i)==null)){
				List<String> empNames=pageData.getEmpDetails(empProject.get(i));
				for(int j=0;j<empNames.size();j++){
					if(!(empNames.get(j)==null)){
		%>
			<option value=<%=empProject.get(i).replace(" ", "_")+"-"+empNames.get(j).replace(" ", "_")%>><%=empNames.get(j)%>	</option>	
		<%}}}}%>
		</select ><i></i><span class="icon-place"></span></span></div></div></div>
		
		
	<div class="element-select" title="Select your Task"><label class="title"><span class="required"></span></label><div class="item-cont"><div class="large"><span>
	<select id ="selectEmpTask" name="selectEmpTask" required="required">
			<option value="" selected="true" disabled selected>Select Task</option>
		<%for(int i=0;i<empProject.size();i++){
			List<String> empNames=pageData.getEmpDetails(empProject.get(i));
			for(int j=0;j<empNames.size();j++){
				if(!(empNames.get(j)==null)){
					List<String> empTaskDetails=pageData.getEmpTaskDetails(empNames.get(j));
					for(int k=0;k<empTaskDetails.size();k++){	
						if(!(empTaskDetails.get(k)==null)){
					
		%>
			<option value=<%=empProject.get(i).replace(" ", "_")+"-"+empNames.get(j).replace(" ", "_")+":"+empTaskDetails.get(k).replace(" ", "_")%> ><%=empTaskDetails.get(k)%>	</option>	
		<%}}}}}%>
	</select><i></i><span class="icon-place"></span></span></div></div></div>
	<div id="dynamiclyChangingEle"> 
		<!-- Defect Related -->
		<lable></lable> <div id ="dynamic-defectID" class="dynamicElemenet" style="display: none"><label class="title"><span class="required"></span></label><div class="item-cont"><input  dynamic="yes" class="small" id="defectID" name='defectID'   type="text" placeholder="Defect ID"/><span class="icon-place"></span></div></div>
		 <div id ="dynamic-defectDec" class="dynamicElemenet" style="display: none"><label class="title"><span class="required"></span></label><div class="item-cont"><input dynamic="yes" class="large" id="defectDec" name='defectDec' type="text"  placeholder="Defect Description"/><span class="icon-place"></span></div></div>
		
		<!-- Execution Related -->
		 <div id ="dynamic-totalCount" class="dynamicElemenet" style="display: none"><label class="title"><span class="required"></span></label><div class="item-cont"><input  dynamic="yes" class="medium" id="totalCount" name='totalCount'   type="text" placeholder="Total Count" /><span class="icon-place"></span></div></div>
		 <div id ="dynamic-passcount" class="dynamicElemenet" style="display: none"><label class="title"><span class="required"></span></label><div class="item-cont"><input dynamic="yes" class="medium" id="passCount" name='passCount'   type="text"  placeholder="Pass Count"/><span class="icon-place"></span></div></div>
		 <div id ="dynamic-failcount" class="dynamicElemenet" style="display: none"><label class="title"><span class="required"></span></label><div class="item-cont"><input dynamic="yes" class="medium" id="failCount" name='failCount'  type="text"  placeholder="Fail Count"/><span class="icon-place"></span></div></div>
		 <div id ="dynamic-blockcount" class="dynamicElemenet" style="display: none"><label class="title"><span class="required"></span></label><div class="item-cont"><input dynamic="yes" class="medium" id="blockCount" name='blockCount'   type="text"  placeholder="Block Count"/><span class="icon-place"></span></div></div>
		
		<!-- Automation Related-->
		<div id ="dynamic-userStory" class="dynamicElemenet" style="display: none"><label class="title"><span class="required"></span></label><div class="item-cont"><input  dynamic="yes" class="medium" id="userStoryNumber" name='userStoryNumber'  type="text" placeholder="User Story Number"/><span class="icon-place"></span></div></div>
		 <div id ="dynamic-testCaseCount" class="dynamicElemenet" style="display: none"><label class="title"><span class="required"></span></label><div class="item-cont"><input dynamic="yes" class="medium" id="testCaseCount" name='testCaseCount'   type="text" placeholder="Test Case Count"/><span class="icon-place"></span></div></div>
		 
		 <!-- Fixing/Updating test cases Related -->
		<div id ="dynamic-fixedTestCaseCount" class="dynamicElemenet" style="display: none"><label class="title"><span class="required"></span></label><div class="item-cont"><input  dynamic="yes" class="medium" id="updatedTestCaseCount" name='updatedTestCaseCount'  type="text" placeholder="Updated Test Case Count"/><span class="icon-place"></span></div></div>
		<div id ="dynamic-reasonForFixed" class="dynamicElemenet" style="display: none"><label class="title"><span class="required"></span></label><div class="item-cont"><input  dynamic="yes" class="large" id="reasonForUpdate" name='reasonForUpdate' type="text" placeholder="Reason"/><span class="icon-place"></span></div></div>
		<div id ="dynamic-requestFrom" class="dynamicElemenet" style="display: none"><label class="title"><span class="required"></span></label><div class="item-cont"><input  dynamic="yes" class="medium" id="taskRequestFrom" name='taskRequestFrom'  type="text" placeholder="Task Request From"/><span class="icon-place"></span></div></div>
		<div id ="dynamic-textarea" class="dynamicElemenet" style="display: none" ><label class="title"><span class="required"></span></label><div class="item-cont"><textarea dynamic="yes" class="medium" id="taskDesc" name="taskDesc" cols="20" rows="5"  placeholder="Task Description"></textarea><span class="icon-place"></span></div></div>
		<div id ="dynamic-status" class="dynamicElemenet" title="Select your Task" style="display: none"><label class="title"><span class="required"></span></label><div class="item-cont"><div class="medium"><span>
		<select id ="taskStatus" name="taskStatus" required="required" dynamic="yes">
			<option value="In Progress" selected="true" selected>In Progress</option>
			<option value="Completed" >Completed</option>
		</select><i></i><span class="icon-place"></span></span></div></div></div>
	
	</div>
	<div class="element-date"><label class="title"><span class="required"></span></label><div class="item-cont"><input class="large" id="dateField" required="required" name='taskDate' data-format="yyyy-mm-dd" type="date" name="dateFiled" placeholder="Date"/><span class="icon-place"></span></div></div>
	<div class="element-input"><label class="title"><span class="required"></span></label><div class="item-cont"><input class="large" id="effortField" name='taskEffort' required="required"  type="text" name="effort" placeholder="Effor in hours"/><span class="icon-place"></span></div></div>
	
<div class="submit"><input type="submit" value="Submit"/></div></form><p class="frmd"><a href="http://formoid.com/v29.php">bootstrap form</a> Formoid.com 2.9</p><script type="text/javascript" src="autodeskstatustracker_files/formoid1/formoid-solid-blue.js"></script>

<!-- Stop Formoid form-->



</body>
</html>

