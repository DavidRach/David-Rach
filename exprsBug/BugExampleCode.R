# Background: Working on a function for quality control monitoring of our spectral flow cytometer. 
# We acquire 3000-5000 QC beads before and after running daily automated QC to evaluate changes in MFI over time. 
# I was mapping over the 548 .fcs files in the Cytoset and encountered these two files which threw the specific error in question.
# Both files were acquired on the 18th of their respective month. But we have other .fcs files acquired same date and on 18th's with no issue. 

#  error #000: in H5Dread(): line 184
#        major: Invalid arguments to routine
#        minor: Bad value
#     error #001: in H5S_get_validated_dataspace(): line 257
#        major: Dataspace
#       minor: Out of range
#Error: hdf Error

library(flowCore)
library(flowWorkspace)
library(purrr)

# I loaded the .fcs files to the Cytoset
path <- file.path("C:", "Users", "12692", "Desktop", "CytekBeads")
files <- list.files(path=path, pattern=".fcs", full.names=TRUE, recursive = TRUE)
system.time({MyCytoSet <- load_cytoset_from_fcs(files, truncate_max_range = FALSE, transform = FALSE)})

# Encountered the bug when mapping the 548 files to a QC_function
pData(MyCytoSet)
keyword(MyCytoSet[[7]], "$DATE")
flowCore::exprs(MyCytoSet[[7]])
Biobase::exprs(MyCytoSet[[7]])

keyword(MyCytoSet[[106]], "$DATE")
flowCore::exprs(MyCytoSet[[106]])
Biobase::exprs(MyCytoSet[[106]])
