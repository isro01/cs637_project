% Recursive relaxation algorithm for finding oprimal trajectory

function [ x_log, y_log, speed, R_relax] = IterAlgo()
    R = ["r5" "r3" "r1"];
    binary = [1 0 1 0 1 0;
              1 0 1 0 0 0;
              1 0 0 0 1 0;
              1 0 0 0 0 0;
              0 0 1 0 1 0;
              0 0 1 0 0 0;
              0 0 0 0 1 0;
              0 0 0 0 0 0; ];
          
%     S_sorted = { [] ["r5"] ["r3"] ["r5" "r3"] ["r1"] 
%         ["r5" "r1"] ["r3" "r1"] ["r5" "r3" "r1"] };
    k = 4;
    
%     while k < 9
        [x_log, y_log, speed] = OptimalTrajectoryGenerator(binary(k));
%       R_relax = FeasibleRules(x_log, y_log, speed, R);
        R_relax= R;
        k = k+1;
%     end  
end

function R_relax = FeasibleRules(x_log, y_log, speed, R)
    
    nr = length(R);
    n = length(x_log);
    errors = zeros(n,3);
    for i=1:n
        x_curr = x_log(i);
        y_curr = y_log(i);
        e_curr = zeros(1,nr);
        for j=1:nr
            e_curr(j) = RuleVioln(map, params, R(nr), x_curr, y_curr, speed(i));
        end
        errors(i,:) = e_curr;
    end
    R_relax = R;
end
