// Added ArrayList data structure for the datapoints - Nishit Jain - 13/03/2024 - 17:45
import java.util.Map;
HashMap<String, Integer> outgoingCounts = new HashMap<String, Integer>();
HashMap<String, Integer> incomingCounts = new HashMap<String, Integer>();
HashMap<String, Integer> flightCounts = new HashMap<String, Integer>();
HashMap<String, String> searchQueries = new HashMap<String, String>();
ArrayList<DataPoint> dataPoints = new ArrayList<DataPoint>();
ArrayList<DataPoint> filteredDataPoints = new ArrayList<DataPoint>();

int currentDataPointIndex = 0;
int currentScreen = 0;
String activeCategory = ""; // The category of the currently active search bar
String filterCategory = "";
String selectedCity = "";
float scrollY = 0;
float maxScrollY = -5000;
PFont customFont;
PFont customFont1;
PImage airplaneFlyingOver;


PieChart piechart = new PieChart(dataPoints);
SearchScreen searchscreen = new SearchScreen();
UserInput userinput = new UserInput();
Display display = new Display();

void setup() {
  size(1400, 800);
  frameRate(100);
  
  airplaneFlyingOver = loadImage("airplaneFlyingOver.jpg");
  airplaneFlyingOver.resize(width, height);
  customFont = createFont("Arial", 16);
  
  loadDataFromCSV();
  prepareFlightDataForGraph();
}

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
  }
}

void prepareFlightDataForGraph() {
    flightCounts.clear();
    for (DataPoint dp : dataPoints) {
        String city = dp.originCityName;
        flightCounts.put(city, flightCounts.getOrDefault(city, 0) + 1);
    }
}


void draw() {
  background(255);
  if (currentScreen == 0) {
    display.displayMainScreen();
  } else if (currentScreen == 1) {
    display.displaySearchScreen();
  } else if (currentScreen == 2) {
    display.displayGraphScreen();
  } else if (currentScreen == 3) {
    display.displayFlightDetails();
  } else if (currentScreen == 4) {
    piechart.displayPieChartScreen();
  }
}

int getMaxFlightCount(HashMap<String, Integer> flightCounts) {
    int maxCount = 0;
    for (int count : flightCounts.values()) {
        if (count > maxCount) {
            maxCount = count;
        }
    }
    return maxCount;
}

void drawFlightsGraph() {
  int graphLeftPadding = 50;
 int graphRightPadding = 50;
 int graphBottomPadding = 150; // Increased to accommodate vertical city names
 int maxBarWidth = 20; // Maximum width of bars to ensure they remain readable
 int minBarWidth = 5;  // Minimum width to ensure graph fits within the screen
  background(255); // Use a white background for clarity
  int totalCities = flightCounts.size();
  int availableWidth = width - graphLeftPadding - graphRightPadding;
  int barWidth = max(minBarWidth, min(maxBarWidth, availableWidth / totalCities));
  int x = graphLeftPadding;
  int graphBaseY = height - graphBottomPadding;
  int graphHeight = height - graphBottomPadding - 50; // Leave space at the top
  int maxCount = getMaxFlightCount(flightCounts);
    
    stroke(0);
    line(graphLeftPadding, graphBaseY, width - graphRightPadding, graphBaseY); // Draw x-axis
    
    for (String city : flightCounts.keySet()) {
        int flights = flightCounts.get(city);
        int barHeight = (int) map(flights, 0, maxCount, 0, graphHeight);
        
        fill(100, 100, 255); // Color for the bars
        rect(x, graphBaseY - barHeight, barWidth, barHeight);
        customFont1 = createFont("Arial", 10); // Create a font (Arial, size 16)
        textFont(customFont1);
        // Rotate text for city names
        pushMatrix();
        translate(x + barWidth / 2, graphBaseY + 10); // Adjust text start position below the x-axis
        rotate(PI / 2); // Rotate by 45 degrees for better readability
        fill(0);
        textAlign(LEFT);
        text(city, 0, 0);
        popMatrix();
        
        x += barWidth; // Move x for the next bar
        if (x + barWidth > width - graphRightPadding) break; // Prevent drawing off-screen
    }
}

// Added user input - Ishaan Jain
void mousePressed() {
  int backBtnX = 50, backBtnY = height - 760, backBtnWidth = 100, backBtnHeight = 30; // Back button dimensions and position
  int viewBtnX = width/2 - 70, viewBtnY = 700, viewBtnWidth = 180, viewBtnHeight = 61;
    userinput.draw();
    // back button interaction
    if (mouseX >= backBtnX && mouseX <= backBtnX + backBtnWidth && mouseY >= backBtnY && mouseY <= backBtnY + backBtnHeight) {
        // Adjust these actions based on application's flow
        if (currentScreen == 3) { // If we're in the detail view, go back to the list/search view
            currentScreen = 1;
        } else if (currentScreen == 1) { // If we're in the search view, go back to the main screen
            currentScreen = 0;
        } else if (currentScreen == 2) { // If we're in the search view, go back to the main screen
            currentScreen = 0;
        } else if (currentScreen == 3) { // If we're in the search view, go back to the search screen
            currentScreen = 2;
        } else if (currentScreen == 4) {
          currentScreen = 2;
        }
    }
    if (currentScreen == 4 && mouseX >= viewBtnX && mouseX < viewBtnX + viewBtnWidth && mouseY >= viewBtnY && mouseY < viewBtnY + viewBtnHeight) {
        // Go back to the previous screen
        currentScreen = 1; // Example: Go back to the bar chart screen
    }
}

void keyPressed() {
    if (currentScreen == 1 && !activeCategory.equals("")) {
        String currentQuery = searchQueries.getOrDefault(activeCategory, "");
        if (key == BACKSPACE && currentQuery.length() > 0) {
            searchQueries.put(activeCategory, currentQuery.substring(0, currentQuery.length() - 1));
        } else if ((key >= 'a' && key <= 'z') || (key >= 'A' && key <= 'Z') || key == ' ' ||key >='0' && key <='9'||key == '/') {
            searchQueries.put(activeCategory, currentQuery + key);
        }
        filterDataPoints(); // Apply filtering based on the updated search query
    }
}

void filterDataPoints() { // Simulate filtering data based on search query and category
  filteredDataPoints.clear();
  for (DataPoint dp : dataPoints) {
    if (searchscreen.matchesFilter(dp)) {
      filteredDataPoints.add(dp);
    }
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scrollY += e * 20; // Adjust scrolling speed and direction
  scrollY = constrain(scrollY, maxScrollY, 0);
}
