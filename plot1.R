NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Agrupar y consolidar emisiones por año
TEY <- aggregate(Emissions ~ year, NEI, sum)
# Generar gráfico
barplot(names.arg =TEY$year,
        height = TEY$Emissions/1000,
        xlab = "Year",
        ylab = "Emissions (Ton)",
        col="Aquamarine",
        main = "Aggregated PM2.5 Emmisions")
