# This function write the properties of each sample
# to file. These include:
#   - Model parameters
#   - Initialization values
#   - SSG Binning thresholds

WriteDataAttributesToFile <- function()
{
    # Directory for saving data attributes
    DataDir = paste(getwd(), "SimulatedDataset", sep = "/")
    
    ## Create the directory (if it does not exist)
    dir.create(file.path(DataDir), showWarnings = FALSE)
    
    ## Initializing the file
    FilePath = file.path(DataDir, "DataAttributes", fsep = "/")
    DataAttrFile = file.path(FilePath, "csv", fsep = ".")
    
    if (SampleIdx == 1)
    {
        # Writing attribute labels at the beginning of the file
        LabelList <- c("b_pr", "b_ep", 
                       "eta_pr", "eta_ep",
                       "gamma1_pr", "gamma1_ep",
                       "gamma2_pr", "gamma2_ep",
                       "gamma3_pr", "gamma3_ep",
                       "PR_IV",
                       "dPR_IV",
                       "EP_IV",
                       "dEP_IV",
                       "EP_binningThrlds",
                       "PR_binningThrlds")
        LabelLine = paste(LabelList, collapse = ",")
        
        printer = file(DataAttrFile,"w")
        write(x = LabelLine, file = DataAttrFile, append = FALSE)
        close(printer)
    }
    
    printer = file(DataAttrFile,"a")
    AttributeList <- c(ParameterList, state, 
                       GW_EP_binningThrlds,
                       GW_PR_binningThrlds)
    AttributeLine = paste(AttributeList, collapse = ",")
    
    printer = file(DataAttrFile,"a")
    write(x = AttributeLine, file = DataAttrFile, append = TRUE)
    
    close(printer)
}