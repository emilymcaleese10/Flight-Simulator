class PieChart {
  ArrayList<DataPoint> dataPoints;
  
  PieChart(ArrayList<DataPoint> dataPoints) {
    this.dataPoints = dataPoints;
  }
  
  void draw(float x, float y, float diameter, String origin, String destination) {
    int totalFlights = dataPoints.size();
    int selectedFlights = countFlights(origin, destination);
    
    float startAngle = 0;
    // Draw non-selected flights first
    for (DataPoint dp : dataPoints) {
      if (!(dp.originCityName.equals(origin) && dp.destCityName.equals(destination))) {
        float sweepAngle = map(1, 0, totalFlights, 0, TWO_PI);
        fill(0, 150, 255); // Blue color for other flights
        arc(x, y, diameter, diameter, startAngle, startAngle + sweepAngle);
        startAngle += sweepAngle;
      }
    }
    // Draw selected flights together
    if (selectedFlights > 0) {
      float sweepAngle = map(selectedFlights, 0, totalFlights, 0, TWO_PI);
      fill(255, 0, 0); // Red color for selected flights
      arc(x, y, diameter, diameter, startAngle, startAngle + sweepAngle);
      
      // Label the pie chart segment with origin and destination cities
      float labelX = x + diameter * 0.5 * cos(startAngle + sweepAngle / 2);
      float labelY = y + diameter * 0.5 * sin(startAngle + sweepAngle / 2);
      fill(0);
      text(origin + " to " + destination, labelX - 90, labelY + 150);
    }
    
    // Display percentage of selected flight
    float percentage = (selectedFlights / (float) totalFlights) * 100;
    fill(0);
    textAlign(CENTER, CENTER);
    text(String.format("%.2f%%", percentage), x, y); // Display percentage at the center of the pie chart
  }
  
  int countFlights(String origin, String destination) {
    int flightsCount = 0;
    for (DataPoint dp : dataPoints) {
      if (dp.originCityName.equals(origin) && dp.destCityName.equals(destination)) {
        flightsCount++;
      }
    }
    return flightsCount;
  }
  
  void displayPieChartScreen() {
    background(255); // Background color for the pie chart screen
    display.drawBackButton();
    textSize(20);
    fill(0);
    text("Flight distribution from " + selectedCity, width / 2, 170);
    display.createButton("View Details", width/2 - 70, 700);
    int totalFlights = dataPoints.size(); // Total number of flights
    int flightsFromSelectedCity = 0; // To count flights from the selected city
    // Count flights from the selected city
    for (DataPoint dp : dataPoints) {
        if (dp.originCityName.equals(selectedCity)) {
            flightsFromSelectedCity++;
        }
    }
    float angleForSelectedCity = (float) flightsFromSelectedCity / totalFlights * TWO_PI;
    float percentageForSelectedCity = (float) flightsFromSelectedCity / totalFlights * 100; // Flights from the selected city - Color 1
    fill(100, 200, 100); // Change to a specific color, e.g., a shade of green
    arc(width / 2, height / 2 + 20, 300, 300, 0, angleForSelectedCity);
    fill(100, 100, 200); // Change to another specific color, e.g., a shade of blue     // All other flights - Color 2
    arc(width / 2, height / 2 + 20, 300, 300, angleForSelectedCity, TWO_PI);
    fill(0);
    textSize(20); // Displaying the percentage of flights from the selected city
    text(String.format("%.2f%% of the total flights are from %s", percentageForSelectedCity, selectedCity), width/2 , height / 2 + 250);
}
}
