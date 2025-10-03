Tomato Maturity Classification using HSV and K-means Clustering

This repository contains a MATLAB-based GUI application to classify tomato maturity levels (ripe, half-ripe, unripe) using HSV color features and K-means clustering.

---

Overview
Tomato maturity classification is essential for agricultural quality control. This project provides a Graphical User Interface (GUI) in MATLAB that allows users to upload tomato images, process them in HSV color space, apply clustering with K-means, and determine the maturity level.

---

Methods
1. Image Preprocessing
   - Input: tomato image (JPG/PNG).  
   - Conversion from RGB → HSV.  

2. Feature Extraction
   - Extracted Hue, Saturation, Value components.  
   - Built feature array for clustering.  

3. K-means Clustering
   - Cluster count: `k = 3`  
   - Identified groups for:  
     - Matang (Ripe)  
     - Setengah Matang (Half-ripe) 
     - Mentah (Unripe)  

4. Classification
   - Cluster assignment based on HSV thresholds.  
   - Output displayed as text label.  

5. Visualization
   - Original tomato image displayed.  
   - 3D scatter plot of clustering result (Hue-Saturation-Value).  

---

Tech Stack
- MATLAB  
- Image Processing Toolbox  
- K-means Clustering  

---

How to Run
1. Clone this repository.  
2. Open `buahClassifierApp.m` in MATLAB.  
3. Run the function → GUI will open.  
4. Click Load Image and select a tomato image.  

---

Author
Adelia Indah Wahyuni  
Developed in 2024  

