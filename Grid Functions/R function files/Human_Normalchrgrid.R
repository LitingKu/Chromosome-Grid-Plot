
# The function is create by: Li-Ting, Ku

#library(openxlsx)
#library(readxl)
#library(xlsx)
#library(biomaRt)
library(dplyr)
library(scales)
library(ComplexHeatmap)
library(viridis)

# df_list : dataframe list, example : df_list = list(df1, df2)

# model_name: the name of your dataframe, this is the vector, example : model_name = c("p53 PDO shR-sh1","p53 PDO shR-sh2")

# title: The final grid plot title, example : title =c ("Plots for All Events")

Human_Normalchrgrid <- function(df_list,model_name, title){
  ############ This is the Human Chromosome Band Information ########################
  Band <- c("1 p","1 q","2 p","2 q","3 p","3 q","4 p","4 q","5 p","5 q","6 p","6 q","7 p","7 q","8 p","8 q",
            "9 p","9 q","10 p", "10 q", "11 p", "11 q", "12 p", "12 q", "13 p", "13 q", "14 p","14 q", "15 p", "15 q", "16 p", "16 q",
            "17 p" ,"17 q", "18 p", "18 q", "19 p", "19 q", "20 p","20 q", "21 p", "21 q", "22 p","22 q", "X p", "X q", "Y p", "Y q")
  b <- as.data.frame(Band)
  name <- c("Band","Freq")
  hchr <- read.csv("./Bands data/Humanchromosome_arm_number.csv")

  ########### Construct the data frame of frequency in each model ###################
  Frequecy_List <- NULL
  for(i in 1:length(df_list)){
    df <- df_list[[i]]
    df$chrband<- paste(df$chromosome_name,substr(df$band, 0, 1))
    df_Freq <- as.data.frame(table(df$chrband))
    df_Freq <- df_Freq[which(df_Freq$Var1 %in% c(Band)),]
    colnames(df_Freq) <-name
    dfFreq <- merge(df_Freq,b,by="Band", all=TRUE)
    dfFreq <- dfFreq[order(factor(dfFreq$Band,levels=Band)),]
    dfFreq$Freq <- as.numeric(dfFreq$Freq)
    dfFreq[is.na(dfFreq)]<-0
    ## Normalized by band: Density
    dfFreq$Freq  <- dfFreq$Freq/hchr$Freq
    dfFreq$Freq <- dfFreq$Freq /sum(dfFreq$Freq)
    dfFreq<-as.data.frame(t(dfFreq))
    colnames(dfFreq) <- Band
    dfFreq <- dfFreq[-1,]
    rownames(dfFreq)<- unique(model_name[i])
    Frequecy_List[[i]] <- dfFreq
  }
  all <- do.call(rbind, Frequecy_List)
  ########### Heatmap for grid plot #####################
  split <- data.frame(rownames(all))
  split$rownames.all. <- factor(split$rownames.all., model_name)
  all <- all %>%mutate_all(funs(as.numeric(as.character(.))))
  ## lengends
  x <- c(0,round(max(all),2)/2, round(max(all),2))
  y <- c(label_percent()(x))
  Grid <- Heatmap(all,column_title = title, col=c("white","red","dark red"),
                  column_title_gp = gpar(fontsize = 14, fontface = "bold"),
                  rect_gp = gpar(col = "lightgray", lwd = 1.5),
                  #color = colorRampPalette(c("white","red"))(6),
                  heatmap_legend_param = list(title = "% of Total events", at = x, labels = y),
                  row_names_side = "left",
                  #left_annotation = rowanno , #top_annotation = col_anno ,
                  row_split = split, 
                  show_column_names = TRUE,show_row_names = TRUE,
                  cluster_rows = FALSE , cluster_columns  = FALSE, show_heatmap_legend = TRUE, row_title=NULL)
  
  return(list(all, Grid))
}




