NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Generar subconjunto de datos para Baltimore
baltimore <- NEI[NEI$fips=="24510", ]

# Consolidar las emisiones por año
BYE <- aggregate(Emissions ~ year, baltimore, sum)

# Generar gráfico
barplot(names.arg =BYE$year,
        height = BYE$Emissions,
        xlab = "Year",
        ylab = "Emissions",
        col="Aquamarine",
        main = "Aggregated PM2.5 Emmisions in Baltimore")
