function [scenario, egoVehicle] = simulator()
    % Construct a drivingScenario object.
    scenario = drivingScenario;
    
    % Add all road segments
    roadCenters = [
        -4.2 50.6 0;
        -3.16 49.61 0;
        -2.12 48.62 0;
        -1.08 47.63 0;
        -0.04 46.64 0;
        1 45.65 0;
        2.04 44.66 0;
        3.08 43.67 0;
        4.12 42.68 0;
        5.16 41.69 0;
        6.2 40.7 0;
        7.23 39.71 0;
        8.26 38.72 0;
        9.29 37.73 0;
        10.32 36.74 0;
        11.35 35.75 0;
        12.38 34.76 0;
        13.41 33.77 0;
        14.44 32.78 0;
        15.47 31.79 0;
        16.5 30.8 0;
        17.51 29.8 0;
        18.52 28.8 0;
        19.53 27.8 0;
        20.54 26.8 0;
        21.55 25.8 0;
        22.56 24.8 0;
        23.57 23.8 0;
        24.58 22.8 0;
        25.59 21.8 0;
        26.6 20.8 0;
        27.75 19.62 0;
        28.9 18.44 0;
        30.05 17.26 0;
        31.2 16.08 0;
        32.35 14.9 0;
        33.5 13.72 0;
        34.65 12.54 0;
        35.8 11.36 0;
        36.95 10.18 0;
        38.1 9 0;
        39.02 8.03 0;
        39.94 7.06 0;
        40.86 6.09 0;
        41.78 5.12 0;
        42.7 4.15 0;
        43.62 3.18 0;
        44.54 2.21 0;
        45.46 1.24 0;
        46.38 0.27 0;
        47.3 -0.7 0;
        48.39 -1.88 0;
        49.48 -3.06 0;
        50.57 -4.24 0;
        51.66 -5.42 0;
        52.75 -6.6 0;
        53.84 -7.78 0;
        54.93 -8.96 0;
        56.02 -10.14 0;
        57.11 -11.32 0;
        58.2 -12.5 0
    ];
    % instead of hardcoding roadCenters, copy the value of roadCenters from Json file after appending z coordinates
    laneSpecification = lanespec(2);
    road(scenario, roadCenters, 'Lanes', laneSpecification, 'Name', 'Road');
    
    % Add the ego vehicle
    egoVehicle = vehicle(scenario, ...
        'ClassID', 1, ...
        'Position', [-0.538370043474972 50.1281360003585 0], ...
        'Mesh', driving.scenario.carMesh, ...
        'PlotColor', [0 114 189] / 255, ...
        'Name', 'Car');
    % mention the x and y coordinates of ego in 'Position' field from json file
    waypoints = IterAlgo();

    % instead of hardcoding waypoints, assign it's values by calling a function generateEgoWaypoints() after 
    % appending z coordinates

    speed = [30;30;30;30;30;30;30;30];
    % instead of hardcoding speed, assign it's values by calling a function
    trajectory(egoVehicle, waypoints, speed);
    
    % Add the non-ego actors
    vehicle(scenario, ...
        'ClassID', 1, ...
        'Position', [-3.5 47.5 0], ...
        'Yaw', -45, ...
        'Mesh', driving.scenario.carMesh, ...
        'PlotColor', [255 105 41] / 255, ...
        'Name', 'Car1');
    % mention the x and y coordinates of this vehicle in 'Position' field from json file
    actor(scenario, ...
        'ClassID', 4, ...
        'Length', 0.24, ...
        'Width', 0.45, ...
        'Height', 1.7, ...
        'Position', [33.5 10 0], ...
        'RCSPattern', [-8 -8;-8 -8], ...
        'Mesh', driving.scenario.pedestrianMesh, ...
        'Name', 'Pedestrian');
    % mention the x and y coordinates of this pedestrian in 'Position' field from json file

    actor(scenario, ...
        'ClassID', 4, ...
        'Length', 0.24, ...
        'Width', 0.45, ...
        'Height', 1.7, ...
        'Position', [40 7.5 0], ...
        'RCSPattern', [-8 -8;-8 -8], ...
        'Mesh', driving.scenario.pedestrianMesh, ...
        'Name', 'Pedestrian');
    % mention the x and y coordinates of this pedestrian in 'Position' field from json file

    car2 = vehicle(scenario, ...
        'ClassID', 1, ...
        'Position', [5.5 38.6 0], ...
        'Mesh', driving.scenario.carMesh, ...
        'PlotColor', [0.635 0.078 0.184], ...
        'Name', 'Car2');
    % mention the x and y coordinates of this vehicle in 'Position' field from json file

    waypoints = [
        5.5 38.6 0;
        6.46428 37.6428 0;
        7.42857 36.6857 0;
        8.39285 35.7285 0;
        9.35714 34.7714 0;
        10.3214 33.8143 0;
        11.2857 32.8571 0;
        12.25 31.9 0;
        13.2143 30.9429 0;
        14.1786 29.9858 0;
        15.1429 29.0286 0;
        16.1072 28.0714 0;
        17.0714 27.1143 0;
        18.0357 26.1572 0;
        19 25.2 0;
        19.8643 24.3 0;
        20.7286 23.4 0;
        21.5928 22.5 0;
        22.4571 21.6 0;
        23.3214 20.7 0;
        24.1857 19.8 0;
        25.05 18.9 0;
        25.9143 18 0;
        26.7786 17.1 0;
        27.6429 16.2 0;
        28.5072 15.3 0;
        29.3714 14.4 0;
        30.2357 13.5 0;
        31.1 12.6 0;
        31.9062 11.7688 0;
        32.7125 10.9375 0;
        33.5188 10.1062 0;
        34.325 9.275 0;
        35.1312 8.44375 0;
        35.9375 7.6125 0;
        36.7438 6.78125 0;
        37.55 5.95 0;
        38.3562 5.11875 0;
        39.1625 4.2875 0;
        39.9688 3.45625 0;
        40.775 2.625 0;
        41.5813 1.79375 0;
        42.3875 0.9625 0;
        43.1937 0.13125 0;
        44 -0.7 0;
        44.6813 -1.425 0;
        45.3625 -2.15 0;
        46.0437 -2.875 0;
        46.725 -3.6 0;
        47.4062 -4.325 0;
        48.0875 -5.05 0;
        48.7688 -5.775 0;
        49.45 -6.5 0;
        50.1312 -7.225 0;
        50.8125 -7.95 0;
        51.4938 -8.675 0;
        52.175 -9.4 0;
        52.8562 -10.125 0;
        53.5375 -10.85 0;
        54.2188 -11.575 0;
        54.9 -12.3 0
    ];
    % instead of hardcoding waypoints, copy the value of waypoints from Json file after appending z coordinates
    speed = [15;15;15;15;15;15;15;15;15;15;
        15;15;15;15;15;15;15;15;15;15;
        15;15;15;15;15;15;15;15;15;15;15
        15;15;15;15;15;15;15;15;15;15;
        15;15;15;15;15;15;15;15;15;15;
        15;15;15;15;15;15;15;15;15;15
    ];
    % instead of hardcoding speed, copy the value of speed from Json file
    waittime = [0;0;0;0;0;0;0;0;0;0;
        0;0;0;0;0;0;0;0;0;0;
        0;0;0;0;0;0;0;0;0;0;0;
        0;0;0;0;0;0;0;0;0;0;
        0;0;0;0;0;0;0;0;0;0;
        0;0;0;0;0;0;0;0;0;0
    ];
    trajectory(car2, waypoints, speed, waittime);
    drivingScenarioDesigner(scenario)
    