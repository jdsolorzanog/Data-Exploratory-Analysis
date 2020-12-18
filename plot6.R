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

EmissionsMotorLA <- NEI %>% 
  subset(fips == "06037" & NEI$SCC %in% VehSCC$SCC) %>%
  merge(y = VehSCC, by.x = "SCC", by.y = "SCC") %>%
  group_by(year) %>%
  summarize(Vehicle.Emissions.Type = sum(Emissions, na.rm = TRUE))

EmissionsMotorBalt2 <- cbind(EmissionsMotorBalt, "City" = rep("Baltimore", 4))
EmissionsMotorLA2 <- cbind(EmissionsMotorLA, "City" = rep("LA", 4))

EmissionsMotor <- rbind(EmissionsMotorBalt2, EmissionsMotorLA2)

# Generar gráfico
graphic <- ggplot(EmissionsMotor, aes(as.factor(year), Vehicle.Emissions.Type, col= City))
graphic <- graphic + geom_point(size=5) + xlab("Year") + ylab("Total Emissions") + ggtitle("Comparison of Total Annual Vehicle Emissions: Baltimore vs LA")
print(graphic)
