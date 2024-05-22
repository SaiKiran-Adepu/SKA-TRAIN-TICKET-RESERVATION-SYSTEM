<%@ include file="sessionvaltu.jsp"%>
<%@ include file="packaget.jsp"%>
<%@ page import="java.util.Map" %>

<%!
    Connection con;
    PreparedStatement ps1,ps2,ps1d;//ps4;
	public void jspInit()
    {
        try
        {
            
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/train","root","tiger");
            // ps1d = con.prepareStatement("insert into Train_Names (DOJR)values(?)");
          ps1 = con.prepareStatement("SELECT Train_Number,Train_Name FROM trains WHERE train_number=? AND FIND_IN_SET(?,Fstation) AND FIND_IN_SET(?,Fstation) AND FIND_IN_SET(?,CLASS) AND FIND_IN_SET(?,ticket_type)");
          ps2 = con.prepareStatement("SELECT fare,km FROM train_Fare WHERE FIND_IN_SET(?,Fstation) AND FIND_IN_SET(?,FStation)>0");
       
    
    }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
%>
<html>
<style>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
textarea {
  resize: none;
}
</style>
<title>TRAIN RESEVATION</title>
</head>

<body onkeydown="return(event.keyCode == 154)">

<%
   //String uname = request.getParameter("");
      
       // String s = request.getParameter("SOURCE");
        int tnum=Integer.parseInt(request.getParameter("tnum"));
        //int trn=Integer.parseInt(request.getParameter("trnn"));
       String trnn = request.getParameter("trnn");
        String s = request.getParameter("SOURCE");
        String d = request.getParameter("DEST");
         String doj = request.getParameter("setTodaysDate");//date of journey
        String tcl = request.getParameter("tycl");//class
        String couch = request.getParameter("couch");//couch
        String dob = request.getParameter("dob");//date of booking
        String tt = request.getParameter("tyt");//general
     //directly inserting the pname page pgen berth to train_sitting table no need to insert traiN_reservation table
     //and here in db table maked them as null instead of remove/delete beacuse of total project modification
      
        int ad=Integer.parseInt(request.getParameter("ad"));
        int ch=Integer.parseInt(request.getParameter("ch"));
        String berth = request.getParameter("berth");
        //String gen="GENERAL";
     
        String tcl1 = request.getParameter("tycl");
        String tt1 = request.getParameter("tyt");
     
        ps1.setInt(1,tnum);
        ps1.setString(2,s);
        ps1.setString(3,d);
        ps1.setString(4,tcl);
        ps1.setString(5,tt);
        ResultSet rs = ps1.executeQuery();
        ps2.setString(1,s);
        ps2.setString(2,d);
        
		     
		     out.println("<center><font color=blue><h3>REVIEW JOURNEY</h3></font></center>");
          out.println("<form method = post onSubmit=return login(this) action = gatewayua.jsp>");
         //out.println("<form method = post onSubmit=return login(this) action = reservationucnf.jsp>");
         //int cnt=rs;          
         while(rs.next())
         {
              out.println("<center>");
        out.println("<table border=3 bgcolor= orange>");
		    out.println("<tr>");
		          out.println("<th>TRAIN NUMBER</th>");
		         out.println("<th>TRAIN NAME</th>");
          out.println("<th>FROM</th>");
          out.println("<th>TO</th>");
          out.println("<th>CLASS</th>");//Sec to kazipet
          out.println("<th>COUCH</th>");
          //out.println("<th>BERTH</th>");      
          out.println("<th>TICKET TYPE</th>");
           //out.println("<th>PASSENGER NAME</th>");
          out.println("</tr>");
      
            out.println("<tr>");
            out.println("<td><textarea rows1 cols=15 name=tn>"+rs.getInt(1)+"</textarea></td>");
            out.println("<td><textarea rows1 cols=15 name=tname readonly>"+trnn+"</textarea></td>");
            out.println("<td><textarea rows1 cols=15 name=s readonly>"+s+"</textarea></td>");
            out.println("<td><textarea rows1 cols=15 name=d readonly>"+d+"</textarea></td>");
            out.println("<td><textarea rows1 cols=15 name=tcl readonly>"+tcl+"</textarea></td>");
            out.println("<td><textarea rows1 cols=15 name=couch readonly>"+couch+"</textarea></td>");
            //out.println("<td><textarea rows1 cols=15 name=berth readonly>"+berth+"</textarea></td>");
            out.println("<td><textarea rows1 cols=15 name=tt readonly>"+tt+"</textarea></td>");
           // out.println("<td><textarea rows1 cols=15 name=pname readonly>"+pname+"</textarea></td>");
           
            out.println("</tr>");
//[Ljava.lang.String;@1a09d26

  out.println("<tr>");
         
           out.println("<th>ADULT</th>");
           out.println("<th>CHILD</th>");
           out.println("<th>DOB</th>");
           out.println("<th>DOJ</th>");
           out.println("<th>FARE</th>");
           out.println("<th>KM</th>");
           out.println("<th>USER NUMBER</th>");
           //out.println("<th>DATE OF JURNEY</th>");
          out.println("<th>ACTION</th>");
		       out.println("</tr>");

            out.println("<tr>");
            //out.println("<td><textarea rows1 cols=15 name=page1 readonly>"+page1+"</textarea></td>");
            //out.println("<td><textarea rows1 cols=15 name=gen readonly>"+gen+"</textarea></td>");
            out.println("<td><textarea rows1 cols=15 name=ad readonly>"+ad+"</textarea></td>");
            out.println("<td><textarea rows1 cols=15 name=ch readonly>"+ch+"</textarea></td>");
            out.println("<td><textarea rows1 cols=15 name=dob readonly>"+dob+"</textarea></td>");
            out.println("<td><textarea rows1 cols=15 name=doj readonly>"+doj+"</textarea></td>");
            
           

            out.println("<br>");
              ResultSet rs1 = ps2.executeQuery();
            
              while(rs1.next())
        {
                  int r =rs1.getInt(1);
            out.println("<textarea rows1 cols=15 name=bsf readonly hidden>"+r+"</textarea>");
                  out.println("BASE FARE:&nbsp"+r);
                  //int q =rs1.getInt(1);
                //out.println("<br>");
                  int q1;
                switch(tcl) {
               case "AC FIRST CLASS":
                     r=r+200;
              q1=200;
              out.println("<br>");
              out.println("1 AC CHARGES:+&nbsp"+q1);
              out.println("<textarea rows1 cols=15 name=acc readonly hidden>"+q1+"</textarea>");
              //<textarea rows1 cols=15 name=d readonly>
              out.println("<br>");
              break;
               case "AC 2 Tier(2A)":
               r=r+120;
               q1=120;
              out.println("2 AC CHARGES:+&nbsp"+q1);
              out.println("<textarea rows1 cols=15 name=acc readonly hidden>"+q1+"</textarea>");

              out.println("<br>");
               break;
                case "AC 3 Tier (3A)":      
               r=r+80;
               //out.println("<p>"+r+"</p>");
               q1=80;
               out.println("<br>");
              out.println("3 AC CHARGES:+&nbsp"+q1);
              out.println("<textarea rows1 cols=15 name=acc readonly hidden>"+q1+"</textarea>");
              out.println("<br>");
               break;
              case "CHAIR CAR":      
               r=r+60;
               //out.println("<p>"+r+"</p>");
               q1=60;
               out.println("<br>");
              out.println("CAHIR CAR CHARGES:+&nbsp"+q1);
              out.println("<textarea rows1 cols=15 name=acc readonly hidden>"+q1+"</textarea>");

              out.println("<br>");
               break;
                case "SLEEPER":
               r=r+40;
               //out.println("<p>"+r+"</p>");
               q1=40;
               out.println("<br>");
              out.println("SLEEPER CLASS CHARGES:+&nbsp"+q1);
              out.println("<textarea rows1 cols=15 name=acc readonly hidden>"+q1+"</textarea>");

              out.println("<br>");
               break;
               case "SECOND SITTING":
               r=r+20;
               //out.println("<p>"+r+"</p>");
               q1=20;
               out.println("<br>");
              out.println("2 SITTING CHARGES:+&nbsp"+q1);
              out.println("<textarea rows1 cols=15 name=acc readonly hidden>"+q1+"</textarea>");

              out.println("<br>");
               break;
            
               default:
               
              }
              
               int q2;
                switch(tt) {

                   case "GENERAL":
               //out.println("It\'s Sunday.");
               r=r+0;
                q2=0;
               out.println("GENERAL CHARGES:&nbsp"+q2);//backend getting errors thats why iam added General as ticket type when user selects a general as ticket then he need to handle here
               out.println("<textarea rows1 cols=15 name=tc readonly hidden>"+q2+"</textarea>");
              out.println("<br>");
               break;


            case "TATKAL":
               //out.println("It\'s Sunday.");
               r=r+50;
                q2=50;
               out.println("TATKAL CHARGES:+&nbsp"+q2);
               out.println("<textarea rows1 cols=15 name=tc readonly hidden>"+q2+"</textarea>");

              out.println("<br>");
               break;
               case "PREMIUM TATKAL":
               r=r+70;
               //out.println("<p>"+r+"</p>");
                q2=70;
               out.println("PREMIUM TATKAL CHARGES:+&nbsp"+q2);
               out.println("<textarea rows1 cols=15 name=tc readonly hidden>"+q2+"</textarea>");

              out.println("<br>");
               break;
                case "LADIES":
               r=r-20;
               //out.println("<p>"+r+"</p>");
                q2=-20;
                //out.println("<br>");
               out.println("LADIES QUOTA:&nbsp"+q2);
               out.println("<textarea rows1 cols=15 name=tc readonly hidden>"+q2+"</textarea>");

              out.println("<br>");
               break;
                case "PHC":
               r=r-40;
              // out.println("<p>"+r+"</p>");
                q2=-40;
               out.println("PHC QUOTA:&nbsp"+q2);
               out.println("<textarea rows1 cols=15 name=tc readonly hidden>"+q2+"</textarea>");

              out.println("<br>");
               break;  
            default:
         }
         int a=r;
         switch(ad) {
               case 0:
                     a=r-r;
              out.println("<br>");
              break;
            case 1:
                     a=r*1;
              out.println("<br>");
              break;
               case 2:
               a=r*2;
                out.println("<br>");
               break;
                case 3:      
               a=r*3;
               out.println("<br>");
               break;
              case 4:      
               a=r*4;
              out.println("<br>");
              out.println("<br>");
               break;
                case 5:
               a=r*5;
               out.println("<br>");
               break;
               case 6:
              a=r*6;
              out.println("<br>");
              break;
               case 7:
               a=r*7;
              out.println("<br>");
              break;
               case 8:
               a=r*8;
              out.println("<br>");
              break;
               case 9:
               a=r*9;
              out.println("<br>");
              break;
              case 10:
               a=r*10;
              out.println("<br>");
              break;
            
            
            default:
               //out.println("It's definetly executes.");
            //out.println("<br>");   
         }
         

            int r1=r;//=rs1.getInt(1);
         switch(ch) {
            case 0:
                     r1=r1-r1;
              out.println("<br>");
              break;
            case 1:
                     r1=r1/2;
              out.println("<br>");
              break;
               case 2:
               r1=r1*2/2;
                out.println("<br>");
               break;
                case 3:      
               r1=r1/2*3;
               out.println("<br>");
               break;
              case 4:      
               r1=r1/2*4;
              out.println("<br>");
              out.println("<br>");
               break;
                case 5:
               r1=r1/2*5;
               out.println("<br>");
               break;
               case 6:
               r1=r1/2*6;
              out.println("<br>");
              break;
               case 7:
               r1=r1/2*7;
              out.println("<br>");
              break;
               case 8:
               r1=r1/2*8;
              out.println("<br>");
              break;
               case 9:
               r1=r1/2*9;
              out.println("<br>");
              break;
              case 10:
               r1=r1/2*10;
              out.println("<br>");
              break;
            default:
               //out.println("It's definetly executes.");
            //out.println("<br>");   
         }
                 int s1;
                 s1=a+r1;
                out.println("<td><textarea rows1 cols=5 name=fr readonly>"+s1+"</textarea></td>");//total fare with class type adult child
          //out.println("<td>"+rs1.getInt(1)+"</td>");
                 out.println("<td><textarea rows1 cols=5 name=km readonly>"+rs1.getInt(2)+"</textarea></td>");
                   
         Integer i1=(Integer)session.getAttribute("nu"); 
		      int k1=i1.intValue();
                 
                 out.println("<td><textarea rows1 cols=15 name=usr readonly>"+k1+"</textarea></td>");//booked by from user site
                 
        //out.println("<");//onSubmit=return login(this)
                 out.println("<td><input type = submit value=PAY onClick =login(this.form)>&nbsp&nbsp<input type=button value=BACK onclick=history.back()></td>");
                 out.print("</form>");
       
          out.println("</tr>");
          //        out.println("<br>");
                out.println("</table>");
		      out.println("</center>");
        }
          } 


          out.println("<center>");
           out.println("<h3><font color=#4B0082>Passenger Details:</font></h3>");
        out.println("<table border=3 background-color= #dddddd>");
        out.println("<tr>");
        out.println("<td>Passenger Name</td><td>Age</td><td>Gender</td><td>Reservation Choice</td>"); 
        out.println("</tr>");

         List<Map<String, String>> passengerList = new ArrayList<>();
            String[] pname1Values = request.getParameterValues("pname[]");
            String[] page1Values = request.getParameterValues("page1[]");
            String[] pgen1Values = request.getParameterValues("pgen[]");
            String[] pbth1Values = request.getParameterValues("pbth[]");

      

           // if (pname1Values != null && page1Values != null && pagen1Values != null && pbth1Values != null)
             
//{
       for (int i1 = 0; i1 < pname1Values.length; i1++)
     {
        String pname2 = pname1Values[i1];
        pname2 = pname2.toUpperCase();
        String page2 = page1Values[i1];
        String pgen2 = pgen1Values[i1];
        String pbth2 = pbth1Values[i1];
         Map<String, String> passengerData = new HashMap<>();
          passengerData.put("Name", pname2);
            passengerData.put("Age", page2);
            passengerData.put("Gender", pgen2);
            passengerData.put("Berth", pbth2);
            passengerList.add(passengerData);
       
                out.println("<tr>");
               
                out.println("<td><textarea rows1 cols=15 name=pname[] readonly>"+pname2+"</textarea></td>");
                out.println("<td><textarea rows1 cols=15 name=page1[] readonly>"+page2+"</textarea></td>");
                 out.println("<td><textarea rows1 cols=15 name=pgen[] readonly>"+pgen2+"</textarea></td>");
                  out.println("<td><textarea rows1 cols=15 name=pbth[] readonly>"+pbth2+"</textarea></td>");
    }
    
   
 session.setAttribute("passengerList", passengerList);

  
out.println("</tr>");

        out.println("</table>");
    
  
   
%>



<%!
    public void jspDestroy()
    {
        try
        {   
            //ps1d.close();
            ps1.close();
            ps2.close();
          
            con.close();
        
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
%>

</body>

</html>