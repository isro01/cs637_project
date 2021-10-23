clc; clear all; close all;

syms s d mu v a delta w k ujerk usteer slack;


params = SimParams();

affs = AffSys(s, d, mu, v, a, delta, w, ujerk, usteer, params, k, slack);

clf = DefCLF(params, affs);

map = Map(params, "data.json");

controller = Controller(params, clf);

s=0;
d=0;
mu=0;
v=0;
a=0;
delta=0;
w=0;

x_log = zeros(params.N);
y_log = zeros(params.N);

x_log(1) = map.ego(1);
y_log(1) = map.ego(2);


for i=2:params.N
   i
   controller.optimize(affs, params, clf)
   ForwardDynamics(affs, params, map, i);
   x_log(i) = map.ego(1);
   y_log(i) = map.ego(2);
end

plot(x_log, y_log)