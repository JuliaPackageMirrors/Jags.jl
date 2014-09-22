######### Jags program example  ###########

using Distributions, Jags

old = pwd()
path = @windows ? "\\Examples\\JMW" : "/Examples/JMW"
ProjDir = Pkg.dir("Jags")*path
cd(ProjDir)

jmw = "
model {
  for (i in 1:N) {
        x[i] ~ dnorm(mu, tau);
  }
  mu    ~ dnorm(0., 0.0001);
  tau   <- pow(sigma, -2);
  sigma ~ dunif(0, 100);
}
"

N = 1000
data = Dict{ASCIIString, Any}()
data["x"] = rand(Normal(0, 5), N)
data["N"] = N

inits = Dict{ASCIIString, Any}()
inits["mu"] = 1.0

monitors = (ASCIIString => Bool)[
  "mu" => true,
  "tau" => true,
  "sigma" => true,
]

jagsmodel = Jagsmodel(name="jmw", model=jmw, data=data, thin=1,
  adapt=250, update=1000, init=[inits], monitor=monitors);

println("\nJagsmodel that will be used:")
jagsmodel |> display
println("Input observed data dictionary:")
data |> display
println()

(index, chains) = jags(jagsmodel, ProjDir, updatejagsfile=true)

println()
chains[1]["samples"] |> display

mean_mu = mean(chains[1]["samples"]["mu"])
mean_sigma = mean(chains[1]["samples"]["sigma"])
mean_tau = mean(chains[1]["samples"]["tau"])
println()
println("Mean of mu: $(mean_mu)")
println("Mean of sigma: $(mean_sigma)")
println("Mean of tau: $(mean_tau)")
cd(old)