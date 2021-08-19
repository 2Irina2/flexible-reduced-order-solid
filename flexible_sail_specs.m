clear all
clc

% Boom
boom_radius = 0.1;                                                         % m ***
aluminum_density = 2710; 
sail_area = 1600;                                                          % m^2
sail_side = sqrt(sail_area);                                               % m
sail_diag = sqrt(sail_side^2*2);                                           % m
boom_length = sail_diag/2;
Eb = 124 * 10^9;
nub = 0.3;
boom_damping_ratio = 12;
nelem = 30;

% Sail
origins = [ 20    -20      0     % Frame 1: Boom positive X connection point
            0      0      0      % Frame 2: Payload connection point
            -20     -20      0]; % Frame 3: Boom negative X connection point 2
numFrames = size(origins,1);

% ANSYS: The dumped matrices are 24x24 in Harwell Boeing format.
% The last 6 rows/cols of the matrix being dumped are   
% non-physical degrees of freedom added internally by CMS and do not      
% relate to any of the nodes in the model.
M = hb_to_msm('massmatrix.matrix');
M = full(M(1:18,1:18));
K = hb_to_msm('stiffmatrix.matrix');
K = full(K(1:18,1:18));

time = 20;
out = sim('flexible_sail_model', time);