library(ncdf4)
library(tidyverse)
library(lubridate)
library(data.table)

dts <- seq(as.Date("1950-01-01"), as.Date("2100-12-31"), 1)
dts <- dts[-which(day(dts)==29 & month(dts)==2)]

fls <- list.files(path = ".", pattern = "*.nc")[1]
print(fls)
var <- word(fls,1,1,sep="_")

n <- nc_open(fls)
vdata <- ncvar_get(n, var)
print("Data extracted")
mat <- matrix(vdata, dim(vdata)[3], dim(vdata)[1]*dim(vdata)[2])
mat <- data.table(mat)
mat[, dts := dts]

makeSeason <- function(months) {
	print(months)
	subsetData <- mat %>% filter(month(dts) %in% months)
	if (var == "prAdjust") {
		subsetData <- setDT(subsetData)[, lapply(.SD, sum), by = year(dts)]
	} else {
		subsetData <- setDT(subsetData)[, lapply(.SD, mean), by = year(dts)]
	}
	return subsetData
}

ssns <- lapply(list(c(3,4,5),c(6,7,8),c(9,10,11)), makeSeason)

win <- mat %>% filter(month(dts) %in% c(12,1,2))
if (var == "prAdjust") {
	win <- setDT(win)[, lapply(.SD, sum), by = list(year(dts),month(dts))]
} else {
	win <- setDT(win)[, lapply(.SD, mean), by = list(year(dts),month(dts))]
}
win <- win[-c(1,2,nrow(win)), -c(1,2)]
win[, id := rep(seq(1,nrow(win)/3,1),each=3)]
if (var == "prAdjust") {
	win <- setDT(win)[, lapply(.SD, sum), by = id]
} else {
	win <- setDT(win)[, lapply(.SD, mean), by = id]
}

ssns[[4]] <- win

saveRDS(ssns, paste("./ssnlData/",var,"_",word(fls,5,6,sep="_"),".rds",sep=""), compress=F)

q()