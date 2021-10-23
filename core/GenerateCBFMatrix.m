classdef GenerateCBFMatrix
    properties
        A;
        b;
    end
    methods 
        function self = GenerateCBFMatrix(cbfr1, cbfr2, cbfr3, cbfr4, cbfr5, cbfr7, binary)
            ACompd = [cbfr1.A;
                      cbfr2.A;
                      cbfr3.A;
                      cbfr4.A;
                      cbfr5.A;
                      cbfr7.A; ];
                  
            bCompd = [cbfr1.b;
                      cbfr2.b;
                      cbfr3.b;
                      cbfr4.b;
                      cbfr5.b;
                      cbfr7.b; ];
                  
            n = size(binary);
            self.A = sym.empty;
            self.b = sym.empty;
            
            for i=1:n
                if binary(i)
                    self.A(end+1) = ACompd(i);
                    self.b(end+1) = bCompd(i);
                end
            end    
        end
    end
end