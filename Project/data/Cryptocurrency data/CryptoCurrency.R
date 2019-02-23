library(RODBC)
con <- odbcConnect("CryptoCurrency")

tbls <- sqlTables(con)
tbls$TABLE_NAME[60][[1]]
bc <- sqlFetch(con, "Bitcoin_price")
mynamestheme <- theme(plot.title = element_text(family = "Helvetica", face = "bold", size = (15)), 
                      legend.title = element_text(colour = "steelblue",  face = "bold.italic", family = "Helvetica"), 
                      legend.text = element_text(face = "italic", colour="steelblue4",family = "Helvetica"), 
                      axis.title = element_text(family = "Helvetica", size = (10), colour = "steelblue4"),
                      axis.text = element_text(family = "Courier", colour = "cornflowerblue", size = (10)))

tableNames <- c("Bitcoin_price", "bitconnect_price", "dash_price", "ethereum_price", "iota_price", "litecoin_price", "monero_price", "nem_price", "neo_price", "numeraire_price", "omisego_price", "qtum_price", "ripple_price", "stratis_price", "waves_price")
for (i in tableNames) {
  bc <- sqlFetch(con, i)
  graphetty <- ggplot(bc, aes(Date, Close, color = `Market Cap`)) + geom_point()
  print(graphetty + ggtitle(i)) 
  pdf(paste(i, ".pdf"))
  graphetty <- ggplot(bc, aes(Date, Close, color = `Market Cap`)) + geom_point()
  gsub("_", " ", i)
  print(graphetty + mynamestheme + labs(title= i))
  dev.off()
}


