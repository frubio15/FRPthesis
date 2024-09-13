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

        		run("8-bit");
        		Stack.setChannel(2);//CSP
				run("Red");
				Stack.setChannel(1);//DAPI
				run("Blue");
								
				waitForUser("Draw the selection area in the DAPI channel and press key T to add the ROI to the ROI manager"); //STOP and continues when I press OK

				
				run("Split Channels");

      	roiManager("Show All");       
		count=roiManager("count"); 
		array=newArray(count); 
		for(i=0; i<count;i++) { 
        		array[i] = i; 
        }
        print("Rois: " + count);
        
				selectWindow("C2-"+  names[q]);	
				roiManager("Select", array);
				roiManager("Measure");	
				roiManager("Save",dir + names[q] +'-ROIset.zip');	
				roiManager("reset");
				
				selectWindow("Results");
				saveAs("Measurements. ", dir +"Results.csv");


                
                for(i=1; i<=(channels);i++) { 
        		selectWindow("C"+ i +"-" +   names[q]);
        		title = getTitle(); 
				saveAs("tiff", dir+title);
				close();
              	}
              	selectWindow("Log");
				saveAs("Text", dir +"Log.txt");
		
}

if (isOpen("Results")) {
         selectWindow("Results"); 
         run("Close" );
    }
    if (isOpen("Log")) {
         selectWindow("Log");
         run("Close" );
    }

