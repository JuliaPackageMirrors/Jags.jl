using Jags
using Base.Test

old = pwd()
path = @windows ? "\\Examples\\JMW" : "/Examples/JMW"
ProjDir = Pkg.dir("Jags")*path
cd(ProjDir)
println("Moving to directory: $(ProjDir)")

for i in 0:8
  isfile("CODAchain$(i).txt") && rm("CODAchain$(i).txt")
  isfile("jmw-inits$(i).R") && rm("jmw-inits$(i).R")
end
isfile("CODAindex.txt") && rm("CODAindex.txt")
isfile("CODAindex0.txt") && rm("CODAindex0.txt")
isfile("CODAtable0.txt") && rm("CODAtable0.txt")
isfile("jmw-data.R") && rm("jmw-data.R")
isfile("jmw.bugs") && rm("jmw.bugs")
isfile("jmw.jags") && rm("jmw.jags")
isfile("jjmwautocormeanplot.svg") && rm("jjmwautocormeanplot.svg")
isfile("jjmwsummaryplot.svg") && rm("jjmwsummaryplot.svg")
isfile("jjmwsummaryplot2.svg") && rm("jjmwsummaryplot2.svg")

include(ProjDir*@windows ? "\\" : "/"*"jjmw.jl")

for i in 0:8
  isfile("CODAchain$(i).txt") && rm("CODAchain$(i).txt")
  isfile("jmw-inits$(i).R") && rm("jmw-inits$(i).R")
end
isfile("CODAindex.txt") && rm("CODAindex.txt")
isfile("CODAindex0.txt") && rm("CODAindex0.txt")
isfile("CODAtable0.txt") && rm("CODAtable0.txt")
isfile("jmw-data.R") && rm("jmw-data.R")
isfile("jmw.bugs") && rm("jmw.bugs")
isfile("jmw.jags") && rm("jmw.jags")
#isfile("jjmwautocormeanplot.svg") && rm("jjmwautocormeanplot.svg")
#isfile("jjmwsummaryplot.svg") && rm("jjmwsummaryplot.svg")
#isfile("jjmwsummaryplot2.svg") && rm("jjmwsummaryplot2.svg")

cd(old)
