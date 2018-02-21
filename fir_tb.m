function fir_tb

%------------------------------------------------------------
% Note: it appears that the cosimWizard needs to be re-run if
% this is moved to a different machine (VHDL needs to be
% recompile in ModelSim).
%------------------------------------------------------------

% HdlCosimulation System Object creation (this Matlab function was created
% by the cosimWizard).
fir_tb = hdlcosim_cla_8bit;

% Simulate for Nclock rising edges (this will be the length of the
% simulation)
Nclock_edges = 12;

% Number of values
Array_size = 12;

% input array % number of zeros will enter into step function in order to
% step the vhdl code through
A_array = {1 2 -3 -4 5 6 -7 -8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0};
B_array = {8 -7 6 -5 4 -3 2 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0};
Sub = {0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0};

Sum = fi(0,1,8,0);
Cout = fi(0,0,1,0);

%output_history = {9 -5 3 -9 1 9 -9 -7 0 0 0 0};

%Loop creates Fixed point arrays
for i=1:Array_size
    
    fixed_word_width     = 8;  % width of input to component
    fixed_point_value    = A_array{i};  % choose a random input values over an appropriate range
    fixed_point_signed   = 1;  % unsiged = 0, signed = 1;
    fixed_point_fraction = 0;  % fraction width (location of binary point within word)
    A_FI_array{i} = fi(fixed_point_value, 1, 8, 0); % make the input a fixed point data type 
    
    fixed_word_width     = 8;  % width of input to component
    fixed_point_value    = B_array{i};  % choose a random input values over an appropriate range
    fixed_point_signed   = 1;  % unsiged = 0, signed = 1;
    fixed_point_fraction = 0;  % fraction width (location of binary point within word)
    B_FI_array{i} = fi(fixed_point_value, 1, 8, 0); % make the input a fixed point data type 

    fixed_word_width     = 1;  % width of input to component
    fixed_point_value    = Sub{i};  % choose a random input values over an appropriate range
    fixed_point_signed   = 0;  % unsiged = 0, signed = 1;
    fixed_point_fraction = 0;  % fraction width (location of binary point within word)
    Sub_FI_array{i} = fi(fixed_point_value, 0, 1, 0); % make the input a fixed point data type
end

% A = fi(3,1,8,0);
B = fi(5,1,8,0);
subtract = fi(0,0,1,0);
% 
% Azero = fi(0,1,8,0);
% Bzero = fi(0,1,8,0);
% 
% 
% [Sum,Cout] = step(fir_tb,Azero,Bzero,subtract);
% [Sum,Cout] = step(fir_tb,Azero,Bzero,subtract);
% [Sum,Cout] = step(fir_tb,Azero,Bzero,subtract);
% [Sum,Cout] = step(fir_tb,Azero,Bzero,subtract);
% [Sum,Cout] = step(fir_tb,Azero,Bzero,subtract);
% [Sum,Cout] = step(fir_tb,Azero,Bzero,subtract);
% [Sum,Cout] = step(fir_tb,Azero,Bzero,subtract);
% [Sum,Cout] = step(fir_tb,Azero,Bzero,subtract);






for clki=1:Nclock_edges
    %-----------------------------------------------------------------
    % Create our input vector at each clock edge, which must be a
    % fixed-point data type.  The word width of the fixed point data type
    % must match the width of the std_logic_vector input.
    %-----------------------------------------------------------------
%     fixed_word_width     = 8;  % width of input to component
%     fixed_point_value    = 5;     % choose a random input values over an appropriate range
%     fixed_point_signed   = 1;  % unsiged = 0, signed = 1;
%     fixed_point_fraction = 0;  % fraction width (location of binary point within word)
%     input_vector1 = fi(fixed_point_value, fixed_point_signed, fixed_word_width, fixed_point_fraction); % make the input a fixed point data type
%     input_history{clki} = input_vector1;  % capture the inputs
    
    %-----------------------------------------------------------------
    % Push the input(s) into the component using the step function on the
    % system object fir_hdl
    % If there are multiple I/O, use
    % [out1, out2, out3] = step(fir_hdl, in1, in2, in3);
    % and understand all I/O data types are fixed-point objects
    % where the inputs can be created by the fi() function.
    %-----------------------------------------------------------------
    %[Sum,Cout] = step(fir_tb,A_FI_array{clki},B_FI_array{clki},Sub_FI_array{clki});
    [Sum,Cout] = step(fir_tb,A_FI_array{clki},B_FI_array{clki},Sub_FI_array{clki});
    
    
    
    %-----------------------------------------------------------------
    % Save the outputs (which are fixed-point objects)
    %-----------------------------------------------------------------
    output_history{clki} = Sum;  % capture the output
    
end
%-----------------------------------------------------------------
% Display the captured I/O
%-----------------------------------------------------------------
% display_this = 0;
% if display_this == 1
%     for clki=1:Nclock_edges
%         in1 = input_history{clki};
%         in1.bin
%         out1 = output_history{clki}
%         out1.dec
%         out1.WordLength
%     end
% end
%-----------------------------------------------------------------
% Perform the desired comparison (with the latency between input
% and output appropriately corrected).
%-----------------------------------------------------------------
latency     = 2;  % latency in clock cycles through the component
j = 0;
error_index = 0;
error_case  = {};
for clki=1:Nclock_edges-latency
    %in1  = input_history{clki};
    out1 = output_history{clki};%+latency};  % get the output associated with current output
    %------------------------------------------------------
    % Perfom the comparison with the "true" output
    %------------------------------------------------------
    if Sub_FI_array{clki} == 0
        in1 = A_FI_array{clki} + B_FI_array{clki};
    else
        in1 = A_FI_array{clki} - B_FI_array{clki};
    end
    
    if out1 == in1
        
    else 
        error_index = error_index + 1;
        error_case = clki;
    end
    
end

% Print out errors
error_index
error_case

end
