
UpdateProjectFile <- function()
{
    TrajectoryIdx = SampleIdx
    
    ## Create project directory (if it does not exist)
    dir.create(file.path(GW_ProjectPath, GW_ProjectName), 
                showWarnings = FALSE)
    
    ## Initializing the file
    FilePath = file.path(GW_ProjectPath, GW_ProjectName, 
                         GW_ProjectName, fsep = "/")
    ProjectFile = file.path(FilePath, "gwf", fsep = ".")
    printer = file(ProjectFile,"w")
    
    write(x = "<GridWare>", file = ProjectFile, append = FALSE)
    
    ### Start of configuration section
    write(x = "<Config>", file = ProjectFile, append = TRUE)
    
    ## Generating attribute line
    attributeVector <- vector(mode="character", length=TrajectoryIdx+1)
    attributeVector[1] = "identifier	categorical	person"
    
    # We insert one attribute for each simulated trajectory
    # C stands for child
    for (Idx in 1:TrajectoryIdx)
    {
        attributeVector[Idx+1] = paste("C", Idx, sep = "")
    }
    write(x = attributeVector, 
          file = ProjectFile, append = TRUE, 
          ncolumns = TrajectoryIdx + 3, sep = "\t");
    
    ## Writing state variable lines
    
    # Prepotent responses
    PRstateVector <- vector(mode="character", length=GW_PRmax+3)
    PRstateVector[1] = "state	integer	prepotent responses"
    PRstateVector[2] = "1"
    PRstateVector[3] = GW_PRmax
    for (Idx in 1:GW_PRmax)
    {
        PRstateVector[Idx+3] = Idx
    }
    write(x = PRstateVector, 
          file = ProjectFile, append = TRUE, 
          ncolumns = GW_PRmax + 6, "\t");
    
    # Executive processes
    EPstateVector <- vector(mode="character", length=GW_EPmax+3)
    EPstateVector[1] = "state	integer	executive processes"
    EPstateVector[2] = "1"
    EPstateVector[3] = GW_EPmax
    for (Idx in 1:GW_EPmax)
    {
        EPstateVector[Idx+3] = Idx
    }
    write(x = EPstateVector, 
          file = ProjectFile, append = TRUE, 
          ncolumns = GW_EPmax + 6, sep = "\t");
    
    ## Preferences
    write(x = "MinReturns	2", 
          file = ProjectFile, append = TRUE)
    write(x = "MaxReturnTime	10", 
          file = ProjectFile, append = TRUE)
    write(x = "MaxReturnVisits	6", 
          file = ProjectFile, append = TRUE)
    write(x = "MinEventDuration	0", 
          file = ProjectFile, append = TRUE)
    write(x = "MinCellDuration	0", 
          file = ProjectFile, append = TRUE)
    write(x = "MissingValueSymbol	--", 
          file = ProjectFile, append = TRUE)
    
    ### End of configuration section
    write(x = "</Config>", file = ProjectFile, append = TRUE)
    
    ## Start of trajectory section
    write(x = "<Trajectories>", file = ProjectFile, append = TRUE)
    
    write(x = "person	Filename", file = ProjectFile, append = TRUE)
    for (Idx in 1:TrajectoryIdx)
    {
        TrajectoryFile = paste(attributeVector[Idx + 1], "trj", sep = ".")
        TrajectoryLine = paste(attributeVector[Idx + 1], TrajectoryFile,
                               sep = "\t")
        write(x = TrajectoryLine, file = ProjectFile, append = TRUE)
    }
    
    ## End of trajectory section
    write(x = "</Trajectories>", file = ProjectFile, append = TRUE)
    
    ## End of project file
    write(x = "</GridWare>", file = ProjectFile, append = TRUE)
    
    close(printer)
}