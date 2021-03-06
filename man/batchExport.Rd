% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Export.R
\name{batchExport}
\alias{batchExport}
\title{Export Objects to the Slaves}
\usage{
batchExport(export = list(), unexport = character(0L),
  reg = getDefaultRegistry())
}
\arguments{
\item{export}{[\code{list}]\cr
Named list of objects to export.}

\item{unexport}{[\code{character}]\cr
Vector of object names to un-export.}

\item{reg}{[\code{\link{Registry}}]\cr
Registry. If not explicitly passed, uses the default registry (see \code{\link{setDefaultRegistry}}).}
}
\value{
[\code{data.table}] with name and uri to the exported objects.
}
\description{
Objects are saved in subdirectory \dQuote{exports} of the
\dQuote{file.dir} of \code{reg}.
They are automatically loaded and placed in the global environment
each time the registry is loaded or a job collection is executed.
}
\examples{
tmp = makeRegistry(file.dir = NA, make.default = FALSE)

# list exports
exports = batchExport(reg = tmp)
print(exports)

# add a job and required exports
batchMap(function(x) x^2 + y + z, x = 1:3, reg = tmp)
exports = batchExport(export = list(y = 99, z = 1), reg = tmp)
print(exports)

submitJobs(reg = tmp)
waitForJobs(reg = tmp)
stopifnot(loadResult(1, reg = tmp) == 101)

# Un-export z
exports = batchExport(unexport = "z", reg = tmp)
print(exports)
}
