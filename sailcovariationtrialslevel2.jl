

work_types = [:regular, :overtime]
work_cost   = Dict( :regular => 400, :overtime => 450)
inventorycost = 20
months = [:first, :second, :third, :forth, :fifth]
demands = Dict( :first => 40, :second => 60, :third => 70, :forth =25, :fifth=0 )
;

using JuMP, Clp

m = Model(with_optimizer(Clp.Optimizer))

@variable(m, boats[work_types] >= 0 )    # "boats" is a dictionary indexed over sports
@variable(m, inventory[months] >=0 )

@expression(m, totalboatbuilt, sum(boats[i] for i in work_types) )
@expression(m, totalbuiltcost, sum(boats[i]*work_cost[i] i in months) )
@expression(m, totalcost,  sum(totalbuiltcost[i] i in months)+sum(inventorycost*inventory[i] i in months)

@constraint(m, inventory[i+1]= inventory[i]+totalboatbuilt[i]-demands[i] i in months)
@constraint(m, boats[:regular] <= 40 )      # maximum number of soccer balls
@constraint(m, boats[:overtime] >= 0 )  # maximum number of footballs
@constraint(m, demands[months] <= inventory[months] )           # maximum number of plaques
@constraint(m, flow[i in months], (inventory[i] + totalboatbuilt[i] - demands[i] >= 0) )  

@objective(m, Min, totalcost)


status = optimize!(m)

//nope, this would not work.
