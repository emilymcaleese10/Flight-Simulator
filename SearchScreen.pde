// added search screen class - Emily McAleese 23:35 7/4/24
class SearchScreen {
  int startY = 150; // Starting Y-coordinate for the first search bar
  int spacing = 50; // Spacing between search bars
  int barWidth = 500; // Width for search bars
  int barHeight = 45; // Height for search bars
  int textOffsetY = 30; // Y offset for text to be centered in the search bar
  String[] categories = {"FL_DATE", "MKT_CARRIER", "MKT_CARRIER_FL_NUM", "ORIGIN_CITY_NAME", "DEST_CITY_NAME", "CRS_DEP_TIME", "CRS_ARR_TIME"};
  String[] categoryNames = {"Flight Date", "Airline", "Airline number", "Origin City", "Desination City", "Departure Time", "Arrival Time"};
  int graphLeftPadding = 50;
  int graphRightPadding = 50;
  int graphBottomPadding = 150; // Increased to accommodate vertical city names
  int maxBarWidth = 20; // Maximum width of bars to ensure they remain readable
  int minBarWidth = 5;  // Minimum width to ensure graph fits within the screen
  
  void loadDataFromCSV() {
  Table flights = loadTable("flights2k(1).csv", "header");
  for (TableRow row : flights.rows()) {
    DataPoint dataPoint = new DataPoint(
      row.getString("FL_DATE"),
      row.getString("MKT_CARRIER"),
      row.getString("MKT_CARRIER_FL_NUM"),
      row.getString("ORIGIN_CITY_NAME"),
      row.getString("DEST_CITY_NAME"),
      row.getString("CRS_DEP_TIME"),
      row.getString("CRS_ARR_TIME")
    );
    dataPoints.add(dataPoint);
    maxScrollY = -5000;
  }
}

void prepareFlightDataForGraph() {
    flightCounts.clear();
    for (DataPoint dp : dataPoints) {
        String city = dp.originCityName;
        flightCounts.put(city, flightCounts.getOrDefault(city, 0) + 1);
    }
}
  
  
  void drawFilterOptions() 
  {
    fill(0); // Set text color to black for better readability
    textAlign(LEFT); // Ensure text aligns to the left
    textSize(40);
    text("Filter by: " + filterCategory, 50, 130); // Show current filter category
    textSize(18);
    for (int i = 0; i < categories.length; i++) {
      text(categoryNames[i], 50, 180 + i * 50);
    }
  }
  
  void drawSearchBars() 
  {
    for (int i = 0; i < categories.length; i++) {
      String category = categories[i];
      String query = searchQueries.getOrDefault(category, ""); // Get the search query for the current category
    
      // Highlight the active search bar with a different color
      if (category.equals(activeCategory)) {
        fill(200, 220, 255); // Light blue color for the active search bar
      } else {
        fill(255); // White color for inactive search bars
      }
      rect(250, startY + i * spacing, barWidth, barHeight); // Search bar rectangle
      fill(0); // Black text for the query
      text("Search: " + query, 260, startY + i * spacing + textOffsetY); // Display current search query
    }
  
  }
  
  void displayFilteredData() {
    translate(0, scrollY);
    int x = 800, y = 150;
    for (DataPoint dp : filteredDataPoints) {
        display.createDataBox(dp, x, y);
        //text(dp.toString(), 50, y);
        y += 150;
    }
  }
 
  // Determine if a DataPoint matches the current filter
boolean matchesFilter(DataPoint dp) {
  for (Map.Entry<String, String> entry : searchQueries.entrySet()) {
    String category = entry.getKey();
    String value = ""; // Value from the DataPoint based on category
    switch(category) {
      case "FL_DATE": value = dp.flightDate; break;
      case "MKT_CARRIER": value = dp.airlineCode; break;
      case "MKT_CARRIER_FL_NUM": value = dp.flightNumber; break;
      case "ORIGIN_CITY_NAME": value = dp.originCityName; break;
      case "DEST_CITY_NAME": value = dp.destCityName; break;
      case "CRS_DEP_TIME": value = dp.crsDepTime; break;
      case "CRS_ARR_TIME": value = dp.crsArrTime; break;
    }
    String query = entry.getValue();
    if (!value.toLowerCase().contains(query.toLowerCase())) {
      return false; // If any search query does not match, return false
    }
  }
  return true; // If all search queries match, return true
}

}
