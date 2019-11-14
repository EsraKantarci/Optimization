using JuMP, Clp , Printf

demand = [40 60 75 25 0]                  

m = Model(with_optimizer(Clp.Optimizer))

@variable(m, regular[1:5] <= 40) 
@variable(m, overtime[1:5] >= 0) 
@variable(m, held[1:5] >= 0)            

@constraint(m, held[1] == 10)
@constraint(m, flow1[i in 1:4], held[i]+regular[i]+overtime[i]-demand[i]==held[i+1]) 

@objective(m, Min, 400*sum(regular) + 450*sum(overtime) + 20*sum(held))    

status = optimize!(m)

@printf("Boats with regular labour: %d %d %d %d \n", value(regular[1]), value(regular[2]), value(regular[3]), value(regular[4]))
@printf("Boats with overtime labour: %d %d %d %d \n", value(overtime[1]), value(overtime[2]), value(overtime[3]), value(overtime[4]))
@printf("Monthly inventories %d %d %d %d %d\n ", value(held[1]), value(held[2]), value(held[3]), value(held[4]), value(held[5]))

@printf("Total cost: %f\n", objective_value(m))