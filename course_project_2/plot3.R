source('install_and_load_required_packages.R')
source('load_pm25_emissions_data.R')

MakePlot3 <- function() {
  file.name <- 'plot3.png'

  if (file.exists(file.name)) {
    file.remove(file.name)
  }

  baltimore.city.fips <- 24510

  baltimore.total.emissions.by.year <- summary.scc.pm25.data %>%
    filter(fips == baltimore.city.fips) %>%
    group_by(year, type) %>%
    summarise(Emissions = sum(Emissions))

  baltimore.total.emissions.by.year.types <- unique(baltimore.total.emissions.by.year$type)

  ggplot(baltimore.total.emissions.by.year, aes(year, Emissions)) +
    facet_wrap(~type) +
    ggtitle('Baltimore City, Maryland, PM2.5 Emissions of different types, by year') +
    scale_x_continuous(breaks = unique(baltimore.total.emissions.by.year$year)) +
    geom_point() +
    theme(panel.spacing.x = unit(2, 'lines'))

  ggsave(file.name)

}

foo <- MakePlot3()
