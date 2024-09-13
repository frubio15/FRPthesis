dir = getDirectory("Choose a Directory"); //Displays a file open dialog, using the argument as a title, and returns the path to the directory selected by the user.
names = newArray(nImages); 
ids = newArray(nImages);

for (q=0; q <ids.length; q++){ 
	    selectImage(q+1); 
        ids[q] = getImageID(); 
        names[q] = getTitle(); 
        selectWindow(names[q]);


run("8-bit");
run("Median...", "radius=5"); 
run("Maximum...", "radius=4");
run("Subtract Background...", "rolling=50");
run("Threshold..."); 
setThreshold(70, 254);
waitForUser("Adjust threshold for parvalbumin"); 
run("Convert to Mask");
run("Watershed"); 
run("Analyze Particles...", "size=220-2500 pixel show=Nothing summarize add"); 

roiManager("Show All");       
		count=roiManager("count"); 
		array=newArray(count); 
		for(i=0; i<count;i++) { 
        		array[i] = i; 
        }

}
while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
