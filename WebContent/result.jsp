<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="javax.swing.text.Document"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.updateToDB.GetPageData"%>
<html>
<head>
<meta charset="ISO-8859-1">
<style type="text/css">
.myTable { width:400px;background-color:#eee;border-collapse:collapse; }
.myTable th { background-color:#427eff;color:white;width:50%; }
.myTable td, .myTable th { padding:5px;border:2px solid #000; }
</style>
<style>
  html, body {
    height: 100%;
  }
  #tableContainer-1 {
    height: 100%;
    width: 100%;
    display: table;
  }
  #tableContainer-2 {
    vertical-align: middle;
    horzontal-align: middle;
    display: table-cell;
    height: 100%;
  }
  #myTable {
    margin: 2 auto;
  }
  
</style>
<style>

.linkStype { 
  color: #2da1c1;
  font-size: small;
  text-decoration: none;
  float: right;
}


</style>
<title >Individual Status</title>
</head>
<%!

ArrayList<Map<String,String>> empStatusRecords=null;
String empName="";
String startDate="";
String endDate="";
int totalDefectCount=0;
int totalAutomatedTCCount=0;
int sNo=0;
int totalAutomatedTCCountReworked=0;

%>
<%
empStatusRecords = (ArrayList<Map<String,String>>) request.getAttribute("statusDetails");
startDate = (String) request.getAttribute("startDate");
endDate = (String) request.getAttribute("endDate");
empName = (String) request.getAttribute("empName");

%>
<body>
    <h5 align="center"><FONT FACE="Arial" SIZE="4"> Status Report </h5>
    <div class="linkStype"> <a href="statusTracker.jsp">Record Individual Status</a></div><br>
    <div class="linkStype"> <a href="getStatus.jsp">Get Individual Status</a></div>
    
    <table border=0 cellspacing=3 cellpadding=3>
        <tr>
            <h4> <FONT COLOR="660000" FACE="Arial" SIZE=3> General Details :</h4>
            <td width=150 align="left" bgcolor="#a6caf0">
			    <FONT FACE="Arial" SIZE=2.75><b>Data of</b></td> <td width=150 align="left" bgcolor="#eeeee0">
				<FONT FACE="Arial" SIZE=2.75><%=empName %></td></tr><td width=150 align="left" bgcolor="#a6caf0">
                <FONT FACE="Arial" SIZE=2.75><b>From Date</b></td> <td width=150 align="left" bgcolor="#eeeee0">
				<FONT FACE="Arial" SIZE=2.75><%=startDate %></td></tr><td width=150 align="left" bgcolor="#a6caf0">
				<FONT FACE="Arial" SIZE=2.75><b>To Date</b></td><td width=150 align="left" bgcolor="#eeeee0">
				<FONT FACE="Arial" SIZE=2.75><%=endDate %></td></tr>
			</td>
		</tr>
	</table>
	<table style="overflow: hidden;">
	<tr>
		<td style=" vertical-align: top; text-align: left; width: 700px">
			<h4><FONT COLOR="660000" FACE="Arial" SIZE=3> Defects Raised :</h4>
			<table  border=0 cellspacing=3 cellpadding=3 >
			<tr>
				<td width=80  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>S.No</b></td>
				<td width=100  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Date</b></td>
				<td width=120  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Associate</b></td>
				<td width=80 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Defect ID</b></td>
				<td width=200 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Defect Description</b></td>
				<td width=80  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Status</b></td>
			</tr>
			
			<%totalDefectCount=0; sNo=0;
				for(int i=0;i<empStatusRecords.size();i++){
				if(empStatusRecords.get(i).get("taskAssigned").toUpperCase().contains("DEFECT")){
				totalDefectCount++;sNo++;
			%>
			
				<tr>
					<td width=80 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=sNo %></td>
					<td width=100 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskDate") %></td>
					<td width=120 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("empNameFromDB") %></td>
					<td width=80 align="center" bgcolor="#eeeee0" ><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("defectID") %></td>
					<td width=300 align="center" bgcolor="#eeeee0" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("defectDesc") %></td>
					<td width=80 align="center" bgcolor="#eeeee0" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><%="NA" %></td>
				</tr>
			<%}}%>
			<tr >
					<td colspan="5" width=200 align="center" bgcolor="#A0A1A2" ><FONT COLOR="660000" FACE="Arial" SIZE=2><b>Total Defect Raised</b></td>
					<td width=200 align="center" bgcolor="#A0A1A2" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><b><%=totalDefectCount %></b></td>	
			</tr>	
			</table>
			
		</td>
		<td style="padding-right: 50px;"></td>
	
		<td style=" vertical-align: top; text-align: left; width: 700px">
			<h4><FONT COLOR="660000" FACE="Arial" SIZE=3> Automation Details :</h4>
			<table  border=0 cellspacing=3 cellpadding=3 >
			<tr>
				<td width=80  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>S.No</b></td>
				<td width=100  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Date</b></td>
				<td width=120  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Associate</b></td>
				<td width=300 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Task Shot Description</b></td>
				<td width=100 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>User Story</b></td>
				<td width=80  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Test Case Count</b></td>
			</tr>
			
			<% totalAutomatedTCCount=0; sNo=0;
			for(int i=0;i<empStatusRecords.size();i++){	
				if(empStatusRecords.get(i).get("taskAssigned").toUpperCase().contains("AUTOMATION")){
				totalAutomatedTCCount=totalAutomatedTCCount+Integer.valueOf(empStatusRecords.get(i).get("testCaseCount"));
				sNo++;
			%>
				<tr>
					<td width=80 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=sNo %></td>
					<td width=100 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskDate") %></td>
					<td width=120 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("empNameFromDB") %></td>
					<td width=300 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskAssigned") %></td>
					<td width=80 align="center" bgcolor="#eeeee0" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("automatedUserStoryNumber") %></td>
					<td width=80 align="center" bgcolor="#eeeee0" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("testCaseCount") %></td>
				</tr>
			<%}}%>
				<tr >
					<td colspan="5" width=200 align="center" bgcolor="#A0A1A2" ><FONT COLOR="660000" FACE="Arial" SIZE=2><b>Total No. of Test Cases Automated</b></td>
					<td width=200 align="center" bgcolor="#A0A1A2" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><b><%=totalAutomatedTCCount%></b></td>
				</tr>
			</table>
		<td>
	</tr>
	<tr>
		<td style=" vertical-align: top; text-align: left;">
			<h4><FONT COLOR="660000" FACE="Arial" SIZE=3> Execution Details :</h4>
			<table  border=0 cellspacing=3 cellpadding=3 >
			<tr>
				<td width=80  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>S.No</b></td>
				<td width=100  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Date</b></td>
				<td width=120  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Associate</b></td>
				<td width=300 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Task Shot Description</b></td>
				<td width=80 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Total Count</b></td>
				<td width=80 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Passed Count</b></td>
				<td width=80 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Failed Count</b></td>
				<td width=80 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Blocked Count</b></td>
				
			</tr>
			
			<%  sNo=0;
			for(int i=0;i<empStatusRecords.size();i++){	
			if(empStatusRecords.get(i).get("taskAssigned").toUpperCase().contains("REGRESSION")||
					empStatusRecords.get(i).get("taskAssigned").toUpperCase().contains("SANITY") ||
			empStatusRecords.get(i).get("taskAssigned").toUpperCase().contains("EXECUTION")){
			sNo++;%>
				<tr>
					<td width=80 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=sNo%></td>
					<td width=100 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskDate") %></td>
					<td width=120 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("empNameFromDB") %></td>
					<td width=300 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskAssigned") %></td>
					<td width=80 align="center" bgcolor="#eeeee0" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("totalNumJobsExecuted") %></td>
					<td width=80 align="center" bgcolor="#eeeee0" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("totalNumJobsPassed") %></td>
					<td width=80 align="center" bgcolor="#eeeee0" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("totalNumJobsFailed") %></td>
					<td width=80 align="center" bgcolor="#eeeee0" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("totalNumJobsBlocked") %></td>
				</tr>
			<%}}%>
				<tr >
					<td colspan="8" width=200 align="center" bgcolor="#A0A1A2" ><FONT COLOR="660000" FACE="Arial" SIZE=2><b></b></td>
					
				</tr>
			</table>
			
			
		</td>
		<td style="padding-right: 50px;"></td>
	
		<td style=" vertical-align: top; text-align: left;">
			<h4><FONT COLOR="660000" FACE="Arial" SIZE=3> Reworked Count :</h4>
			<table  border=0 cellspacing=3 cellpadding=3 >
			<tr>
				<td width=80  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>S.No</b></td>
				<td width=100  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Date</b></td>
				<td width=120  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Associate</b></td>
				<td width=200 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Task Shot Description</b></td>
				<td width=80 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Reworked TC Count</b></td>
				<td width=300 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Reason</b></td>
			</tr>
			
			<%totalAutomatedTCCountReworked=0;  
			sNo=0;
			for(int i=0;i<empStatusRecords.size();i++){	
			if(empStatusRecords.get(i).get("taskAssigned").toUpperCase().contains("FIXING")||
					empStatusRecords.get(i).get("taskAssigned").toUpperCase().contains("REWORKING")){
				sNo++;
				totalAutomatedTCCountReworked=totalAutomatedTCCountReworked+Integer.valueOf(empStatusRecords.get(i).get("updatedTCCount"));
					%>
				<tr>
					<td width=80 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=sNo %></td>
					<td width=100 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskDate") %></td>
					<td width=120 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("empNameFromDB") %></td>
					<td width=80 align="center" bgcolor="#eeeee0" ><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskAssigned") %></td>
					<td width=80 align="center" bgcolor="#eeeee0" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("updatedTCCount") %></td>
					<td width=300 align="center" bgcolor="#eeeee0" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("reasonForUpdate") %></td>
					
				</tr>
			<%}}%>
			<tr >
					<td colspan="5" width=200 align="center" bgcolor="#A0A1A2" ><FONT COLOR="660000" FACE="Arial" SIZE=2><b>Total No. of Test Cases Reworked</b></td>
					<td width=200 align="center" bgcolor="#A0A1A2" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><b><%=totalAutomatedTCCountReworked%></b></td>	
			</tr>	
			</table>
		<td>
	</tr>
	<tr>
		<td style=" vertical-align: top; text-align: left;">
			<h4><FONT COLOR="660000" FACE="Arial" SIZE=3> Adhoc Task Details :</h4>
			<table  border=0 cellspacing=3 cellpadding=3 >
			<tr>
				<td width=80  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>S.No</b></td>
				<td width=100  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Date</b></td>
				<td width=120  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Associate</b></td>
				<td width=300 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Request From</b></td>
				<td width=300 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Task Description</b></td>
				<td width=80 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Status</b></td>
				
			</tr>
			
			<%  sNo=0;
			for(int i=0;i<empStatusRecords.size();i++){	
			if(empStatusRecords.get(i).get("taskAssigned").toUpperCase().contains("ADHOC")||
					empStatusRecords.get(i).get("taskAssigned").toUpperCase().contains("DAILY STATUS CALL") ||
			empStatusRecords.get(i).get("taskAssigned").toUpperCase().contains("INITIATIVES")){
			sNo++;%>
				<tr>
					<td width=80 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=sNo%></td>
					<td width=100 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskDate") %></td>
					<td width=120 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("empNameFromDB") %></td>
					<td width=120 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskRequestBy") %></td>
					<td width=300 align="center" bgcolor="#eeeee0" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskDescription") %></td>
					<td width=80 align="center" bgcolor="#eeeee0" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskStatus") %></td>
				</tr>
			<%}}%>
				<tr >
					<td colspan="8" width=200 align="center" bgcolor="#A0A1A2" ><FONT COLOR="660000" FACE="Arial" SIZE=2><b></b></td>
					
				</tr>
			</table>
			
			
		</td>
		<td style="padding-right: 50px;"></td>
	
		<td style=" vertical-align: top; text-align: left;">
			<h4><FONT COLOR="660000" FACE="Arial" SIZE=3> Test Data Creation :</h4>
			<table  border=0 cellspacing=3 cellpadding=3 >
			<tr>
				<td width=80  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>S.No</b></td>
				<td width=100  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Date</b></td>
				<td width=120  align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Associate</b></td>
				<td width=300 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Request From</b></td>
				<td width=300 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Task Description</b></td>
				<td width=80 align="center" bgcolor="#a6caf0"><FONT FACE="Arial" SIZE=2><b>Status</b></td>
				
			</tr>
			
			<%  sNo=0;
			for(int i=0;i<empStatusRecords.size();i++){	
			if(empStatusRecords.get(i).get("taskAssigned").toUpperCase().contains("TEST DATA CREATION")){
			sNo++;%>
				<tr>
					<td width=80 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=sNo%></td>
					<td width=100 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskDate") %></td>
					<td width=120 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("empNameFromDB") %></td>
					<td width=120 align="center" bgcolor="#eeeee0"><FONT FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskRequestBy") %></td>
					<td width=300 align="center" bgcolor="#eeeee0" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskDescription") %></td>
					<td width=80 align="center" bgcolor="#eeeee0" ><FONT COLOR="#153E7E" FACE="Arial" SIZE=2><%=empStatusRecords.get(i).get("taskStatus") %></td>
				</tr>
			<%}}%>
				<tr >
					<td colspan="8" width=200 align="center" bgcolor="#A0A1A2" ><FONT COLOR="660000" FACE="Arial" SIZE=2><b></b></td>
					
				</tr>
			</table>
			
			
		</td>
	</tr>
	</table>
</body>
</html>
