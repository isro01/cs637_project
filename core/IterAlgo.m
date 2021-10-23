% Recursive relaxation algorithm for finding oprimal trajectory

function [ opt_traj, R_relax] = IterAlgo( affs, cost_func, controller, state_constraints, rulebook, map )
    R = ["r5" "r3" "r1"];
    S_sorted = { [] ["r5"] ["r3"] ["r5" "r3"] ["r1"] 
        ["r5" "r1"] ["r3" "r1"] ["r5" "r3" "r1"] };
    k = 0;
    while k < 9
        % calls controller wrt rule structure to get xlog, 
        % ylog, speed
        R_relax = FeasibleRules(x_log, y_log, speed, R);
        k = k+1;
    end  
end

function R_relax = FeasibleRules(x_log, y_log, speed, R)
    
    nr = length(R);
    n = length(x_log);
    errors = zeros(1,n);
    for i=1:n
        x_curr = x_log(i);
        y_curr = y_log(i);
        e_curr = zeros(1,nr);
        for j=1:nr
            e_curr(j) = RuleVioln(map, params, R(nr), x_curr, y_curr, speed);
        end
        errors(i) = e_curr;
    end
    
        
end
