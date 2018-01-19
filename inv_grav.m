function msfcn_times_two(block)
% Level-2 MATLAB file S-Function for times two demo.
%   Copyright 1990-2009 The MathWorks, Inc.

  setup(block);
  
%endfunction

function setup(block)
  
  %% Register number of input and output ports
  block.NumInputPorts  = 1;
  block.NumOutputPorts = 1;

  %% Setup functional port properties to dynamically
  %% inherited.
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;
 
  block.InputPort(1).DirectFeedthrough = true;
  block.InputPort(1).Dimensions = 13;
  
  block.OutputPort(1).Dimensions = 3;
  
  %% Set block sample time to inherited
  block.SampleTimes = [-1 0];
  
  %% Set the block simStateCompliance to default (i.e., same as a built-in block)
  block.SimStateCompliance = 'DefaultSimState';

  %% Run accelerator on TLC
  block.SetAccelRunOnTLC(true);
  
  %% Register methods
  block.RegBlockMethod('Outputs',                 @Output);  
  
%endfunction

function Output(block)
%actual function:

x_hold = block.InputPort(1).Data;
r_ECI = [x_hold(1,1); x_hold(2,1); x_hold(3,1)];
mu_e = 3.986004418E+14;

block.OutputPort(1).Data =  ((-1.*mu_e)./(norm(r_ECI).^3)).*(r_ECI);
  
%endfunction