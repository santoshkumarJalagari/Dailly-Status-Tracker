package com.updateToDB;

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
@WebServlet("/ADDDataToDB")
public class ADDDataToDB extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public ADDDataToDB() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String empName=request.getParameter("selectEmpName").split("-")[1].replace("_", " ");
		String empTask=request.getParameter("selectEmpTask").split(":")[1].replace("_", " ");
		String defectID=request.getParameter("defectID");
		String defectDescription=request.getParameter("defectDec");
		String totalCount=request.getParameter("totalCount");
		String passCount=request.getParameter("passCount");
		String failCount=request.getParameter("failCount");
		String blockCount=request.getParameter("blockCount");
		String userStoryNumber=request.getParameter("userStoryNumber");
		String testCaseCount=request.getParameter("testCaseCount");
		String updatedTestCaseCount=request.getParameter("updatedTestCaseCount");
		String reasonForUpdate=request.getParameter("reasonForUpdate");
		String taskDate=request.getParameter("taskDate");
		String taskEffort=request.getParameter("taskEffort");
		String taskDesc=request.getParameter("taskDesc");
		String taskStatus=request.getParameter("taskStatus");
		String taskRequestBy=request.getParameter("taskRequestFrom");
		System.out.println("empName: "+empName);
		System.out.println("selectEmpTask: "+empTask);
		System.out.println("taskDesc: "+taskDesc);
		System.out.println("taskDate: "+taskDate);
		System.out.println("taskEffort: "+taskEffort);
		System.out.println("defectID: "+defectID);
		System.out.println("defectDescription: "+defectDescription);
		System.out.println("totalCount: "+totalCount);
		System.out.println("passCount: "+passCount);
		System.out.println("failCount: "+failCount);
		System.out.println("blockCount: "+blockCount);
		System.out.println("userStoryNumber: "+userStoryNumber);
		System.out.println("testCaseCount: "+testCaseCount);
		System.out.println("updatedTestCaseCount: "+updatedTestCaseCount);
		System.out.println("reasonForUpdate: "+reasonForUpdate);
		
		
		boolean recordStatus=updateDataToDB(empName,
				empTask,
				taskDesc,
				taskEffort, 
				taskDate,
				defectID,
				defectDescription,
				totalCount,
				passCount,
				failCount,
				blockCount,
				userStoryNumber,
				testCaseCount,
				updatedTestCaseCount,
				reasonForUpdate,
				taskStatus,
				taskRequestBy
				);
		if(recordStatus){
			request.setAttribute("upload_Sucessfull", "YES");
		}else{
			request.setAttribute("upload_Sucessfull", "NO");
		}
		
		getServletContext().getRequestDispatcher("/statusTracker.jsp").forward(request, response);
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	protected static boolean updateDataToDB(String empName,
			String taskAssigned,
			String longDesc,
			String effort,
			String date,
			String defectID,
			String defectDescription,
			String totalCount,
			String passCount,
			String failCount,
			String blockCount,
			String userStoryNumber,
			String testCaseCount,
			String updatedTestCaseCount,
			String reasonForUpdate,
			String taskStatus,
			String taskRequestBy){
		Connection conn = null;
		Statement stmt = null;
		int status=0;
		date=date.replace("-", "/");
		effort=effort.replace("'", "");
		if(longDesc!=null){
			longDesc=longDesc.replace("'", "");
		}
		
		
		String sqlQuery="INSERT INTO QA_STATUS_TRACKER (EMPNAME, "
				+ "TASK_ASSIGNED,"
				+ "TASK_DESCRIPTION_LONG,"
				+ "EFFORT_HRS,"
				+ "TASK_DATE,"
				+ "DEFECT_ID,"
				+ "DEFECT_DESCRIPTION,"
				+ "TOTAL_NUM_JOBS,"
				+ "TOTAL_NUM_PASS_JOBS,"
				+ "TOTAL_NUM_FAIL_JOBS,"
				+ "TOTAL_NUM_BLOCK_JOBS,"
				+ "AUTOMATED_US_NUM,"
				+ "AUTOMATED_TC_COUNT,"
				+ "UPDATED_TC_COUNT,"
				+ "REASON_FOR_UPDATE,"
				+ "TASK_REQUEST_BY,"
				+ "TASK_STATUS) "
				+ "VALUES ('"+empName+"', '"+
							  taskAssigned+"', '"+
							  longDesc+"', '"+
							  effort+"','"+
							  date+"','"+
							  defectID+"','"+
							  defectDescription+"','"+
							  totalCount+"','"+
							  passCount+"','"+
							  failCount+"','"+
							  blockCount+"','"+
							  userStoryNumber+"','"+
							  testCaseCount+"','"+
							  updatedTestCaseCount+"','"+
							  reasonForUpdate+"','"+
							  taskRequestBy+"','"+
							  taskStatus+"'); ";
		System.out.println(sqlQuery);
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String connectionUrl = "jdbc:mysql://uspetqdtstaut01:3306/Automation";
			String connectionUser = "root";
			String connectionPassword = "505tulsa";
			conn = DriverManager.getConnection(connectionUrl, connectionUser, connectionPassword);
			stmt = conn.createStatement();
			status = stmt.executeUpdate(sqlQuery);
			System.out.println(status);
			
		}catch (Exception e) {
			status=0;
			e.printStackTrace();
		} finally {
			try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		if(status==1){
			return true;
		}else{
			return false;
		}

	}
	protected static ArrayList<Map<String,String>> getDataFromDB(String empName, String date){
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<Map<String,String>> returnData=new ArrayList<Map<String,String>>();
		String sqlQuery="select * from QA_STATUS_TRACKER where TASK_DATE='"+date.replace("/", "-")+"' and EMPNAME='"+empName+"'";
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String connectionUrl = "jdbc:mysql://uspetqdtstaut01:3306/Automation";
			String connectionUser = "root";
			String connectionPassword = "505tulsa";
			conn = DriverManager.getConnection(connectionUrl, connectionUser, connectionPassword);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlQuery);
			if(!rs.next()){
				System.out.println("NO Data for selected emp and date");
			}else{
				rs = stmt.executeQuery(sqlQuery);
				while (rs.next()) {
					Map<String,String> rowData=new HashMap<String,String>();
					String taskAssigned = rs.getString("TASK_ASSIGNED");
					String taskDescription = rs.getString("TASK_DESCRIPTION_LONG");
					String effortInHours = rs.getString("EFFORT_HRS");
					rowData.put("taskAssigned", taskAssigned);
					rowData.put("taskDescription", taskDescription);
					rowData.put("effortInHours", effortInHours);
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
	public static void main(String[] args) {
//		updateDataToDB("Santosh kumar Jalagar","Daily Regression","Completed daily regression","2","2015-10-27");
		getDataFromDB("Santosh kumar Jalagari","2015-09-29");
	}
}


