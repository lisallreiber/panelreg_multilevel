# Preparing R -------------------------------------------------------------

# Load EDV-Reg function
# source("edvreg.R")

# Packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(
      broom,
      effects,
      foreign,
      ggeffects,
      haven,
      influence.ME,
      interplot,
      lfe,
      lme4,
      lmtest,
      lubridate,
      lm.beta,
      pastecs,
      plyr,
      plm,
      pglm,
      readstata13,
      readxl,
      rlang,
      sandwich,
      sjlabelled,
      sjmisc,
      sjPlot,
      sjstats,
      stargazer,
      strucchange,
      # those beneath always load last
      ggplot2,
      tidyverse)


#options(scipen = 100)
options(digits = 2)



