// added UserInput class - Emily McAleese 21:33 1/4/24
class UserInput {
  // Assuming these are your UI dimensions and positions
  int searchBarsStartY = 150;
  int searchBarsSpacing = 50;
  int searchBarHeight = 45;
  int searchBarWidth = 500; // Assuming the width of your search bars is 500 pixels
  int backBtnX = 50, backBtnY = height - 760, backBtnWidth = 100, backBtnHeight = 30; // Back button dimensions and position
  int buttonX = 244, buttonY = 439, buttonWidth = 180, buttonHeight = 61;
  int buttonX2 = 244, buttonY2 = 519, buttonWidth2 = 180, buttonHeight2 = 61;
  int piButtonX = 800, piButtonY = 150, piButtonWidth = 500, piButtonHeight = 120;
  int viewBtnX = width/2 - 70, viewBtnY = 700, viewBtnWidth = 180, viewBtnHeight = 61;

  
  void draw() {    
    // Interaction with the search bars
    if (currentScreen == 1) { // Assuming 1 is your search screen
        for (int i = 0; i < searchscreen.categories.length; i++) 
        {
            int barY = searchBarsStartY + i * searchBarsSpacing;
            if (mouseX >= 250 && mouseX <= 250 + searchBarWidth && mouseY >= barY && mouseY <= barY + searchBarHeight) {
                activeCategory = searchscreen.categories[i];
                return; // Important to exit after interaction to avoid unintended actions
            }
        }
        for (int i = 0; i < filteredDataPoints.size(); i++) {
          if (mouseX >= piButtonX && mouseX <= piButtonX+piButtonWidth && mouseY >= piButtonY && mouseY <= piButtonY+piButtonHeight) {
            currentScreen = 3;
            currentDataPointIndex = i;
          }
          piButtonY += 150;
        }
    }
   
    
    if (mouseX >= buttonX-buttonWidth/2 && mouseX <= buttonX+buttonWidth/2 && mouseY >= buttonY-buttonHeight/2 && mouseY <= buttonY+buttonHeight/2) {
      if (currentScreen == 0) {
        currentScreen = 1;
      }
    }
    
    if (mouseX >= buttonX2-buttonWidth2/2 && mouseX <= buttonX2+buttonWidth2/2 && mouseY >= buttonY2-buttonHeight2/2 && mouseY <= buttonY2+buttonHeight2/2) {
      if (currentScreen == 0) {
        currentScreen = 2;
      }
    }
    
    if (currentScreen == 2) {
        int x = searchscreen.graphLeftPadding;
        int totalCities = flightCounts.size();
        int availableWidth = width - searchscreen.graphLeftPadding - searchscreen.graphRightPadding;
        int calculatedBarWidth = max(searchscreen.minBarWidth, min(searchscreen.maxBarWidth, availableWidth / totalCities));

        for (String city : flightCounts.keySet()) {
            int flights = flightCounts.get(city);
            int barHeight = (int) map(flights, 0, getMaxFlightCount(flightCounts), 0, height - searchscreen.graphBottomPadding - 50);

            // Check if the mouse click is within the bounds of the current bar.
            if (mouseX >= x && mouseX < x + calculatedBarWidth && mouseY >= height - searchscreen.graphBottomPadding - barHeight && mouseY < height - searchscreen.graphBottomPadding) {
                selectedCity = city; // Correctly assign the clicked city to 'selectedCity'
                // Here you might want to prepare data for displaying the pie chart for 'selectedCity'
                filterDataPointsForCity(selectedCity); // Filter data points for the selected city if needed
                currentScreen = 4; // 4 is the screen number for displaying the pie chart
                return; // Exit the loop as we found the clicked bar
            }
            x += calculatedBarWidth;
        }
    
   }
    
}

  void filterDataPointsForCity(String city) {
    filteredDataPoints.clear();
    // Iterate over each data point.
    for (DataPoint dp : dataPoints) {
        // Check if the data point's origin city matches the selected city.
        if (dp.originCityName.equals(city)) {
            // Add it to the list of filtered data points.
            filteredDataPoints.add(dp);
        }
    } // Now filteredDataPoints contains only the flights from the selected city.
}
  
}
