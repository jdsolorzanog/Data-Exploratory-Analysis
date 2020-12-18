NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Cargar librerías requeridas
library(ggplot2)

# Generar subconjunto de datos
baltimore <- NEI[NEI$fips=="24510", ]
BYTE <- aggregate(Emissions ~ year+ type, baltimore, sum)

# Generar gráfico
graphic <- ggplot(BYTE, aes(year, Emissions, color = type))
graphic <- graphic + geom_line() + xlab("year") + ylab("Total Emissions") + ggtitle("Total Emmisions by type in Baltimore")
print(graphic)
