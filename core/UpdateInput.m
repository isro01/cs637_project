
function [ujerk, usteer, slack] = UpdateInput(u_upd, slack_upd)
    ujerk = sym(u_upd(1));
    usteer = sym(u_upd(2));
    slack = sym(slack_upd);
end