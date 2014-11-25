using Jags
using Base.Test

include(Pkg.dir("Jags", "test", "test_utils.jl"))

old = pwd()
ProjDir = Pkg.dir("Jags", "Examples", "Dyes")
cd(ProjDir)
println("Moving to directory: $(ProjDir)")

cd(ProjDir)
isdir("tmp") &&
  rm("tmp", recursive=true);

include(Pkg.dir(ProjDir, "jdyes.jl"))
clean_dir(jagsmodel)

cd(ProjDir)
isdir("tmp") &&
  rm("tmp", recursive=true);

cd(old)
