run("Set Measurements...", "area mean min centroid center perimeter feret's integrated stack limit display redirect=None decimal=3");

dir = getDirectory("Choose a Directory"); 
names = newArray(nImages); 
ids = newArray(nImages); 

for (q=0; q < ids.length; q++){ 
        selectImage(q+1); 
        ids[q] = getImageID(); 
        names[q] = getTitle(); 
        selectWindow(names[q]);
	    getDimensions(w, h, channels, slices, frames);
        print(ids[q] + " = " + names[q] + "   Z= " + slices); 
        print("-------");

               		
				run("Split Channels");
				
				selectWindow("C1-"+ names[q]);
				run("Close");
				selectWindow("C4-"+ names[q]);
				run("Close");
				selectWindow("C2-"+ names[q]);
				run("Red");
				run("Enhance Contrast...", "saturated=0.5");
				run("Apply LUT", "slice");
				run("Subtract...", "value=3 slice");
				run("Threshold..."); 
				waitForUser("Select the threshold");
				setOption("BlackBackground", false);
				run("Convert to Mask", "method=Default background=Dark only");
				run("Analyze Particles...", "size=10-500 pixel add slice");
				
				roiManager("Show All");       
				count=roiManager("count"); 
				array=newArray(count); 
					for(i=0; i<count;i++) { 
        				array[i] = i; 
     		   		}
    			print("Rois: " + count);
				
				selectWindow("C3-"+ names[q]); //CSP
				run("Green");
				run("Subtract...", "value=3 slice");
				roiManager("Show All");
				roiManager("Select", array);
				roiManager("Measure");
				selectWindow("C3-"+ names[q]);
				run("Close");
							
				selectWindow("C2-"+ names[q]);
				run("Close");
				
				roiManager("Save",dir + names[q] +'-ROIset.zip');	
				roiManager("reset");
			 	                   
                 
		
}


selectWindow("Results");
saveAs("Measurements. ", dir +"Results.csv");
selectWindow("Log");
saveAs("Text", dir +"Log.txt");

if (isOpen("Results")) {
         selectWindow("Results"); 
         run("Close" );
    }
    
if (isOpen("Log")) {
         selectWindow("Log");
         run("Close" );
    }
    
while (nImages>0) { 
          selectImage(nImages); 
          close(); 
    } 
