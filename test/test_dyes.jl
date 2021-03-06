using Jags
using Base.Test

ProjDir = joinpath(dirname(@__FILE__), "..", "Examples", "Dyes")
cd(ProjDir) do

  println("Moving to directory: $(ProjDir)")

  isdir("tmp") &&
    rm("tmp", recursive=true);

  include(Pkg.dir(ProjDir, "jdyes.jl"))

  isdir("tmp") &&
    rm("tmp", recursive=true);

end
