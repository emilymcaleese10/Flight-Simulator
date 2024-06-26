
class Display {

  void displayMainScreen() {
    image(airplaneFlyingOver, 500, 0);
    textAlign(CENTER);
    textSize(50);
    fill(0);
    text("Welcome to our\nflight tracker", 250, 300);
    createButton("Search Screen", 163, 415);
    createButton("Bar Graph", 163, 495);
  }
  
  void displaySearchScreen() {
    drawBackButton();
    searchscreen.drawFilterOptions();
    searchscreen.drawSearchBars();
    displayFilteredData();
  }
  
  void displayFilteredData() {
    translate(0, scrollY);
    int x = 800, y = 150;
    for (DataPoint dp : filteredDataPoints) {
        createDataBox(dp, x, y);
        //text(dp.toString(), 50, y);
        y += 150;
    }
  }
  
  void displayGraphScreen() {
    background(220); // Ensure this color contrasts with your graph's colors
    drawFlightsGraph();// Draw the graph
    drawBackButton();
  }
  
  void displayFlightDetails() {
    background(255); // Clear the screen
    drawBackButton();
    DataPoint selectedFlight = filteredDataPoints.get(currentDataPointIndex);  // Display the details of selectedFlight
    float textX = max(100, width/2 - 200); // Ensure text remains within screen boundaries
    text("Flight Details:", textX-400, 100);
    text(selectedFlight.toString(), textX + 150, 130); // Customize this based on how you want to format it
    piechart.draw(width/2, height/2, 200, selectedFlight.originCityName, selectedFlight.destCityName);
  }
 
  
  void createButton(String text, int x, int y){
    fill(#3B9EBF); // Light gray background for the button
    stroke(0); // Black border for the button
    rect(x, y, 180, 61, 50); // Position the button at the bottom left
    fill(255); // Set text color to black
    textFont(customFont);
    text(text, x+90, y+37); // Center text in the button
  }
  
  void drawBackButton() {
    fill(#3B9EBF); // Light gray background for the button
    stroke(0); // Black border for the button
    rect(50, height - 760, 100, 30, 50); // Position the button at the bottom left
    fill(255); // Set text color to black
    textAlign(CENTER);
    textFont(customFont);
    text("Back", 100, height - 740); // Center text in the button
  }
  
  void createDataBox(DataPoint dp, int x, int y) {
    fill(250);
    rect(x, y, 500, 120, 10);
    fill(0);
    text(dp.getOriginCityName(), x+90, y+40);
    text("---------->   " + dp.getDestCityName(), x+225, y+40);
    text(dp.getDeptTime(), x+130, y+80);
    text(dp.getArrivalTime(), x+350, y+80);
  }
}
