function e = RuleVioln( map, params, rule_i, x_curr, y_curr, speed)
            % for rules and their violation score
            if rule_i == "r1"
                %%rule 1: clearance with pedestrains
                d_minf = 100;
                for i=1:length(map.instanceList)
                    if map.instanceList(i).type == "pedestrian"
                        d_minf_i = sqrt( (x_curr - map.instanceList(i).x)^2 + (y_curr - map.instanceList(i).y )^2 );
                        if d_minf_i <= d_minf
                            d_minf = d_minf_i;
                        end
                    end
                end
                
                num = params.d_1 + ( speed*params.eta_1 ) - d_minf;
                denum = params.d_1 + ( params.v_max*params.eta_1 );
                temp = num/denum;
                
                if temp>=0
                    e = temp*temp;
                end
                if temp<0
                    e = 0;
                end
            end
%             if rule_i == "r2"
%                 %%rule 2: stay in driveable area
%                 num = d_l + d_r;
%                 denum = 2*d_max;
%                 temp = num/denum;
%                 e = temp*temp;
% 
%             end
            if rule_i == "r3"
                %%rule 3: stay in lane
                d_temp = sqrt( (x_curr-x_traj)^2 + (y_curr - y_traj)^2 );
                if d_temp<(lane_width/2)
                    num = 0;
                end
                if d_temp >= (lane_width/2)
                    num = 2*d_temp;
                end
                    % num = d_l + d_r;
                denum = 2*params.d_max;
                temp = num/denum;
                e = temp*temp;
            end
%             if rule_i == "r4"
%                 %%rule 4: satisfy max speed limit
%                 num = v_t - v_maxs;
%                 denum = v_max;
%                 temp = num/denum;
%              
%                 if temp>=0
%                     e = temp*temp;
%                 end
%                 if temp<0
%                     e = 0;
%                 end
%             end
            
            if rule_i == "r5"
                %%rule 5: satisfy min speed limit
                num = params.v_min_s - speed;
                denum = params.v_min_s - params.v_min;
                temp = num/denum;
             
                if temp>=0
                    e = temp*temp;
                end
                if temp<0
                    e = 0;
                end
            end
            
%             if rule_i == "r6"
%                 %%rule 6: drive smoothly
%                 num1 = a_maxs - abs(a_t);
%                 denum1 = a_max;
%                 temp1 = num1/denum1;
%                 num2 = a_lats - abs(a_lat_t);
%                 denum2 = a_latm;
%                 temp2 = num2/denum2;
%              
%                 if temp1<0
%                     temp1 = 0;
%                 end
%                 if temp2<0
%                     temp2 = 0;
%                 end
%                 
%                 temp = temp1+temp2;
%                 e = temp*temp;
%             end
%             if rule_i == "r7"
%                 %%rule 7:maintain clearance with parked vehicles
%                 num = d_7 + ( v_t*eta_7 ) - d_minf;
%                 denum = d_7 + ( v_max*eta_7 );
%                 temp = num/denum;
%                 
%                 if temp>=0
%                     e = temp*temp;
%                 end
%                 if temp<0
%                     e=0;
%                 end
%             end
%             if rule_i == "r8"
%                 %%rule 8: clearance with active vehicles
%                 num1 = d_8l + ( v_t*eta_8l ) - d_minl;
%                 denum1 = d_8l + ( v_max*eta_8l );
%                 temp1 = num1/denum1;
%                 
%                 num2 = d_8r + ( v_t*eta_8r ) - d_minr;
%                 denum2 = d_8r + ( v_max*eta_8r );
%                 temp2 = num2/denum2;
%                 
%                 num3 = d_8f + ( v_t*eta_8f ) - d_minf;
%                 denum3 = d_8f + ( v_max*eta_8f );
%                 temp3 = num3/denum3;
%                 
%                 if temp1<0
%                     temp1=0;
%                 end
%                 if temp2<0
%                     temp2=0;
%                 end
%                 if temp3<0
%                     temp3=0;
%                 end
%                 e = (1/3)*( temp1*temp1 + temp2*temp2 + temp3*temp3 );
%             end
                 
end
