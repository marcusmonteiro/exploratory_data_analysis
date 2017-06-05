source('install_and_load_required_packages.R')
source('load_pm25_emissions_data.R')

MakePlot2 <- function() {
  file.name <- 'plot2.png'

  if (file.exists(file.name)) {
    file.remove(file.name)
  }

  png(file.name)

  baltimore.city.fips <- '24510'

  total.emissions.by.year <- summary.scc.pm25.data %>%
    filter(fips == baltimore.city.fips) %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions))

  plot(total.emissions.by.year,
       main = 'Baltimore City, Maryland, Total PM2.5 Emissions',
       xaxt='n')

  axis(1, at = total.emissions.by.year$year,
       labels = total.emissions.by.year$year)

  dev.off()

}

MakePlot2()
