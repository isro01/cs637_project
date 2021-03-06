function [errors,R_relax] = FeasibleRules(x_log, y_log, speed, R, map, params)
    
    nr = length(R);
    n = length(x_log);
    errors = zeros(n,3);
    for i=1:n
        x_curr = x_log(i);
        y_curr = y_log(i);
        e_curr = zeros(1,nr);
        for j=1:nr
            temp = RuleVioln(map, params, R(nr), x_curr, y_curr, speed(i));
            temp
            e_curr(1,j) = temp;
        end
        errors(i,:) = e_curr;
    end
    R_relax = R;
end