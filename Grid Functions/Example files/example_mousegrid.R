
### Example ###

setwd("/Users/litingku/Desktop/Grid Functions")
source("./R function files/Mouse_chrgrid.R")

## read data file
model1 <- read.csv("./Example files/model1.csv")
model2 <- read.csv("./Example files/model2.csv")
model3 <- read.csv("./Example files/model3.csv")

df_list <- list(model1, model2, model3)
model_name <- c("p53", "RBM10","SF3B1")
title <- c("All Events in Mouse")

## run the function
output <- Mouse_chrgrid(df_list,model_name,title)

## get the frequecy table
Freq_table <- output[[1]]
# write into excel file
xlsx::write.xlsx(all,"Grid Frequency.xlsx", sheetName = "Mouse all events", append = TRUE)

## get the chromosome grid plot
grid_plot <- output[[2]]
# write into pdf
pdf("All_MouseGrid_events.pdf", height = 5, width = 10)
grid_plot
dev.off()

