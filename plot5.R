NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Cargar librería requerida
library(dplyr)

# Generar subconjunto de datos
VehSCC <- SCC[grep("[Vv]eh", SCC$Short.Name), ]
EmissionsMotorBalt <- NEI %>% 
  subset(fips == "24510" & NEI$SCC %in% VehSCC$SCC) %>%
  merge(y = VehSCC, by.x = "SCC", by.y = "SCC") %>%
  group_by(year) %>%
  summarize(Vehicle.Emissions.Type = sum(Emissions, na.rm = TRUE))

# Generar gráfico
graphic <- ggplot(EmissionsMotorBalt, aes(as.factor(year), Vehicle.Emissions.Type))
graphic <- graphic + geom_col(fill="Aquamarine") + xlab("Year") + ylab("Total Emissions") + ggtitle("Total Annual Vehicle Emissions in Baltimore City")
print(graphic)
