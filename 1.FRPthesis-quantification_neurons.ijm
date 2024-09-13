run("Set Scale...", "distance=2.7307 known=1 pixel=1 unit=micron global");
run("Set Measurements...", "area mean median min perimeter integrated display redirect=None decimal=2");

stackname1 =getTitle();
run("Duplicate...", "duplicate");
stackname2 =getTitle();
run("Split Channels");
selectWindow("C1-"+ stackname2);
setAutoThreshold("Default dark");
run("Threshold...");
setThreshold(35, 250);
run("Create Selection");
run("ROI Manager...");
roiManager("Add");

selectWindow(stackname1);
Stack.setChannel(1);	
roiManager("Select", 0);
roiManager("Measure");

selectWindow("C2-"+ stackname2);

selectWindow(stackname1);
Stack.setChannel(2);	
roiManager("Select", 0);
roiManager("Measure");

count=roiManager("count"); 
array=newArray(count); 
for(i=0; i<count;i++) { 
        array[i] = i; 
        }
roiManager("Select", array); 
dir = getDirectory("Choose a Directory"); 
roiManager("Save",dir + stackname1 +'-ROIset.zip');
roiManager("Select", array); 
roiManager("Delete");
