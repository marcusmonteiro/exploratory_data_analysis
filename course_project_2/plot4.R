source('install_and_load_required_packages.R')
source('load_pm25_emissions_data.R')

MakePlot4 <- function() {
  file.name <- 'plot4.png'

  if (file.exists(file.name)) {
    file.remove(file.name)
  }

  source.classification.code.data.coal.combustion.related.sources <- source.classification.code.data %>%
    filter(str_detect(Short.Name, 'Comb') & str_detect(Short.Name, 'Coal'))

  emissions.by.year.coal.combustion.related.sources <- summary.scc.pm25.data %>%
    filter(SCC %in% source.classification.code.data.coal.combustion.related.sources$SCC) %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions))

  qplot(year, Emissions, data = emissions.by.year.coal.combustion.related.sources,
        main = 'United States\' Coal Combustion Related PM2.5 Emissions, per Year') +
    scale_x_continuous(breaks = unique(emissions.by.year.coal.combustion.related.sources$year))

  ggsave(file.name)

}

MakePlot4()
