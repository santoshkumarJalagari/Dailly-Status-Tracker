package com.updateToDB;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

/**
 * Servlet implementation class GetPageData
 */
@WebServlet("/GetPageData")
public class GetPageData extends HttpServlet {
	private static final String displayDataFileName="displayData.json";
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public GetPageData() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		System.out.println("you are in get page data");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	public static List<String> getProjectNames() throws JsonParseException, JsonMappingException, IOException {
	    ObjectMapper objectMapper = new ObjectMapper();
	    PageDetilals pageData = (PageDetilals)objectMapper.readValue(readConfigFile(), PageDetilals.class);
	    
	    List<TeamData> teamData=pageData.getTeamData();
	    List<String> projectNamesList=new ArrayList<String>();
	    for(int i=0;i<teamData.size();i++){
	    	String empName=teamData.get(i).getProjectName();
	    	projectNamesList.add(empName);
	    }

	    return projectNamesList;
	  }
	
	public static List<String> getEmpDetails(String projectName) throws JsonParseException, JsonMappingException, IOException {
	    ObjectMapper objectMapper = new ObjectMapper();
	    PageDetilals pageData = (PageDetilals)objectMapper.readValue(readConfigFile(), PageDetilals.class);
	    
	    List<TeamData> teamData=pageData.getTeamData();
	    List<String> empDetailsList=new ArrayList<String>();
	    for(int i=0;i<teamData.size();i++){
	    	String projectNameTemp=teamData.get(i).getProjectName();
	    	if(projectNameTemp.equalsIgnoreCase(projectName)){
	    		List<EmpDetails> empDetails=teamData.get(i).getEmpDetails(); 
		    	 for(int j=0;j<empDetails.size();j++){
		    		 empDetailsList.add(empDetails.get(j).getEmpName());
		    	 }
	    	}
	    }

	    return empDetailsList;
	  }
	public static List<String> getEmpTaskDetails(String empName) throws JsonParseException, JsonMappingException, IOException {
		 ObjectMapper objectMapper = new ObjectMapper();
		    PageDetilals pageData = (PageDetilals)objectMapper.readValue(readConfigFile(), PageDetilals.class);
		    
		    List<TeamData> teamData=pageData.getTeamData();
		    List<String> emptaskDetailsList=new ArrayList<String>();
		    for(int i=0;i<teamData.size();i++){
		    		List<EmpDetails> empDetails=teamData.get(i).getEmpDetails(); 
			    	 for(int j=0;j<empDetails.size();j++){
			    		 String empNameTemp=empDetails.get(j).getEmpName();
			    		 if(empNameTemp.equalsIgnoreCase(empName)){
			    			 List<Task> empTaskDetails=empDetails.get(j).getTasks();
			    			 for(int k=0;k<empTaskDetails.size();k++){
			    				 emptaskDetailsList.add(empTaskDetails.get(k).getTask());
			    			 }
			    		 }
			    	 }
		    }
	    return emptaskDetailsList;
	  }
	public static String getPageHeader() throws JsonParseException, JsonMappingException, IOException {
	    ObjectMapper objectMapper = new ObjectMapper();
	    PageDetilals pageData = (PageDetilals)objectMapper.readValue(readConfigFile(), PageDetilals.class);
	    return pageData.getPageHeader();
	  }
	 private static String readConfigFile() throws IOException {
		 	ReadData readData=new ReadData();
			ArrayList<String> wsdlData=readData.readFile(displayDataFileName);
			
			File wsdlFilePath= new File("C:\\"+displayDataFileName);
			deleteFIile("C:\\"+displayDataFileName);
			readData.writeToFile(wsdlFilePath, wsdlData);
		    String offeringjsondata = new Scanner(new File("C:\\"+displayDataFileName)).useDelimiter("\\Z").next();
		    return offeringjsondata;
	 }
	 
	 private static void deleteFIile(String filePath){
		 File file=new File(filePath);
		 file.deleteOnExit();
	 }
	 
	}
	 class PageDetilals{
			private String pageHeader="";
			private List<TeamData> teamData;
			
			public String getPageHeader() {
				return pageHeader;
			}
			public void setPageHeader(String pageHeader) {
				this.pageHeader = pageHeader;
			}
			
			public List<TeamData> getTeamData() {
			    return teamData;
			}
			public void setTeamData(List<TeamData> teamData) {
				this.teamData = teamData;
			}
			
	}
	 class TeamData{
		 private String projectName="";
		 
			private List<EmpDetails> empDetails;
			
			
			public String getProjectName() {
				return projectName;
			}
			public void setProjectName(String projectName) {
				this.projectName = projectName;
			}
			
			public List<EmpDetails> getEmpDetails() {
			    return empDetails;
			}
			public void setEmpDetails(List<EmpDetails> empDetails) {
				this.empDetails = empDetails;
			}
	 }
	 
	 class EmpDetails{
		 private String empName="";
		 private List<Task> tasks;
		 
		public String getEmpName() {
			return empName;
		}
		public void setEmpName(String empName) {
			this.empName = empName;
		}
		public List<Task> getTasks() {
			return tasks;
		}
		public void setTasks(List<Task> tasks) {
			this.tasks = tasks;
		}
			
			
	 }
	 class Task{
		 private String task;
		 public String getTask() {
			    return task;
			}
			public void setTask(String task) {
				this.task = task;
			}
	 }
	 class ReadData {
			
			public ArrayList<String> readFile(String filePath) throws java.io.FileNotFoundException,
			java.io.IOException {
			ArrayList<String> aList = new ArrayList<String>();
			System.out.println("File Path: "+filePath);
			try {
			    final InputStream is = this.getClass().getResourceAsStream(filePath);
			    try {
			        final Reader r = new InputStreamReader(is);
			        try {
			            final BufferedReader br = new BufferedReader(r);
			            try {
			                String line = null;
			                while ((line = br.readLine()) != null) {
//			                	Supporting.printInfo(line);
			                    aList.add(line);
			                }
			                br.close();
			                r.close();
			                is.close();
			            } finally {
			                try {
			                    br.close();
			                } catch (IOException e) {
			                    e.printStackTrace();
			                }
			            }
			        } finally {
			            try {
			                r.close();
			            } catch (IOException e) {
			                e.printStackTrace();
			            }
			        }
			    } finally {
			        try {
			            is.close();
			        } catch (IOException e) {
			            e.printStackTrace();
			        }
			    }
			} catch (IOException e) {
			    // failure
			    e.printStackTrace();
			}
			return aList;
		}
			public void writeToFile(File filePath, ArrayList data) throws IOException{
				
					filePath.createNewFile();
					FileWriter writer = new FileWriter(filePath, false);
					writer.flush();
					PrintWriter output = new PrintWriter(writer);
		        for (int i = 0; i < data.size(); i++) {
		        	output.println(data.get(i));
		        }
		        output.close();
			}
		}

