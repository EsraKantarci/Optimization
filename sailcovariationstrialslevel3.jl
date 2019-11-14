# the types of trophies produced
worktype = [:regular, :overtime]

# ingredients involved
inventoryitems = [:builtbyregular, :builtbyovertime, :held]

# profits returned (for each sport)
cost = Dict( zip( worktype, [ 400, 450 ] ) )


# recipes (sport, ingredient)
using NamedArrays
demands = [40,60,70,25]
;

using JuMP, Clp
m = Model(with_optimizer(Clp.Optimizer))

@variable(m, boats[worktype] >= 0 )
@expression(m, totalcost, sum(boats[s]*cost[s] for s in worktype) )
@constraint(m, boats[regular]<=40)
@constraint(m, 
@objective(m, Max, total_profit )

optimize!(m)
println(value(trophies[:football]))
println(value(trophies[:soccer]))
println("Total profit is: \$", value(total_profit))

//this will not work
