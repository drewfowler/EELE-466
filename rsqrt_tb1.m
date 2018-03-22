function rsqrt_tb

      
%------------------------------------------------------------
% Note: it appears that the cosimWizard needs to be re-run if
% this is moved to a different machine (VHDL needs to be
% recompile in ModelSim).
%------------------------------------------------------------

% HdlCosimulation System Object creation (this Matlab function was created
% by the cosimWizard).
rsqrt_hdl = hdlcosim_y0;            

% % Test N input values
Nvalues = 5;%2^16;
% 
% % latency of component
Nlatency = 5;

W = 36;
F = 18; 

Fm = fimath('RoundingMethod'   ,'Floor',...
    'OverflowAction'            ,'Wrap',...
    'ProductMode'               ,'SpecifyPrecision',...
    'ProductWordLength'         ,W,...
    'ProductFractionLength'     ,F,...
    'SumMode'                   ,'SpecifyPrecision',...
    'SumWordLength'             ,W,...
    'SumFractionLength'         ,F);
for i=1:Nvalues
    %-----------------------------------------------------------------
    % Create our input vector, which must be a 
    % fixed-point data type.  The word width of the fixed point data type
    % must match the width of the std_logic_vector input.
    %-----------------------------------------------------------------
    fixed_word_width     = 36;  % width of input to component
    fixed_point_value    = randi([1 2^fixed_word_width-1],1,1);  % choose a random integer between [0 2^W-1] - Note: can't have a zero input....
    fixed_point_signed   = 0;  % unsiged = 0, signed = 1;
    fixed_point_fraction = 18;  % fraction width (location of binary point within word)
    input_vector1 = fi(15, fixed_point_signed, fixed_word_width, fixed_point_fraction) % make the input a fixed point data type
    y = fi(0, fixed_point_signed, fixed_word_width, fixed_point_fraction);
    input_history{i} = input_vector1;  % capture the inputs 
    
    %-----------------------------------------------------------------
    % Push the input(s) into the component using the step function on the
    % system object lzc_hdl
    % If there are multiple I/O, use
    % [out1, out2, out3] = step(lzc_hdl, in1, in2, in3);
    % and understand all I/O data types are fixed-point objects
    % where the inputs can be created by the fi() function.
    %-----------------------------------------------------------------
    for j = 1:Nlatency  % run for Nlatency clock cycles so that the answer will show up
        y = step(rsqrt_hdl,input_vector1)
    end
    
    %-----------------------------------------------------------------
    % Save the outputs (which are fixed-point objects)
    %-----------------------------------------------------------------
    %output_history{i} = output_vector1  % capture the output
    %y = output_vector1  % capture the output
    
    
end
%-----------------------------------------------------------------
% Display the captured I/O
%-----------------------------------------------------------------
% display_this = 0;
% if display_this == 1
%     for i=1:Nvalues
%         in1 = input_history{i};
%         in1.bin
%         out1 = output_history{i}
%         out1.dec
%         out1.WordLength
%     end
% end
%-----------------------------------------------------------------
% Perform the desired comparison (with the latency between input
% and output appropriately corrected).
%-----------------------------------------------------------------
% error_index = 1;
% error_case  = [];
% for i=1:Nvalues
%     in1  = input_history{i};  
%     out1 = output_history{i+latency};  % get the output associated with current output
    %------------------------------------------------------
    % Perfom the comparison with the "true" output 
    % have matlab compute what the answer should be
    %------------------------------------------------------
    
% end



end
