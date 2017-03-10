import java.io.*;
import java.sql.*;
import java.util.Arrays;
import java.util.Scanner;

/* Class opens MariaDB and fetches file names, and then converts
   each .fastq file to .ubam.
   To run FastqToUBAM, you need: 
   - Oracle Java 8
   - Latest picard.jar file from website:
     https://broadinstitute.github.io/picard
   - MariaDB JDBC driver (I used mariadb-java-client-1.5.8.jar)
  
   Build:
     javac FastqToUBAM.java
     Make a dbconfig file with database info (see comments below)
   Run:
     java -cp mariadb-java-client-1.5.8.jar:. FastqToUBAM
 */
public class FastqToUBAM {

    public static void main(String[] args) {
        // None of these should be defined in the code.
        // Make null references for the strings outside try block
        String serverName = null;
        String user = null;
        String database = null;
        String password = null;
        try {
            /* Read the dbconfig file to find connection info
               Format:
               server name
               database name
               user name 
               password
            */
            Scanner sc = new Scanner(new File("dbconfig"));
            serverName = sc.nextLine();
            database = sc.nextLine();
            user = sc.nextLine();
            password = sc.nextLine();
            sc.close();
        } 
        catch (FileNotFoundException e) {
            System.out.println("Could not locate dbconfig file, aborting.");
            System.exit(1);
        }
        // Set the server name, database, user, and password
        int port = 3306;
        // Create the JDBC connection string
        String fullConnect = "jdbc:mariadb://" + serverName + ":" + port 
                             + "/" + database + "?user=" + user + "&password="
                             + password;
        Connection connection = null;
        try {
            // Per MariaDB website, try and use DriverManager to create
            // connection.
            connection = DriverManager.getConnection(fullConnect);
            Statement stmt = connection.createStatement();
            String sql;
            sql = "SELECT * FROM testing;";
            ResultSet rs = stmt.executeQuery(sql);

            while(rs.next()){
                int profile = rs.getInt("profile");
                String sample = rs.getString("sample");
                String attachment = rs.getString("attachment");
                String state = rs.getString("state");
                String ploidy = rs.getString("ploidy");
                String fastq = rs.getString("fastq");
                String bam = rs.getString("bam");
                String gvcf = rs.getString("gvcf");

                System.out.println("Converting fastq: " + fastq);
                fastqToUBAM(fastq);
            }
            rs.close();
            stmt.close();
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException s) {
            System.out.println("SQL error encountered: " + s);
        }
    }

    // Convert a single .fastq file to .ubam using picard.jar command
    public static void fastqToUBAM(String fastqFile) {
        File f = new File(fastqFile);
        File logFile = new File("convert.log");
        int extIndex = f.getName().lastIndexOf(".");
        String filePrefix = f.getName().substring(0, extIndex); 

        String[] picardArgs = { "java", "-Xmx8G", "-jar", "picard.jar",
                                "FastqToSam", "FASTQ=" + fastqFile,
                                "OUTPUT=" + filePrefix + ".ubam",
                                "READ_GROUP_NAME=" + filePrefix,
                                "SAMPLE_NAME=NA12878", 
                                "LIBRARY_NAME=Solexa-272222",
                                "PLATFORM_UNIT=H0164ALXX140820.2",
                                "PLATFORM=illumina",
                                "SEQUENCING_CENTER=BI"
                              };
        try {
            // Java API to spawn another process using the arguments
            // above
            ProcessBuilder p = new ProcessBuilder(Arrays.asList(picardArgs));
            // Start executing the process
            Process x = p.start();
            // The error stream is where all of the output for picard.jar
            // is located, so capture it.
            InputStream os = x.getErrorStream();
            InputStreamReader osr = new InputStreamReader(os);
            BufferedReader br = new BufferedReader(osr);
            String line;
            System.out.print("Output of running is:\n");
            while ((line = br.readLine()) != null) {
                System.out.println(line);
            }
            
        } catch(IOException e) {
            System.out.println("Error running converter: " + e);
        }
    }

}
