DownloadPM25EmissionsDataSet <- function() {
  # Download the project's data set if the data set directory does not exists.

  data.set.file <- 'summarySCC_PM25.rds'

  if (!file.exists(data.set.file)) {
    data.set.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
    temp <- tempfile()
    download.file(data.set.url, temp)
    unzip(temp)
  }
}

ReadSummarySCCPM25Data <- function() {
  DownloadPM25EmissionsDataSet()

  summary.scc.pm25.data <- readRDS('summarySCC_PM25.rds')

  mutate(summary.scc.pm25.data,
         fips = as.factor(fips),
         SCC = as.factor(SCC),
         Pollutant = as.factor(Pollutant),
         type = as.factor(type))
}

ReadSourceClassificationCodeData <- function() {
  DownloadPM25EmissionsDataSet()

  readRDS('Source_Classification_Code.rds')
}

if (!exists('summary.scc.pm25.data')) {
  summary.scc.pm25.data <- ReadSummarySCCPM25Data()
}

if (!exists('source.classification.code.data')) {
  source.classification.code.data <- ReadSourceClassificationCodeData()
}
