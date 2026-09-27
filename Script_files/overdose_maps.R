# =============================================================
# AEM 6850: replicate the NY Times county maps of drug overdose deaths in the US, 1999-2016
# -------------------------------------------------------------
# =============================================================

# -------------------------------------------------------------
# 1). Preliminary -----
# -------------------------------------------------------------

# Load libraries
library("maps")

# Working directories
dir <- list()
dir$root <- dirname(getwd())
dir$Data <- paste(dir$root,"/Data",sep="")
dir$Cleaned_data <- paste(dir$root,"/Cleaned_data",sep="")
dir$Output_figure <- paste(dir$root,"/Output_figure",sep="")

# -------------------------------------------------------------
# 2. Cleaning data
# -------------------------------------------------------------

# Importing drug mortality data
data <- read.csv(paste(dir$Data,"NCHS_-_Drug_Poisoning_Mortality_by_County__United_States_20250924.csv",sep="/"))
# Make a cleaned data set
data2 <- data

# Remove symbols +, < and then split where "-" shows up
temp <- strsplit(gsub("[<,+]","",data2[,7]),"-")
lapply(temp, as.numeric)
sapply(temp, function(i) min(as.numeric(i)))

data2$low <- sapply(temp, function(i) min(as.numeric(i)))
data2$high <- sapply(temp, function(i) max(as.numeric(i)))

# Save cleaned data as CSV file in Cleaned data folder
write.csv(data2, paste(dir$Cleaned_data, "data2.csv", sep = "/"), row.names = FALSE)

# Save as PNG in Output_figure folder
png(filename = paste(dir$Output_figure, "overdose_deaths_by_county.png", sep = "/"), 
    width = 900*4, height = 350*4, res = 100*4)

# -------------------------------------------------------------
# 3. Create matrix layout for multi-panel plots
# -------------------------------------------------------------

# Multi panel plots:
# Create a "layout" matrix
par(mar=c(.25,.25,.25,.25), oma=c(2,2,2,2)) # add some outer margins
lmat <- matrix(c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18), nrow=3, byrow=T)
layout(lmat, widths=rep(1,6), heights=rep(1,3))

# -------------------------------------------------------------
# 4. Creating the map
# -------------------------------------------------------------

# Create vector of colors to call on
color = c("#A6C8E9","#DEECF7","#F8EEC0","#FFC065","#F8832E","#D81D0A")

# Function that takes year and breaks as arguments and generates USA maps from 1999-2016
Mortality_overdose_map <- function(year, data2, 
                                   breaks = c(0, 3.9, 7.9, 11.9, 15.9, 19.9, 30),
                                   colors = color) {
  
  # Filter data for given year
  given_year <- subset(data2, Year == year)
  
  # Assign color buckets
  assign_bucket <- function(low, high, breaks) {
    bucket <- max(which(low <= breaks[-1] & high > breaks[-length(breaks)])) # Gives indices for which bin the low-high interval falls into
    return(bucket)
  }
  given_year$colorBuckets <- mapply(assign_bucket, given_year$low, given_year$high, MoreArgs=list(breaks=breaks)) # Creates a new column that breaks down each row into assigned colored buckets
  
  # Match county FIPS codes and given_year for correct map coloring
  cnty.fips <- county.fips$fips[match(map("county", plot=FALSE)$names, county.fips$polyname)]
  colorsmatched <- given_year$colorBuckets[match(cnty.fips, given_year$FIPS)]
  
  # Draw map
  map("county", col = colors[colorsmatched], fill = TRUE, lty = 0, border = NA, projection = "polyconic") 
  
  # Add year label
  mtext(year, side = 1, line = -1, cex = .7, adj = 0.65)
}

# Plot the US maps after the function
years <- 1999:2016
for (x in years) {
  Mortality_overdose_map(x, data2)
}

# -------------------------------------------------------------
# 5. Creating the legend for the map
# -------------------------------------------------------------

# Add y-axis title
mtext(expression(bold("Overdose deaths") ~ " per 100,000"), # expression () allows one to write formatted text, allowing part of the text to be bold
      side = 3, outer = TRUE, line = 0.75, cex = .55)

# Draw rectangle
par(xpd = NA)  # Draw outside of plot in margins
leftx <- seq(from = -2.55, by = 0.16, length.out = length(color)) # Specifies the location of the first rectangle and the other rectangles afterwards
rect(xleft=leftx, xright=leftx+.16, ybottom=2.15, ytop=2.18, col=color, border=NA)

# Plot tick marks inbetween rectangles
ticks <- head(leftx + 0.16, -1) # Plots all vertical lines on the right part of each rectangle except for the last
for (x in ticks) {
  lines(x = c(x, x), y = c(2.14, 2.18), lty = 1, lwd = .6)
}

# Add labels under tick marks
text(x = ticks, y = 2.13, labels = c("4", "8", "12", "16", "20"), cex = .8, srt = 0, adj = c(0.5, 1))

# Finish saving png, shut off display
dev.off()

sessionInfo()



