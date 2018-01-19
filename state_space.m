function msfcn_times_two(block)
% Level-2 MATLAB file S-Function for times two demo.
%   Copyright 1990-2009 The MathWorks, Inc.

  setup(block);
  
%endfunction

function setup(block)
  %% Register dialog parameter: LMS step size 
  %block.NumDialogPrms = 1;
  %block.DialogPrmsTunable = {'Tunable'};
  %block.DialogPrm(1).Name = 'Ib';
  %block.DialogPrm(1).DataTypeId = 0;
  
  %% Register number of input and output ports
  block.NumInputPorts  = 4;
  block.NumOutputPorts = 1;

  %% Setup functional port properties to dynamically
  %% inherited.
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;
 
  block.InputPort(1).DirectFeedthrough = true;
  block.InputPort(1).Dimensions = 13;
  
  block.InputPort(2).Dimensions = 3;
  
  block.InputPort(3).Dimensions = 3;
  
  block.InputPort(4).Dimensions = [3 3];
  
  block.OutputPort(1).Dimensions = 13;
  
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
%input 1: x, %input 2: a_net, %input 3: t_net
x_hold = block.InputPort(1).Data;
a_net = block.InputPort(2).Data;
t_net = block.InputPort(3).Data;
Ib = block.InputPort(4).Data;

v_dot = [x_hold(4,1); x_hold(5,1); x_hold(6,1)];

%rotational component.
omega = [x_hold(11,1); x_hold(12,1); x_hold(13,1)];
q_dot_top = [x_hold(7,1); x_hold(8,1); x_hold(9,1)];
q_dot_bot = x_hold(10,1);

q_dot_top = (1./2).*skew(omega)*q_dot_top + (1./2).*q_dot_bot.*omega;
q_dot_bot = -(1./2).*transpose(omega)*q_dot_top;

%extract rotatIbonal acceleratIbon:
omega_dot = inv(Ib)*(skew(omega)*Ib*omega + t_net);

block.OutputPort(1).Data = [v_dot; a_net; q_dot_top; q_dot_bot; omega_dot];

%endfunction

function skew_mat = skew(vec)
skew_mat = [0 vec(3,1) -vec(2,1);
        -vec(3,1) 0 vec(1,1);
        vec(2,1) -vec(1,1) 0];
%endfunction


    