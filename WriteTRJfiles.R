WriteTRJfiles <- function(FilePath, t, PR, EP, FirstLine = FALSE,
                          LastLine = FALSE)
{
    # Initializing the trajectory file
    trjFile = file.path(FilePath);
    
    if (FirstLine)
    {
        printer = file(trjFile,"w");
        
        write("Onset	prepotent responses	executive processes", 
              trjFile, append = TRUE);
    }
    else if (LastLine)
    {
        printer = file(trjFile,"a+");
        write(x = c(t), file = trjFile, sep = "\t", 
              append = TRUE);
    }
    else
    {
        printer = file(trjFile,"a+");
        write(x = c(t, PR, EP), file = trjFile, sep = "\t", 
              append = TRUE);
    }
    
    close(printer)
}
