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

X = fi(5,0,36,18);
Y = fi(0,0,36,18);
clk = fi(0,0,1,0);






    Y = step(fir_tb,clk,X);
    


for clki=1:Nclock_edges
    
    Y = step(fir_tb,clk,X);
    
    if clk == 0
        clk = 1;
    else 
        clk == 0;
    
  
    
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
latency     = 0;  % latency in clock cycles through the component
j = 0;
error_index = 0;
error_case  = {};
for clki=1:Nclock_edges-latency
    %in1  = input_history{clki};
    out1 = output_history{clki};%+latency};  % get the output associated with current output
    %------------------------------------------------------
    % Perfom the comparison with the "true" output
    %------------------------------------------------------
    
    binary = bin(X);
    count = 0; 
    beta = 0;
    alpha = 0; 
    Xa = 0;
    Xb = 0;
    %Counts zeros
    for a = 1:37
        if binary(a:a) == '0'
            count = count + 1;
        else 
        end 
    end 
    
    beta = 17 - count;
    
    if binary(37:37) == '0'
         alpha = -2 * beta + 0.5 * beta + 0.5;
    end  
    if binary(37:37) == '1'
         alpha = -2 * beta + 0.5 * beta;
    end 
    
    
    
    
end

% Print out errors
error_index
error_case

end
