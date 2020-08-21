# This function converts the solutions of EP/PR model 
# into trajectory files readable by GridWare

PrepareTRJfile <- function()
{
    # Set the default bin number to maximum number of bins
    PRbinNumber = GW_PRmax
    EPbinNumber = GW_EPmax
    
    # Generate trajectory file path
    TrajectoryDir = file.path(GW_ProjectPath, GW_ProjectName, GW_ProjectName, 
                              fsep = "/")
    TrajectoryDir = file.path(TrajectoryDir, "trjs", fsep = "_")
    
    ## Create project directory (if it does not exist)
    dir.create(file.path(TrajectoryDir), showWarnings = FALSE)
    
    TrajectoryIdx = SampleIdx
    TrajectoryFile = file.path("C", TrajectoryIdx, fsep = "")
    TrajectoryFile = file.path(TrajectoryFile, "trj", fsep = ".")
    TrajectoryFile = file.path(TrajectoryDir, TrajectoryFile, fsep = "/")
    
    # sol is the solution obtained by solving the model
    nDataPoints <- length(sol[,c("time")])
    
    # Looping over EP/PR data
    for (DataIdx in seq_along(sol[,1]))
    {
        t  = sol[DataIdx,c("time")]
        PR = sol[DataIdx,c("PR")]
        EP = sol[DataIdx,c("EP")]
        
        # Assigning new categories to PR and EP
        PRbinNumber = .bincode(x = PR, breaks = GW_PR_binningThrlds, 
                               right = FALSE, include.lowest = TRUE)
        EPbinNumber = .bincode(x = EP, breaks = GW_EP_binningThrlds, 
                               right = FALSE, include.lowest = TRUE)

        # Writing the new categories as state variables to 
        # trajectory files
        if (DataIdx == 1)
        {
            # Initializing the trajectory file 
            # by writing the first state
            Previous_PRbinNumber = PRbinNumber
            Previous_EPbinNumber = EPbinNumber
            WriteTRJfiles(FilePath = TrajectoryFile, t = t, 
                          PR = PRbinNumber, EP = EPbinNumber, 
                          FirstLine = TRUE)
        }
        else
        {
            # Only write the new states
            if (PRbinNumber != Previous_PRbinNumber 
                || EPbinNumber != Previous_EPbinNumber)
            {
                # A state transition has occurred, so
                # the new state should be written to file
                WriteTRJfiles(FilePath = TrajectoryFile, t = t, 
                              PR = PRbinNumber, EP = EPbinNumber)
                
                Previous_PRbinNumber = PRbinNumber
                Previous_EPbinNumber = EPbinNumber
            }
        }
        
    }
    
    # Write offset time to file 
    WriteTRJfiles(FilePath = TrajectoryFile, t = t, LastLine = TRUE)
}

