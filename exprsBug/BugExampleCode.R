# Background: Working on a function for quality control monitoring of our spectral flow cytometer. 
# We acquire 3000-5000 QC beads before and after running daily automated QC to evaluate changes in MFI over time. 
# I was mapping over the 548 .fcs files in the Cytoset and encountered these two files which threw the specific error in question. 

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
path <- file.path("C:", "Users", "DavidRach", "Desktop", "CytekBeads")
files <- list.files(path=path, pattern=".fcs", full.names=TRUE, recursive = TRUE)
system.time({MyCytoSet <- load_cytoset_from_fcs(files, truncate_max_range = FALSE, transform = FALSE)})

# Minimal Reproducible Example for the error requires both badly named files. 
Here <- subset(MyCytoSet, name == "18 before.fcs"|name == "18 Before.fcs")
exprs(Here[[2]])

# Encountered the bug when mapping the 548 files to a QC_function
pData(MyCytoSet)
keyword(MyCytoSet[[7]], "$DATE")
flowCore::exprs(MyCytoSet[[7]])
Biobase::exprs(MyCytoSet[[7]])

keyword(MyCytoSet[[106]], "$DATE")
flowCore::exprs(MyCytoSet[[106]])
Biobase::exprs(MyCytoSet[[106]])

Values <- data.frame(name=pData(MyCytoSet)$name, check.names = FALSE)
TheLowerCaseValues <- Values %>% dplyr::filter(str_detect(name, "18 before"))
TheUpperCaseValues <- Values %>% dplyr::filter(str_detect(name, "18 Before"))
TheUpperCaseValues

# name.keyword doesn't appear to be working for load_cytoset_from_fcs
MyCytoSet <- load_cytoset_from_fcs(files[c(1:548)], name.keyword="$DATE", truncate_max_range = FALSE, transform = FALSE)
pData(MyCytoSet)

MyCytoSet <- load_cytoset_from_fcs(files[c(1:548)], name.keyword="GROUPNAME", truncate_max_range = FALSE, transform = FALSE)
pData(MyCytoSet)


