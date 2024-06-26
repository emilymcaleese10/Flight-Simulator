// Loaded Flight - Garv Goyal - 12/03/2024 3:08
class DataPoint {
  String flightDate;
  String airlineCode;
  String flightNumber;
  String originCityName;
  String destCityName;
  String crsDepTime;
  String crsArrTime;

  DataPoint(String flightDate, String airlineCode, String flightNumber, String originCityName,
         String destinationCityName, String crsDepTime, String crsArrTime) {
    this.flightDate = flightDate;
    this.airlineCode = airlineCode;
    this.flightNumber = flightNumber;
    this.originCityName = originCityName;
    this.destCityName = destinationCityName;
    this.crsDepTime = crsDepTime;
    this.crsArrTime = crsArrTime;
  }

  void display() {
    fill(0); // Set text color to black
    text("Date: " + flightDate, 20, 30);
    text("Airline: " + airlineCode + flightNumber, 20, 50);
    text("Origin: " + originCityName, 20, 70);
    text("Destination: " + destCityName, 20, 90);
    text("Departure: " + crsDepTime, 20, 110);
    text("Arrival: " + crsArrTime, 20, 130);
  }
    public String toString() {
        return "Flight Date: " + flightDate + ", " +
               "Airline Code: " + airlineCode + ", " +
               "Flight Number: " + flightNumber + ", " +
               "Origin City: " + originCityName + ", " +
               "Destination City: " + destCityName + ", " +
               "Departure Time: " + crsDepTime + ", " +
               "Arrival Time: " + crsArrTime;
    }
    public String getOriginCityName() {
      return originCityName;
    }
    
    public String getDestCityName() {
      return destCityName;
    }
    
    public String getDeptTime() {
      return crsDepTime;
    }
    
    public String getArrivalTime() {
      return crsArrTime;
    }
    
    boolean isMouseOver(int mouseX, int mouseY, int x, int y) {
        // Assume each data point has a designated area on screen for simplicity
        int width = 200; // Width of the area
        int height = 20; // Height of the text
        
        return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
    }
}
// Added datapoints.pde to project - Nishit Jain - 13/03/2024 17:43
// added count to see if the file is being read properly
// created dummy UI
// Garv Goyal 13-03-2024 6:00 pm
