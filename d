DEVOPS 

exp 20

terminal- 
mvn -version
java -version
docker —version 
git —version 
open cmd for documents 
and run-
mvn archetype:generate
:
maven-archetype:webapp
maven-archetype-webapp
3
com.example
sample-webapp
enter
enter
after refreshing you can see a file named sample-webapp in documents 
open src-main-under main- create a new folder(test)-create folder under test(java)- under java folder(com folder)- under com new folder(example)
go back to main folder, you can see webapp folder, along with that clear one more new folder (java), 
open java folder create com
open com create example folder
open example create doc text and same HelloServlet.java

now go to test and create doc tect file HelloServletTest.java

open vs code and open HelloServeletTest.java
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import java.io.PrintWriter;
import java.io.StringWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.jupiter.api.Test;

public class HelloServletTest {

    @Test
    void testDoGet() throws Exception {

        HelloServlet servlet = new HelloServlet();

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        StringWriter stringWriter = new StringWriter();
        PrintWriter writer = new PrintWriter(stringWriter);

        when(response.getWriter()).thenReturn(writer);

        servlet.doGet(request, response);

        writer.flush();

        String result = stringWriter.toString();

        assertTrue(result.contains("Deployment Successful"));
        assertTrue(result.contains("Github"));
        assertTrue(result.contains("Jenkins"));
        assertTrue(result.contains("Docker"));
        assertTrue(result.contains("Tomcat 11"));

        verify(response).setContentType("text/html");
    }
}

now go to main folder
open java, com , example and .java file and add 
package com.example;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

@WebServlet("/hello")
public class HelloServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        out.println("<h2>Deployment Successful</h2>");
        out.println("<h3>Github - Jenkins - Docker - Tomcat 11</h3>");
    }
}

in main there is something like WEB-INF folder
add index.jsp and change the existing code to-
<html>
<head>
    <title>CI/CD Demo</title>
</head>

<body>

    <h1>Welcome to CI/CD Pipeline Demo</h1>

    <a href="hello">Click Here</a>

</body>
</html>

open web.xml inside src-main-webapp-WEB-INF
and paste this code
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         version="6.0">

    <servlet>
        <servlet-name>HelloServlet</servlet-name>
        <servlet-class>com.example.HelloServlet</servlet-class>
    </servlet>

    <servlet-mapping>
        <servlet-name>HelloServlet</servlet-name>
        <url-pattern>/hello</url-pattern>
    </servlet-mapping>

</web-app>

go outside in docs
it should show .mvn->src->pom.xml-> create a doc text named Dockerfile
open this file with vs code 

FROM tomcat:11.0-jdk17

COPY target/sample-webapp.war /usr/local/tomcat/webapps/

EXPOSE 8080


again create new text docu
it should show .mvn->src->pom.xml->Dockerfile->Jenkinsfile
open with vs code
pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-webapp"
        CONTAINER_NAME = "my-container"
    }

    stages {

        stage('Build WAR') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Stop Old Container') {
            steps {
                bat 'docker stop %CONTAINER_NAME% || exit 0'
                bat 'docker rm %CONTAINER_NAME% || exit 0'
            }
        }

        stage('Run Container') {
            steps {
                bat 'docker run -d -p 8085:8080 --name %CONTAINER_NAME% %IMAGE_NAME%'
            }
        }

    }
}


open github
copy the url or the repository 
open jenkins 
create new item
WebApp-CI-CD
Maven project 
Create
discard old buils 
stratergy- Log Rotation
days to keep builds-5
Source code management- Git
paste git url 
add credentials 
branch specifier- */main
triggers- add poll scm
schedule * * * * *
goals and options- package
post steps- run only if build succeeds 
add post build action - archive the artifacts
files to archive- target/*.war
save
after it is done go to status download last successful artifacts sample-webapp.war

open localhost:8087/manager/html
open windoes c open apachetomcat- bin- startup.bat - run it right click or smth 
open chrome and refresh localhost page 
green colour last /sample-webapp undeploy
WAR FILE TO DEPLOY CHOOSE FILE 
GO TO DOWNLOADS AND INDERT THE SAMPLE-WEBAPP.WAR
and DEPLOY
green colour boxes open /sample-webapp
you’ll see welcome to ci cd pipeline 

#######################################################

exp 19
open jenkins 
new item 
Docker-Integration-With-Jenkins
freestyle
create 
discard old builds 
5
5
poll scm 
choose git
open github create a new repository Grade-Program 
open docker folder in new volume D
dockerfile and grade.java upload in git  commit changes 
copy url 
paste in jenkins 
credentials give second one 
branch main 

sechduke * * * * *
add build steps—— execute windows batch command
execute command-
docker build -t java.app .
docker run -d -t java.app

build now console output 
#################################################################



exp 18
Grade.java
import java.util.Scanner;

public class Grade {

    // Returns a letter grade based on the average
    static char gradeFunction(double avg) {
        if (avg >= 90) return 'A';
        else if (avg >= 80) return 'B';
        else if (avg >= 70) return 'C';
        else if (avg >= 60) return 'D';
        else return 'F';
    }

    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);

        System.out.print("How many grades (1 to 5)? ");
        int count = scanner.nextInt();

        // Validate input
        if (count < 1 || count > 5) {
            System.out.println("Invalid number. You must enter between 1 and 5 grades.");
            scanner.close();
            return;
        }

        double sum = 0.0;

        // Read grades
        for (int i = 1; i <= count; i++) {
            System.out.print("Enter grade " + i + ": ");
            double grade = scanner.nextDouble();
            sum += grade;
        }

        double avg = sum / count;

        System.out.println("Average: " + avg);
        System.out.println("Letter grade: " + gradeFunction(avg));

        scanner.close();
    }
}

in folders
new vol D->docker->app.py->Dockerfile->Grade.java->sample.py
open cmd and 
docker ps
cd Docker-Java
docker build -t java-app .
docker run -it java-app
docker login
docker tag java-app yourusername/java-app:v1
docker push yourusername/java-app:v1
docker pull yourusername/java-app:v1
docker run -it yourusername/java-app:v1
docker images
docker ps

 ########################

exp 16

Create a folder:
mkdir docker-app
cd docker-app
Create a file named:
1) sample.py
Add the following code:
print("Hello from Docker container!")
 
2)app.py (webserver code)
Add the following code:
from http.server import SimpleHTTPRequestHandler, HTTPServer
 
PORT = 5020
 
class MyHandler(SimpleHTTPRequestHandler):
   def do_GET(self):
       self.send_response(200)
       self.send_header("Content-type", "text/html")
       self.end_headers()
       self.wfile.write(b"<h1>Hello from Docker Python Container</h1>")
 
server = HTTPServer(("0.0.0.0", PORT), MyHandler)
print(f"Server running on port {PORT}...")
server.serve_forever()

Task 2 — Write the Dockerfile
1) Dockerfile for app.py
FROM python:3.9-slim
 
WORKDIR /app
 
COPY app.py .
 
EXPOSE 5020
 
CMD ["python", "app.py"]

Task 3 — Build the Docker Image
Run in the project folder:
docker build -t my-python-app .
Explanation:
• -t → tag (name of image)
• . → current directory (contains Dockerfile)

Task 4 — Check Created Image
docker images
You should see:
my-python-app

Task 5 — Run the Container
docker run my-python-app
Expected output of sample.py:
Hello from Docker container!
 
docker run -p 5000:5000 my-python-app1
Expected output of app.py:
Hello from Docker Python Container in web browser
 

exp 15

Verify installation
docker --version
Expected output:
Docker version XX.X.X
Basic Docker Commands
Check Docker version
docker --version
List running containers
docker ps
List all containers
docker ps -a
List images
docker images
Task 1 — Run First Container
Run a sample container:
docker run hello-world
What happens:
1. Docker checks for image locally.
2. If not found, it downloads it.
3. Creates a container.
4. Runs the container.
5. Displays a success message.
Task 2 — Run a Web Server Container
Pull Nginx image:
docker pull nginx
Run container:
docker run -d -p 8080:80 nginx
Open browser:
http://localhost:8080
You will see the Nginx welcome page.
Task 3 — Manage Containers
List containers:
docker ps
Stop container:
docker stop <container_id>
Remove container:
docker rm <container_id>

exp 14
Steps to Use JaCoCo with Maven
Step 1: Create a Simple Java Project
Create a basic Maven project with a sample class.
Calculator.java
public class Calculator {
 
   public int add(int a, int b) {
       return a + b;
   }
 
   public int divide(int a, int b) {
       if (b == 0) {
           throw new IllegalArgumentException("Cannot divide by zero");
       }
       return a / b;
   }
}
Step 2: Write JUnit Test Cases
Create test cases for the above class.
CalculatorTest.java
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
 
public class CalculatorTest {
 
   Calculator calc = new Calculator();
 
   @Test
   public void testAdd() {
       assertEquals(5, calc.add(2, 3));
   }
 
   @Test
   public void testDivide() {
       assertEquals(2, calc.divide(4, 2));
   }
}
Step 3: Add JaCoCo Plugin in pom.xml
Add the JaCoCo plugin inside the <build> section.
<build>
   <plugins>
       <plugin>
           <groupId>org.jacoco</groupId>
           <artifactId>jacoco-maven-plugin</artifactId>
           <version>0.8.11</version>
           <executions>
               <execution>
                   <goals>
                       <goal>prepare-agent</goal>
                   </goals>
               </execution>
               <execution>
                   <id>report</id>
                   <phase>test</phase>
                   <goals>
                       <goal>report</goal>
                   </goals>
               </execution>
           </executions>
       </plugin>
   </plugins>
</build>
Step 4: Run Tests and Generate Coverage Report
Open terminal in the project directory and run:
mvn clean test
Step 5: View the Coverage Report
After execution, JaCoCo generates the report at:
target/site/jacoco/index.html
Open index.html in a browser to see:
• Instruction coverage
• Line coverage
• Branch coverage
• Method coverage
• Class coverage
Example Output
If only add() and normal divide() are tested:
• add() → fully covered
• divide() → partially covered (exception branch not tested)
Coverage might show:
• Line coverage: 80–90%
• Branch coverage: 50%
Step 6: Improve Coverage
Add a test for the exception case:
@Test
public void testDivideByZero() {
   assertThrows(IllegalArgumentException.class, () -> {
       calc.divide(4, 0);
   });
}
Run again:
mvn clean test
 
 
 
Update the Calculator.java and CalculatorTest.java as follows (Complete Code)
Calculator.java
package SimpleCalculator;
 
public class Calculator {
 
   public int add(int a, int b) {
       return a + b;
   }
 
   public int subtract(int a, int b) {
       return a - b;
   }
 
   public int multiply(int a, int b) {
       return a * b;
   }
 
   public int divide(int a, int b) {
       if (b == 0) {
           throw new ArithmeticException("Division by zero is not allowed.");
       }
       return a / b;
   }
}
 
 
CalculatorTest.java
package SimpleCalculator;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
class CalculatorTest {
 
Calculator cal=new Calculator();
   @Test
   public void testAdd() {
       int result = cal.add(2, 3);
       assertEquals(5, result);
   }
   @Test
   public void testSubtract() {
       int result = cal.subtract(5, 2);
       assertEquals(3, result);
   }
   @Test
   public void testMultiply() {
       int result = cal.multiply(4, 5);
       assertEquals(20, result);
   }
   @Test
   public void testDivide() {
       int result = cal.divide(10, 2);
       assertEquals(5, result);
   }
   @Test
   void testDivisionByZero() {
       assertThrows(ArithmeticException.class, () -> {
           cal.divide(10, 0);
       });
}
}
Commands:
Mvn clean test
Mvn clean verify

