using JuMP, Clp , Printf

demand = [40 60 75 25 0]    

//worktypes = [:regular, :overtime, :maintenance]
//cost = Dict( zip( worktype, [ 400, 450, 20 ] ) )
//inventory = Dict( zip( worktype [0, 0, 10]) )

m = Model(with_optimizer(Clp.Optimizer))

@variable(m, regularwork[1:4] <= 40)       
@variable(m, overtimework[1:4] >= 0)             

@variable(m, held[1:5] >= 0)            

@constraint(m, held[1] == 10 + regularwork[1] + overtimework[1] - demand[1])
@constraint(m, held[2] == held[1] + regularwork[2] + overtimework[2] - demand[2])
@constraint(m, held[3] == held[2] regularwork[3] + overtimework[3] - demand[3])
@constraint(m, held[1] == held[3] + regularwork[4] + overtimework[4] - demand[4]) 

@objective(m, Min, 400*sum(regularwork) + 450*sum(overtimework) + 20*sum(held))

status = optimize!(m)

@printf("Boats with regular labour: %d %d %d %d \n", value(regularwork[1]), value(regularwork[2]), value(regularwork[3]), value(regularwork[4]))
@printf("Boats with overtime labour: %d %d %d %d \n", value(overtimework[1]), value(overtimework[2]), value(overtimework[3]), value(overtimework[4]))
@printf("Monthly inventories %d %d %d %d %d\n ", value(held[1]), value(held[2]), value(held[3]), value(held[4]), value(held[5]))

@printf("Total cost: %f\n", objective_value(m))