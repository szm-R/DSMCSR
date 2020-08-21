# This function solve Cole-Bendezú Model of Self-Regulation (CBMSR)

SolveCBMSR <- function(timeLimit = 100, 
                       NumSamples = 10000)
{
    library(deSolve)
    
    
    CBMSR <- function(t, state, parameters){
        with(as.list(c(state, parameters)),{
            
            dPR <- X1
            dX1 <- eta_pr*(PR - b_pr) + gamma1_pr*(EP - b_ep)
            + gamma2_pr*(PR - b_pr)*(EP - b_ep)
            + gamma3_pr*(EP - b_ep)*dPR 
            dEP <- X2
            dX2 <- eta_ep*(EP - b_ep) + gamma1_ep*(PR - b_pr)
            + gamma2_ep*(PR - b_pr)*(EP - b_ep)
            + gamma3_ep*(PR - b_pr)*dEP
            
            list(c(dPR, dX1, dEP, dX2))
            
        })
    }
 
    
    times <- seq(0, timeLimit, length.out = NumSamples)
    
    sol <- ode(func = CBMSR, y = state, 
                times = times, parms = ParameterList)
    
    library(ramify)
    sol[,c("PR")] = clip(x = sol[,c("PR")], .min = 0, .max = 18)
    sol[,c("EP")] = clip(x = sol[,c("EP")], .min = 0, .max = 15)
    
    return(sol)
}