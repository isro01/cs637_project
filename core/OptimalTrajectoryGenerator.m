
function [x_log, y_log, speed] = OptimalTrajectoryGenerator(binary)

    syms s d mu v a delta w k ujerk usteer slack d_minf;
    
    disp("Instantiating objects");
    params = SimParams();
    
    affs = AffSys(s, d, mu, v, a, delta, w, ujerk, usteer, params, k, slack);
    
    map = Map(params, "data.json");

    clf = DefCLF(params, affs);
    cbfStateConstraints = DefCBFStateConstraints(params, affs);
    
    cbfr1 = DefCBFr1(params, affs, map, d_minf);
    cbfr2 = DefCBFr2(params, affs);
    cbfr3 = DefCBFr3(params, affs);
    cbfr4 = DefCBFr4(params, affs);
    cbfr5 = DefCBFr5(params, affs);
    cbfr7 = DefCBFr7(params, affs);
    
    cbfR = GenerateCBFMatrix(cbfr1, cbfr2, cbfr3, cbfr4, cbfr5, cbfr7, binary);

    controller = Controller(params, clf, cbfStateConstraints, cbfR);
    
    ini_dminf = UpdateDMinF(map.ego(1), map.ego(2), map);
    
    s=subs(s,0);
    d=subs(d,0);
    mu=subs(mu,0);
    v=subs(v,0);
    a=subs(a,0);
    delta=subs(delta,0);
    w=subs(w,0);
    d_minf=subs(d_minf, ini_dminf);
    
    x_log = zeros(1,params.N);
    y_log = zeros(1,params.N);
    speed = zeros(1,params.N);

    x_log(1) = map.ego(1);
    y_log(1) = map.ego(2);
    speed(1) = 0;

    for i=2:params.N
       disp(i);
       [u_upd, slack_upd] = controller.optimize(params, clf);
       disp("Updating ego");
       [ujerk, usteer, slack] = UpdateInput(u_upd, slack_upd);

       [x_upd, k_upd, map] = ForwardDynamics(affs, params, map, i);
       [s, d, mu, v, a, delta, w, k] = UpdateState(x_upd, k_upd);
       d_minf = sym(UpdateDMinF(map.ego(1), map.ego(2), map));
       speed(i) = v; 
       x_log(i) = map.ego(1);
       y_log(i) = map.ego(2);
    end
