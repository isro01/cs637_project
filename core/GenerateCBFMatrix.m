classdef GenerateCBFMatrix
    properties
        A;
        b;
    end
    methods 
        function self = GenerateCBFMatrix(cbfr1, cbfr2, cbfr3, cbfr4, cbfr5, cbfr7)
            self.A = sym.empty;
            self.b = sym.empty;
            self.A = [cbfr1.A;
                      cbfr2.A;
                      cbfr3.A;
                      cbfr4.A;
                      cbfr5.A;
                      cbfr7.A; ];
                  
            self.b = [cbfr1.b;
                      cbfr2.b;
                      cbfr3.b;
                      cbfr4.b;
                      cbfr5.b;
                      cbfr7.b; ];
        end
        
        function [A_sel, b_sel] = subsetMatrix(self, binary)
            n = size(binary);
            A_sel = sym.empty;
            b_sel = sym.empty;
            
            for i=1:n
                if binary(i)
                    A_sel(end+1,:) = self.A(i,:);
                    b_sel(end+1,:) = self.b(i);
                end
            end    
        end
    end
end