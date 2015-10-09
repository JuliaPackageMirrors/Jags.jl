import Base: *

if !isdefined(Main, :Stan)
  function *(c1::Cmd, c2::Cmd)
    res = deepcopy(c1)
    for i in 1:length(c2.exec)
      push!(res.exec, c2.exec[i])
    end
    res
  end

  function *(c1::Cmd, sa::Array{ASCIIString, 1})
    res = deepcopy(c1)
    for i in 1:length(sa)
      push!(res.exec, sa[i])
    end
    res
  end

  function *(c1::Cmd, s::ASCIIString)
    res = deepcopy(c1)
    push!(res.exec, s)
    res
  end
end

function par(cmds::Array{Base.AbstractCmd,1})
  if length(cmds) > 2
    return(par([cmds[1:(length(cmds)-2)],
      Base.AndCmds(cmds[length(cmds)-1], cmds[length(cmds)]);]))
  elseif length(cmds) == 2
    return(Base.AndCmds(cmds[1], cmds[2]))
  else
    return(cmds[1])
  end
end

function par(cmd::Base.AbstractCmd, n::Number)
  res = deepcopy(cmd)
  if n > 1
    for i in 2:n
      res = Base.AndCmds(res, cmd)
    end
  end
  res
end

function par(cmd::Array{ASCIIString, 1})
  res = `$(cmd[1])`
  for i in 2:length(cmd)
    res = res*` $(cmd[i])`
  end
  res
end

