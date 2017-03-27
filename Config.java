public class Config{

  Properties prop =  null;
  public Config(String configFile){
    prop = this.getProperties(configFile);

  }

  private Properties getProperties(String configFile) {
      File config = new File(configFile);
      try {
          FileReader reader = new FileReader(config);
          Properties props = new Properties();
          props.load(reader);
          reader.close();
      }
      catch (Exception e) {

      }
      return props;
    }

    public void main(String args){
      Config testConfig = new Config("config.properties");
      String sever = testConfig.prop.getProperties("sever");
      system.out.println(sever);
    }
  }
