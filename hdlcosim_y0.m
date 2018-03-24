function obj = hdlcosim_y0
%hdlcosim_y0 is a cosimWizard generated function used for HDL
%   cosimulation with the 'y0' DUT.
%   hdlcosim_y0 return an instance of a hdlverifier.HDLCosimulation
%   object configured for the 'y0' DUT.
%
%  For more help look at <a href="matlab: help  'hdlverifier.HDLCosimulation'">hdlverifier.HDLCosimulation</a>
% 
% File Name: hdlcosim_y0.m
% Created: 24-Mar-2018 10:53:21
% 
% Generated by Cosimulation Wizard

%   Copyright 2011-2012 The MathWorks, Inc.

    obj = hdlcosim('InputSignals', {'/y0/x_in'}, ...
                   'OutputSignals', {'/y0/y_out'}, ...
                   'OutputDataTypes', {'fixedpoint'}, ...
                   'OutputSigned', [false], ...
                   'OutputFractionLengths', [18], ...                   
                   'TCLPreSimulationCommand', 'force /y0/clk 0 0 ns, 1 5 ns -repeat 10 ns; ', ...
                   'TCLPostSimulationCommand', 'noforce /y0/clk; puts "done"; ', ...
                   'PreRunTime', {10,'ns'}, ...
                   'Connection', {'Socket',59573}, ... 
                   'SampleTime', {10,'ns'});
                         
end
    

