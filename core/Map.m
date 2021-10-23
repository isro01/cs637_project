classdef Map
    properties
        instanceList;
        roadMid;
        leftLaneMid;
        rightLaneMid;
        refTraj;
        curvature;
        ego;
        
    end
    
    methods
        function self = Map(params, datafile)
            str = fileread(datafile); 
            data = jsondecode(str);
            numv = size(data.instance.vehicle);
            nump = size(data.instance.pedestrian);
            c=1;
            self.instanceList = Instance.empty;
            
            for i=1:numv
                dict = data.instance.vehicle(i);
                obj = Instance(dict.x, dict.y, "vehicle", dict.state, dict.trajectory, dict.speed);
                self.instanceList(c)=obj;
                c = c+1;
            end 
            
            for i=1:nump
                dict = data.instance.pedestrian(i);
                obj = Instance(dict.x, dict.y, "pedestrian", dict.state, dict.trajectory, dict.speed);
                self.instanceList(c)=obj;
                c = c+1;
            end 
            
            self.roadMid = data.road.roadMid;
            laneWidth = data.road.width;
            self.ego = [data.ego.x, data.ego.y];
            
            self = generateRefTraj(self, laneWidth, self.ego);
            self = generateClearances(self, params);
            self = generateCurvature(self);
        end
        
        function self = generateClearances(self, params)
            numInstances = size(self.instanceList,1);
            for i = 1:numInstances
                self.instanceList(i).clearance = OptimalDiskCoverage(params, self.instanceList(i));
            end
        end
        
        function self = generateRefTraj(self, laneWidth, ego)
            n = size(self.roadMid, 1);
            self.leftLaneMid = zeros(n,2);
            self.rightLaneMid = zeros(n,2);
            
            for i = 1:n-1
                diff = self.roadMid(i,:) - self.roadMid(i+1,:);
                slope = diff(2)/diff(1);
                slope = -1/slope;
                factor = laneWidth * sqrt(1/(1+slope*slope));
                factCoord = [factor, slope*factor];
                self.leftLaneMid(i,:) = self.roadMid(i,:) + factCoord;
                self.rightLaneMid(i,:) = self.roadMid(i,:) - factCoord;
            end
            
            diff = self.roadMid(n,:) - self.roadMid(n-1,:);
            slope = diff(2)/diff(1);
            slope = -1/slope;
            factor = laneWidth * sqrt(1/(1+slope*slope));
            factCoord = [factor, slope*factor];
            self.leftLaneMid(n,:) = self.roadMid(n,:) + factCoord;
            self.rightLaneMid(n,:) = self.roadMid(n,:) - factCoord;
           
            distance = ((ego(1)-self.roadMid(1,1))^2) + ((ego(2)-self.roadMid(1,2))^2);
            slope = (self.roadMid(1,2)-self.roadMid(2,2)) / (self.roadMid(1,1)-self.roadMid(2,1));
            factor = distance * sqrt(1/(1+slope*slope));
            factCoord = [factor, slope*factor];
            p1 = self.roadMid(n,:) + factCoord;
            
            if p1(1) == ego(1) && p1(2) == ego(2)
                self.refTraj = self.leftLaneMid;
            else
                self.refTraj = self.rightLaneMid;
            end
        end
        
        function self = generateCurvature(self)
            x = self.refTraj(:,1).';
            y = self.refTraj(:,2).';
            dx  = 0.5*(x(3:end)-x(1:end-2));
            dy  = 0.5*(y(3:end)-y(1:end-2));
            dl  = sqrt(dx.^2 + dy.^2);
            xp  = dx./dl;
            yp  = dy./dl;
            xpp = (x(3:end)-2*x(2:end-1)+x(1:end-2))./(dl.^2);
            ypp = (y(3:end)-2*y(2:end-1)+y(1:end-2))./(dl.^2);

            self.curvature = (xp.*ypp - yp.*xpp) ./ ((xp.^2 + yp.^2).^(1.5));
            
            for i=1:2
                self.curvature(end+1) = self.curvature(end);
            end
        end
    end
end
