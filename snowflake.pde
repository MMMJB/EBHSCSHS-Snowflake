float rotation = 0;
ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  size(500, 500);
  points = generateSnowflake(int(random(4, 8)), width / 2);
}

void draw() {
  background(135, 206, 235);
  noStroke();
  
  translate(width / 2, height / 2);
  rotate(rotation);
  drawPoints(points, 0, 0);
  
  rotation += 0.001;
}

void mouseReleased() {
  points = generateSnowflake(int(random(4, 8)), width / 2);
}

void drawPoints(ArrayList<PVector> points, float x, float y) {
  beginShape();
  
  for (int i = 0; i < points.size(); i++) {
    PVector point = points.get(i);
    vertex(x + point.x, y + point.y);
  }
  
  endShape(CLOSE);
}

ArrayList<PVector> generateSnowflake(int numSegments, float radius) {
  ArrayList<PVector> segmentPoints = generatePointsForSegment(numSegments, radius);
  return snowflakeFromSegment(numSegments, segmentPoints);
}

ArrayList<PVector> generatePointsForSegment(int numSegments, float radius) {
  int numPointsInSegment = int(random(4, 10));
  float segmentAngle = PI / numSegments;
  ArrayList<PVector> segmentPoints = new ArrayList<PVector>();
  
  for (int i = 0; i < numPointsInSegment; i++) {
    float theta = random(segmentAngle);
    float r = random(radius);
    
    segmentPoints.add(new PVector(theta, r));
  }
  
  for (int i = numPointsInSegment - 1; i >= 0; i--) {
    PVector point = segmentPoints.get(i);
    segmentPoints.add(new PVector(-point.x, point.y));
  }
  
  return segmentPoints;
}

ArrayList<PVector> snowflakeFromSegment(int numSegments, ArrayList<PVector> segmentPoints) {
  ArrayList<PVector> points = new ArrayList<PVector>();
  
  for (int i = 0; i < numSegments; i++) {
    float theta = i * TWO_PI / numSegments;
    
    for (int j = 0; j < segmentPoints.size(); j++) {
      PVector point = segmentPoints.get(j);
      
      float x = cos(point.x + theta) * point.y;
      float y = sin(point.x + theta) * point.y;
      
      points.add(new PVector(x, y));
    }
  }
  
  return points;
}
