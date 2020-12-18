NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Cargar librería requerida
library(dplyr)

# Generar subconjunto de datos
SCC.coal.comb <- SCC[grep("[Cc]oal",SCC$EI.Sector),]
NEI.sub.coal <- subset(NEI, NEI$SCC %in% SCC.coal.comb$SCC)
NEI.coal.comb <- merge(x = NEI.sub.coal, y = SCC, by.x = "SCC", by.y = "SCC")
NEI.CCT <- NEI.coal.comb %>% 
  group_by(year) %>%
  summarize(Total.Coal.Comb = sum(Emissions, na.rm = TRUE))

# Generar gráfico
graphic <- ggplot(NEI.CCT, aes(as.factor(year), Total.Coal.Comb/1000))
graphic <- graphic + geom_col(fill="Aquamarine") + xlab("Year") + ylab("Total Emissions (Ton)") + ggtitle("Emissions from coal combustion-related sources in the US")
print(graphic)
