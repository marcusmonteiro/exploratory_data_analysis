source('install_and_load_required_packages.R')
source('load_pm25_emissions_data.R')

MakePlot6 <- function() {
  file.name <- 'plot6.png'

  if (file.exists(file.name)) {
    file.remove(file.name)
  }

  source.classification.code.data.motor.vehicle.related.sources <- source.classification.code.data %>%
    filter(str_detect(Short.Name, 'Veh'))

  baltimore.city.fips <- '24510'
  los.angeles.county.fips <- '06037'

  cities.emissions.by.year.motor.vehicle.related.sources <- summary.scc.pm25.data %>%
    filter(fips == baltimore.city.fips | fips == los.angeles.county.fips) %>%
    filter(SCC %in% source.classification.code.data.motor.vehicle.related.sources$SCC) %>%
    group_by(fips, year) %>%
    summarise(Emissions = sum(Emissions)) %>%
    mutate(percentual.change.from.1999 = (Emissions - Emissions[year == 1999]) / Emissions[year == 1999]) %>%
    mutate(County = ifelse(fips == baltimore.city.fips, 'Baltimore City, Maryland', 'Los Angeles County'))

  ggplot(cities.emissions.by.year.motor.vehicle.related.sources, aes(year, percentual.change.from.1999)) +
    facet_wrap(~County) +
    ggtitle('Motor Vehicle Related PM2.5 Emissions Percentual Change from 1999 value, per Year') +
    scale_x_continuous(breaks = unique(cities.emissions.by.year.motor.vehicle.related.sources$year)) +
    geom_point()

  ggsave(file.name)
}

MakePlot6()
