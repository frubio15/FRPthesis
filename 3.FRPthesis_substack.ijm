dir = getDirectory("Choose a Directory"); 
names = newArray(nImages); 
ids = newArray(nImages); 
for (q=0; q < ids.length; q++){ 
        selectImage(q+1); 
        ids[q] = getImageID(); 
        names[q] = getTitle(); 
        selectWindow(names[q]);
	    getDimensions(w, h, channels, slices, frames);
	    
	    for (s=1; s <= slices; s++){ 
			selectImage(q+1);
			run("Make Substack...", "slices="+s);
   		    saveAs("Tiff", dir + names[q] + "- substack " + s + ".tif");
    	    close();
}
}

while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 