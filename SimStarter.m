clear all; clc; close all;
%Starts BOP .slx file.
%M. McDonald 1/15/18

%initialize position and velocity, represented in ECI:
r_ECI_i = [-3802109.57; 4869235.79; 2786219.22]; % m.
v_ECI_i = [-5547.254425; -1392.277084; -5116.754279]; % m/s.

%Initialize rates, attitude:
w_i = [0; 0; 0];
q_i = [0; 0; 0; 1]; %using Dogan Notation (last value is scalar.)

%setup initial x_i:
x_i = [r_ECI_i; v_ECI_i; q_i; w_i];

%setup spacecraft inertia properties:

%spacecraft mass (assumed rigid)
msc = .5; %in kg

%spacecraft inertia matrix (assumed rigid)
Ib =  [0.036 0 0; 0 0.036 0; 0 0 0.036];

%sim parameters
t_end = 86400;

%intialize sim:
model = 'BOP';
simOut = sim(model);

%extract data:
plot3(x(:,1),x(:,2),x(:,3));