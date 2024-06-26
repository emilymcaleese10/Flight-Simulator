class BarChart {
  int graphLeftPadding;
  int graphRightPadding;
  int graphBottomPadding; // Increased to accommodate vertical city names
  int maxBarWidth; // Maximum width of bars to ensure they remain readable
  int minBarWidth;  // Minimum width to ensure graph fits within the screen
  
  int totalCities;
  int availableWidth;
  int barWidth;
  int x = graphLeftPadding;
  int graphBaseY = height - graphBottomPadding;
  int graphHeight = height - graphBottomPadding - 50; // Leave space at the top
  int maxCount = getMaxFlightCount(flightCounts);

  BarChart() {
    graphLeftPadding = 50;
    graphRightPadding = 50;
    graphBottomPadding = 150;
    maxBarWidth = 20;
    minBarWidth = 5;
    
    totalCities = flightCounts.size();
    availableWidth = width - graphLeftPadding - graphRightPadding;
    barWidth = max(minBarWidth, min(maxBarWidth, availableWidth / totalCities));
  }


  void displayGraphScreen() 
  {
    background(255); // Ensure this color contrasts with your graph's colors
    drawFlightsGraph();// Draw the graph
    display.drawBackButton();
  }


  
}
