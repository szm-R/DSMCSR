# This is the main script for generating simulated data set

# GridWare project parameters:
GW_ProjectPath = "C:/PhD/Projects/SSG"
GW_ProjectName = "CBMSR"
GW_PR_binningThrlds <- c(0,1,2,3,4,5,19)
GW_EP_binningThrlds <- c(0,5,10,16)
GW_PRmax = 6
GW_EPmax = 3


# Parameter distributions: 
#   All parameters are assumed to have uniform distributions
#   The minimum and maximum of each parameter is provided below:
min_b_pr = 1; max_b_pr = 9
min_b_ep = 1; max_b_ep = 7

min_eta_pr = -0.5; max_eta_pr = -0.01
min_eta_ep = -0.5; max_eta_ep = -0.01

min_gamma1_pr = -0.5; max_gamma1_pr = 0.5
min_gamma1_ep = -0.5; max_gamma1_ep = 0.5

min_gamma2_pr = -0.1; max_gamma2_pr = 0.1
min_gamma2_ep = -0.1; max_gamma2_ep = 0.1

min_gamma3_pr = -0.5; max_gamma3_pr = 0.5
min_gamma3_ep = -0.5; max_gamma3_ep = 0.5

# Setting random seed
set.seed(1)

# Number of samples in the simulated data set
Number_of_Samples = 2

# Initial values
state <- c(PR = 0.1,
           X1 = 0.1,
           EP = 0.1,
           X2 = 0.1)

# In each iteration of the loop a set of parameters is drawn
# from the uniform distributions specified above. The EP/PR
# equations are then solved using these parameters. The results
# are saved in simulated data set.

for (SampleIdx in 1:Number_of_Samples)
{
    ## Generating parameters by sampling from a uniform distribution
    R_b_ep = runif(n = 1, min = min_b_ep, max = max_b_ep)
    R_b_pr = runif(n = 1, min = min_b_pr, max = max_b_pr)
    
    R_eta_ep = runif(n = 1, min = min_eta_ep, max_eta_ep)
    R_eta_pr = runif(n = 1, min = min_eta_pr, max_eta_pr)
    
    R_gamma1_ep = runif(n = 1, min = min_gamma1_ep, max = max_gamma1_ep)
    R_gamma1_pr = runif(n = 1, min = min_gamma1_pr, max = max_gamma1_pr)
    
    R_gamma2_ep = runif(n = 1, min = min_gamma2_ep, max = max_gamma2_ep)
    R_gamma2_pr = runif(n = 1, min = min_gamma2_pr, max = max_gamma2_pr)
    
    R_gamma3_ep = runif(n = 1, min = min_gamma3_ep, max = max_gamma3_ep)
    R_gamma3_pr = runif(n = 1, min = min_gamma3_pr, max = max_gamma3_pr)
    
    ParameterList <- c(b_pr = R_b_pr,
                       b_ep = R_b_ep,
                       eta_pr = R_eta_pr,
                       eta_ep = R_eta_ep,
                       gamma1_pr = R_gamma1_pr,
                       gamma1_ep = R_gamma1_ep,
                       gamma2_pr = R_gamma2_pr,
                       gamma2_ep = R_gamma2_ep,
                       gamma3_pr = R_gamma3_pr,
                       gamma3_ep = R_gamma3_ep)
    
    ## Solving Cole-Bendezú Model of Self-Regulation (CBMSR)
    sol <- SolveCBMSR()
    
    
    ## Preparing the files required by GridWare
    
    # Updating GridWare project file to account for the newly
    # added trajectories
    UpdateProjectFile()
    
    # Converting the solutions of CBMSR 
    # into trajectory files readable by GridWare
    PrepareTRJfile()

    
    ## Writing data attribute to file for future referencing
    WriteDataAttributesToFile()
}










