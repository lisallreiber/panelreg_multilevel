# is there a way to show the packages used from this doc?
# insert further information tab at the bottom
# insert conf.int = T for all tidy models
# insert about list with useful link:
      - html layout: https://rmarkdown.rstudio.com/html_document_format.html#tabbed_sections
      
interpretation:
      regression output: https://stats.idre.ucla.edu/stata/output/regression-analysis/
      textbook examples: https://stats.idre.ucla.edu/other/examples/alda/
      applied regression analysis: https://stats.idre.ucla.edu/stata/examples/ara/applied-regression-analysis-by-john-foxchapter-7-dummy-variable-regression/
      https://stats.idre.ucla.edu/stata/webbooks/reg/chapter3/regression-with-statachapter-3-regression-with-categorical-predictors/
      annotated output: https://stats.idre.ucla.edu/other/annotatedoutput/
      descriptive statistics: https://stats.idre.ucla.edu/stata/output/descriptive-statistics-using-the-summarize-command/
      
helpful websites:
      - http://data.princeton.edu/R/linearModels.html

      
      

ex_0 create:
- # to do : build function to deflate income to a certain year, even better, automatically getting the data

Ex1:
      # ergebnis3 <- ex1 %>% 
      #       group_by(syear, ost, erwstatus) %>%
      #       select()
      
      # to do merge so that totals are also in output
      # ergebnis3 <- merge(ergebnis2, ergebnis1, by=c("syear", "ost"), incomparables = NA)
      # try addmargins()
      # try this https://stackoverflow.com/questions/33565949/add-row-to-data-frame-with-dplyr
      # also try add_tally()
      # for ergebnis3 http://www.stats.uwo.ca/faculty/murdoch/ism2013/4tables.pdf
      
Ex2:
      2.1
      # alternative but not such a nice layout      
      # summarize_all(funs(sum, mean, sd, min,max))
      # for export to latex file                    
      # latex(summary())
# to do: make a link to a varia section where you specify the different possibilities of histograms
# histogram
      cut out:
            
                        asample %>% 
                            filter(syear == 2015) %>% 
                            filter(row_number() %in% esample) %>%
                            mutate(cpgbilzeit = pgbilzeit - mean(pgbilzeit, na.rm = T)) %>% 
                            ggplot(aes(cpgbilzeit, hwageb)) + 
                            geom_point() + 
                            geom_smooth(method="lm", color="red", se=F) +
                            geom_line(aes(y = mean(asample$hwageb)), color="blue"))
      
      # - N used
      esample.n <- nobs(fit2.1) # only for panel structure
      pdim(fit2.1)
      
      ###### check if mean close to 0
      it is not 
      ```{r mean close to 0 fit2.1}
      mean(fit2.1$residuals)    # no
      ```
      
      ###### Correlation Resid + Predict
      Check the correlation between the residuals and the predictors to see if it's close to 0.
      ```{r}
      # cov(fit2.1$residuals, asample$pgbilzeit)      # no
      ```
      
# Notes 
***
      #' Not include 
      
      fit <- lm(speed ~ dist, data= cars)
      # - N used
      esample.n <- nobs(fit)
      # - Sample identifier, a set of row names which can be used to subset the corresponding dataframe
      
      esample<-rownames(as.matrix(resid(fit)))
      # E.g. subsetting
      cars[esample,] #trivial here since all obs are included
      
Ex3:

      3.6: etwas mehr notes wenns geht
      
      links: https://rdrr.io/github/strengejacke/ggeffects/man/ggpredict.html (margins effect plot)
      https://cran.r-project.org/web/packages/ggeffects/vignettes/marginaleffects.html (marginal effect tables)
      
      
Ex4: 
      cut out:
      * twoway (connected bildungsrendite syear, sort) (line upper lower syear, sort)
* nicht ideal, weil Daten nicht wie Aggregatdaten behandelt werden, deshalb collapse
*twoway (connected bildungsrendite_ost syear, sort) (line upper lower syear, sort) 
* twoway (connected genderrev syear, sort) (line upper lower syear, sort)
* nicht ideal, weil Daten nicht wie Aggregatdaten behandelt werden, deshalb collapse

      cut out xtsum:
            # library(tibble)
            # library(dplyr)
            # # df is the dataframe, 
            # # columns is a numerical vector to subset the dataframe (variable)
            # # and individuals is the column with the individuals.
            # 
            #  xtsumR<-function(df, columns,individuals){
            #                      df<- df[order(individuals),]
            #                      panel<- data.frame()
            #                      for (i in columns){
            #                            v <- df %>% 
      #                                  filter(!is.na(columns)) %>% 
      #                                  dplyr::summarize(
      #                                        mean= mean(df[[i]], na.rm = T),
      #                                        sd= sd(df[[i]], na.rm = T),
      #                                        min= min(df[[i]]),
      #                                        max= max(df[[i]])
      #                                  )
      #                      }
      #                      return(v)
      #  }
      #                            v<-tibble::add_column(v, variacao="overal",.before=-1)
      #                            v2<-stats::aggregate(df[[i]],list(df[[individuals]]),"mean")[[2]]
      #                            sdB<- sd(v2, na.rm = T)
      #                            varW<-df[[i]]-rep(v2,each=12) #
      #                            varW<-varW+mean(df[[i]], na.rm = T)
      #                            sdW<-sd(varW, na.rm = T)
      #                            minB<-min(v2)
      #                            maxB<-max(v2)
      #                            minW<-min(varW)
      #                            maxW<-max(varW)
      #                            v<-rbind(v,c("between",NA,sdB,minB,maxB),c("within",NA,sdW,minW,maxW))
      #                            panel<-rbind(panel,v)
      #                      }
      #                      var<-rep(names(df)[columns])
      #                      n1<-rep(NA,length(columns))
      #                      n2<-rep(NA,length(columns))
      #                      var<-c(rbind(var,n1,n1))
      #                      panel$var<-var
      #                      panel<-panel[c(6,1:5)]
      #                      names(panel)<-c("variable","variation","mean","standard.deviation","min","max")
      #                      panel[3:6]<-as.numeric(unlist(panel[3:6]))
      #                      panel[3:6]<-round(unlist(panel[3:6]),2)
      #                      return(panel)
      #  }
      #  
      #  xtsumR(asample,c(86),"pid")
      
      
      # from: https://stackoverflow.com/questions/49282083/xtsum-command-for-r
      
      # 
      #   
      # ores <- asample %>% summarise(ovr.mean=mean(lnwage, na.rm=TRUE),
      #                            ovr.sd=sd(lnwage, na.rm=TRUE), 
      #                            ovr.min = min(lnwage, na.rm=TRUE), 
      #                            ovr.max=max(lnwage, na.rm=TRUE),
      #                            ovr.N=sum(as.numeric((!is.na(lnwage)))))
      # 
      # ores
      # 
      # bmeans <- asample %>% 
      #       group_by(syear) %>% 
      #       summarise(meanx = mean(pid, na.rm = T), 
      #                 minx = min()
      #                 t.count = sum(as.numeric(!is.na(lnwage)))) %>% 
      #       ungroup()
      # 
      # bmeans
      # 
      # bres <- bmeans %>% 
      #       summarise(between.sd = sd(meanx, na.rm=TRUE), 
      #                 between.min = min(meanx, na.rm=TRUE), 
      #                 between.max=max(meanx, na.rm=TRUE),
      #                 Units = sum(as.numeric(!is.na(t.count))), 
      #                 t.bar = mean(t.count, na.rm=TRUE))
      # 
      # bres
      # 
      # wdat <- asample %>% 
      #       group_by(pid) %>% 
      #       mutate(W.x = scale(lnwage, scale=FALSE))
      # 
      # wres <- wdat %>% 
      #       ungroup() %>% 
      #       summarise(within.sd=sd(W.x, na.rm=TRUE), 
      #                 within.min=min(W.x, na.rm=TRUE), 
      #                 within.max=max(W.x, na.rm=TRUE))
      # 
      # list(ores=ores,bres=bres,wres=wres)
      
      # # within year- variance
      # asample %>% group_by(syear) %>% summarise(lnwage_var = var(lnwage, na.rm = T))
      # 
      # # within person variance
      # asample %>% group_by(pid) %>% summarise(var(lnwage, na.rm = T), var(frau), var(ost)) 
      # 
      # # reshape data
      # library(reshape2)
      # # into molten form
      # dat.m <- melt(asample,id.vars=c('pid','syear'))
      # 
      # # mom1 means for all variable
      # dat.m %>% 
      #       filter(variable == "lnwage") %>% 
      #       mutate(value = as.numeric(value))%>% 
      #       acast(variable~syear, mean, na.rm = T)
      # 
      # 
      # %>% 
      #       str()
      #       
      #       
      #       summarize(mean = mean(lnwage))
      # head(dat.m)
      # 
      # 
      # Mean.Weights <- with(asample, tapply(X = lnwage,  # X is the critical DV
      #                          INDEX = syear, # INDEX is the grouping variable
      #                          FUN = mean # FUN is the aggregation function
      #                          ))
      # 
      # 
      #       asample %>% # Start by defining the original dataframe, AND THEN...
      #                 group_by(syear) %>% # Define the grouping variable, AND THEN...
      #                 dplyr:: summarise( # Now you define your summary variables with a name and a function...
      #                           Observations = n(),  ## The function n() in dlpyr gives you the number of observations
      #                           Mean.lnwage = mean(lnwage, na.rm = T),
      #                           SD.lnwage = sd(lnwage, na.rm = T)
      #                           ) %>%
      #             summarise(bres = mean(Mean.lnwage))
      # 
      
      