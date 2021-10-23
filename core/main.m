
clc; clear all; close all;

syms s d mu v a delta w k ujerk usteer slack;


params = SimParams();

affs = AffSys(s, d, mu, v, a, delta, w, ujerk, usteer, params, k, slack);

clf = DefCLF(params, affs);
cbfStateConstraints = DefCBFStateConstraints(params, affs);

map = Map(params, "data.json");

controller = Controller(params, clf, cbfStateConstraints);

s=subs(s,0);
d=subs(d,0);
mu=subs(mu,0);
v=subs(v,0);
a=subs(a,0);
delta=subs(delta,0);
w=subs(w,0);

x_log = zeros(1,params.N);
y_log = zeros(1,params.N);

x_log(1) = map.ego(1);
y_log(1) = map.ego(2);

for i=2:params.N
   disp(i);
   [u_upd, slack_upd] = controller.optimize(params, clf);
   [ujerk, usteer, slack] = UpdateInput(u_upd, slack_upd);
 
   [x_upd, k_upd, map] = ForwardDynamics(affs, params, map, i);
   [s, d, mu, v, a, delta, w, k] = UpdateState(x_upd, k_upd);

   x_log(i) = map.ego(1);
   y_log(i) = map.ego(2);
end

plot(x_log, y_log)