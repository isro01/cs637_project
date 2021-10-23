classdef SimParams
    properties
        v_max = 10;
        v_min = 0;
        a_max = 3.5; 
        a_min = -3.5;
        u_j_max = 4;
        u_j_min = -4;
        del_max = 1;
        del_min = -1;
        omega_max = 0.5;
        omega_min = -0.5;
        u_s_max = 2;
        u_s_min = -2;
        w = 1.8;
        l = 4;
        lf = 2;
        lr = 2;
        d_1 = 1;
        eta_1 = 0.067
        v_max_s = 7;
        v_min_s = 3;
        a_max_s = 2.5;
        a_lat_m = 2.5;
        a_lat_s = 1.75;
        d_7 = 0.3;
        eta_7 = 0.13;
        d_8_l = 0.5;
        d_8_r = 0.5;
        d_8_f = 1;
        eta_8_r = 0.036;
        eta_8_l = 0.036;
        eta_8_f = 2;
        vd = 4; % desired vel
        beta = 2;
        
        eps = 0.01;
        umin = [-4; -2];
        umax = [4; 2];
        c0 = 1;
        udim = 2;
        slack_dim = 9;
        slack_weight = eye(9);
        k1=1;
        dt=0.1;
        N=6;
        d_veh=5;
        k_active=0.1;
        
        
    end
end

        
        
        