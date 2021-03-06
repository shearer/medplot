\name{plotSymptomsTimeline}
\alias{plotSymptomsTimeline}
\title{Plot timeline of symptom presence}
\usage{
plotSymptomsTimeline(data, date, personID, measurement, symptoms,
  displayFormat = "dates")
}
\arguments{
  \item{data}{The data frame used by the plot.}

  \item{date}{Name of variable containing dates.}

  \item{personID}{Name of variable containing person ID.}

  \item{measurement}{Name of variable containing measuring
  occasion info.}

  \item{symptoms}{Vector of variable names representing
  measured symptoms.

  for ggplot() (see melt()). Returns a ggplot object that
  has to be plotted via print().}
}
\description{
Function that plots symptom severity presence for patients
at a certain time.
}

