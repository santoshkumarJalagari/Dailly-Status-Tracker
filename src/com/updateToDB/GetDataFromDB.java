package com.updateToDB;

import java.awt.datatransfer.StringSelection;
import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


/**
 * Servlet implementation class ADDDataToDB
 */
@WebServlet("/GETDATAFROMDB")
public class GetDataFromDB extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public GetDataFromDB() {
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		System.out.println("temp");
		String [] empNames=request.getParameterValues("selectEmpName");
		String empName=empNames[0].split("-")[1].replace("_", " ");
		String startTaskDate=request.getParameter("startDate");
		String endTaskDate=request.getParameter("endDate");
		System.out.println("empName: "+empName);
		System.out.println("startTaskDate: "+startTaskDate);
		System.out.println("EndTaskDate: "+endTaskDate);
		String returnEmpNames="";
		for (int i=0;i<empNames.length;i++){
			returnEmpNames=returnEmpNames+empNames[i].split("-")[1].replace("_", " ")+",";
		}
				
		ArrayList<Map<String,String>> returnData=getDataFromDB(empNames, startTaskDate,endTaskDate);
		if(returnData==null){
			request.setAttribute("NODataFound", "YES");
			getServletContext().getRequestDispatcher("/getStatus.jsp").forward(request, response);
		}else{
			request.setAttribute("startDate", startTaskDate);
			request.setAttribute("endDate", endTaskDate);
			request.setAttribute("empName", returnEmpNames.substring(0,returnEmpNames.length()-1));
			request.setAttribute("statusDetails", returnData);
			getServletContext().getRequestDispatcher("/result.jsp").forward(request, response);
		}
		
		
		
		
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	private static String getSubQueryByAddingEMPNames(String[] empNames){
		String temp="EMPNAME='#EMP_NAME#'";
		String returnString="";
		for(int i=0;i<empNames.length;i++){
			returnString=returnString+temp.replace("#EMP_NAME#", empNames[i].split("-")[1].replace("_", " "))+"||";
		}
		
		return returnString.substring(0,returnString.length()-2);
		
		
	}
	public static void main(String[] args) {
		String [] temp="Santosh Kumar Jalagari; Rajeev Anantharaman".split(";");
		System.out.println(getSubQueryByAddingEMPNames(temp));
	}
	
	protected static ArrayList<Map<String,String>> getDataFromDB(String[] empNames, String taskStartDate, String taskEndDate){
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		ArrayList<Map<String,String>> returnData=new ArrayList<Map<String,String>>();
		String sqlQuery="";
		if(taskEndDate==null || taskEndDate==""){
			sqlQuery="select * from QA_STATUS_TRACKER where TASK_DATE='"+taskStartDate.replace("/", "-")+"' and ("+getSubQueryByAddingEMPNames(empNames)+")";
		}else{
			sqlQuery="select * from QA_STATUS_TRACKER where ("+getSubQueryByAddingEMPNames(empNames)+") and TASK_DATE Between '"+taskStartDate+"' AND '"+taskEndDate+"'";
		}
		System.out.println("query: "+sqlQuery);
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String connectionUrl = "jdbc:mysql://uspetqdtstaut01:3306/Automation";
			String connectionUser = "root";
			String connectionPassword = "505tulsa";
			conn = DriverManager.getConnection(connectionUrl, connectionUser, connectionPassword);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlQuery);
			if(!rs.next()){
				return null;
			}else{
				rs = stmt.executeQuery(sqlQuery);
				while (rs.next()) {
					Map<String,String> rowData=new HashMap<String,String>();
					String taskAssigned = rs.getString("TASK_ASSIGNED");
					String taskDescription = rs.getString("TASK_DESCRIPTION_LONG");
					String effortInHours = rs.getString("EFFORT_HRS");
					String taskDateFromDB = rs.getString("TASK_DATE");
					String automatedUserStoryNumber = rs.getString("AUTOMATED_US_NUM");
					String testCaseCount = rs.getString("AUTOMATED_TC_COUNT");
					String defectID = rs.getString("DEFECT_ID");
					String defectDesc = rs.getString("DEFECT_DESCRIPTION");
					String empNameFromDB = rs.getString("EMPNAME");
					String totalNumJobsExecuted = rs.getString("TOTAL_NUM_JOBS");
					String totalNumJobsPassed = rs.getString("TOTAL_NUM_PASS_JOBS");
					String totalNumJobsFailed = rs.getString("TOTAL_NUM_FAIL_JOBS");
					String totalNumJobsBlocked = rs.getString("TOTAL_NUM_BLOCK_JOBS");
					String updatedTCCount = rs.getString("UPDATED_TC_COUNT");
					String reasonForUpdate = rs.getString("REASON_FOR_UPDATE");
					String taskStatus = rs.getString("TASK_STATUS");
					String taskRequestBy = rs.getString("TASK_REQUEST_BY");
					
					
					
					rowData.put("taskAssigned", taskAssigned);
					rowData.put("taskDescription", taskDescription);
					rowData.put("effortInHours", effortInHours);
					rowData.put("taskDate", taskDateFromDB);
					rowData.put("automatedUserStoryNumber", automatedUserStoryNumber);
					rowData.put("testCaseCount", testCaseCount);
					rowData.put("defectID", defectID);
					rowData.put("defectDesc", defectDesc);
					rowData.put("empNameFromDB", empNameFromDB);
					rowData.put("totalNumJobsPassed",totalNumJobsPassed);
					rowData.put("totalNumJobsExecuted", totalNumJobsExecuted);
					rowData.put("totalNumJobsFailed", totalNumJobsFailed);
					rowData.put("totalNumJobsBlocked", totalNumJobsBlocked);
					rowData.put("updatedTCCount", updatedTCCount);
					rowData.put("reasonForUpdate", reasonForUpdate);
					rowData.put("taskStatus", taskStatus);
					rowData.put("taskRequestBy", taskRequestBy);
					
					
					returnData.add(rowData);
					System.out.println("taskAssigned: " + taskAssigned + ", taskDescription: " + taskDescription
							+ ", effortInHours: " + effortInHours);
				}
			}
		}catch (Exception e) {
			
			e.printStackTrace();
		} finally {
			try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
			try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		return returnData;

	}
//	public static void main(String[] args) {
//		updateDataToDB("Santosh kumar Jalagar","Daily Regression","Completed daily regression","2","2015-10-27");
//		getDataFromDB("Santosh kumar Jalagari","2015-09-29");
//	}
}


