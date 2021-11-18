n = size(x_log,2);
plot(x_log(1:n), y_log(1:n),'DisplayName','OptTraj');
hold on
plot(38.9,15.0,'o','DisplayName', 'Passive Vehicle');
hold on
plot(44.5, 30.9, 'o','DisplayName', 'Pedestrian 1');
hold on
% plot(52, 6.4,'o','DisplayName', 'Pedestrian 2');
hold on
plot(map.refTraj(1:n,1), map.refTraj(1:n,2), 'DisplayName' , 'RefTraj');
hold on 
plot(map.roadMid(1:n,1), map.roadMid(1:n,2),'-','DisplayName','RoadMid');
hold on
% plot(map.leftLaneMid(1:n,1), map.leftLaneMid(1:n,2),'-','DisplayName','leftLaneMid');
% hold on
plot(map.rightLaneMid(1:n,1), map.rightLaneMid(1:n,2),'-','DisplayName','rightLaneMid');
hold on
plot(map.ego(1), map.ego(2),'o','DisplayName','Origin');
hold on
% plot(map.refTraj(:,1), map.refTraj(:,2), 'DisplayName' , 'RefTraj');
hold off 
legend
