
function [s, d, mu, v, a, delta, w, k] = UpdateState(x_upd, k_upd)
    s = sym(x_upd(1));
    d = sym(x_upd(2));
    mu = sym(x_upd(3));
    v = sym(x_upd(4));
    a = sym(x_upd(5));
    delta = sym(x_upd(6));
    w = sym(x_upd(7));
    k = sym(k_upd);
end