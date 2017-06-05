source('install_and_load_required_packages.R')
source('load_pm25_emissions_data.R')

MakePlot5 <- function() {
  file.name <- 'plot5.png'

  if (file.exists(file.name)) {
    file.remove(file.name)
  }

  source.classification.code.data.motor.vehicle.related.sources <- source.classification.code.data %>%
    filter(str_detect(Short.Name, 'Veh'))

  baltimore.city.fips <- '24510'

  baltimore.city.emissions.by.year.motor.vehicle.related.sources <- summary.scc.pm25.data %>%
    filter(fips == baltimore.city.fips) %>%
    filter(SCC %in% source.classification.code.data.motor.vehicle.related.sources$SCC) %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions))

  qplot(year, Emissions, data = baltimore.city.emissions.by.year.motor.vehicle.related.sources,
        main = 'Baltimore City, Maryland, Motor Vehicle Related PM2.5 Emissions, per Year') +
    scale_x_continuous(breaks = unique(baltimore.city.emissions.by.year.motor.vehicle.related.sources$year))

  ggsave(file.name)

}

MakePlot5()
