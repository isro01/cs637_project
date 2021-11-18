clc; clear all; close all;

syms s d mu v a delta w k ujerk usteer slack d_lane xp yp xCl yCl;
    
disp("Instantiating objects");
params = SimParams();

affs = AffSys(s, d, mu, v, a, delta, w, ujerk, usteer, params, k, slack, xCl, yCl);

map = Map(params, "scenario3.json");

clf = DefCLF(params, affs);
cbfStateConstraints = DefCBFStateConstraints(params, affs);

cbfr1 = DefCBFr1(params, affs, xp, yp);
cbfr2 = DefCBFr2(params, affs, d_lane);
cbfr3 = DefCBFr3(params, affs, d_lane);
cbfr4 = DefCBFr4(params, affs);
cbfr5 = DefCBFr5(params, affs);
cbfr7 = DefCBFr7(params, affs);

cbfR = GenerateCBFMatrix(cbfr1, cbfr2, cbfr3, cbfr4, cbfr5, cbfr7);

controller = Controller(params, clf, cbfStateConstraints);

R = ["r5", "r3", "r1"];

binary = [1 0 1 0 1 0;
          1 0 1 0 0 0;
          1 0 0 0 1 0;
          1 0 0 0 0 0;
          0 0 1 0 1 0;
          0 0 1 0 0 0;
          0 0 0 0 1 0;
          0 0 0 0 0 0; ];
          
S_sorted = [""  , ""  , ""  ;
            "r5", ""  , ""  ;
            ""  , "r3", ""  ;
            "r5", "r3", ""  ;
            ""  , ""  , "r1";
            "r5", ""  , "r1";
            ""  , "r3", "r1";
            "r5", "r3", "r1"; ];
j = 4;      
% for j=1:8
    
    fprintf('Rule subset:%i\n', j);
    
    disp("Intitializing states");
     
    s = sym(0);
    d = sym(0);
    mu = sym(0);
    v = sym(0);
    a = sym(0);
    delta = sym(0);
    w = sym(0);
    xCl= sym(map.refTraj(1,1));
    yCl= sym(map.refTraj(1,2));
    
    ini_dlane = UpdateDMinF(subs(affs.egoX), subs(affs.egoY), map, map.refTraj(1,1), map.refTraj(1,2));
    [ini_xp, ini_yp] = UpdatePedestrian(map, subs(affs.egoX), subs(affs.egoY));
    

    d_lane = sym(ini_dlane);
    xp = sym(ini_xp);
    yp = sym(ini_yp);
    
    
    x_log = zeros(1,params.N);
    y_log = zeros(1,params.N);
    slack_log = zeros(params.N, params.slack_dim);
    speed = zeros(1,params.N);


    x_log(1) = map.ego(1);
    y_log(1) = map.ego(2);
    speed(1) = 0;

    
    for i=2:params.N
       fprintf('Iteration:%i\n', i);
       
       disp("Generating rule CBF matrices");
       [cbfrA, cbfrb] = cbfR.subsetMatrix(binary(j));
       
       disp("Generating optimal control input");
       [u_upd, slack_upd] = controller.optimize(params, clf, cbfrA, cbfrb);
       [ujerk, usteer, slack] = UpdateInput(u_upd, slack_upd);
       
       disp("Updating ego");
       
       [x_upd, k_upd, xCl_upd, yCl_upd] = ForwardDynamics(affs, params, map, i);

       [s, d, mu, v, a, delta, w, k] = UpdateState(x_upd, k_upd);
       
       disp("Updating other variables");
       d_lane_upd = UpdateDMinF(subs(affs.egoX), subs(affs.egoY), map, map.refTraj(i,1), map.refTraj(i,2));
       [xp_upd, yp_upd] = UpdatePedestrian(map, subs(affs.egoX), subs(affs.egoY));
       
       
       d_lane = sym(d_lane_upd);
       xp = sym(xp_upd);
       yp = sym(yp_upd);
       xCl = sym(xCl_upd);
       yCl = sym(yCl_upd); 
       
       
       speed(i) = v; 
       x_log(i) = subs(affs.egoX);
       y_log(i) = subs(affs.egoY);
       slack_log(i,:) = subs(slack);
       fprintf("\n");
    end
%     
%     disp("Generating relaxed rule set");
%     R_relax = FeasibleRules(x_log, y_log, speed, R);
% end
%  Simulator(map, x_log, y_log, speed);
