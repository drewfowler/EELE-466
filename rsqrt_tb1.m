function rsqrt_tb


%------------------------------------------------------------
% Note: it appears that the cosimWizard needs to be re-run if
% this is moved to a different machine (VHDL needs to be
% recompile in ModelSim).
%------------------------------------------------------------

% HdlCosimulation System Object creation (this Matlab function was created
% by the cosimWizard).
rsqrt_hdl = hdlcosim_lab4_sqrt_top;

% % Test N input values
Nvalues = 10000;%2^16;
%
% % latency of component
Nlatency = 1;

fixed_point_value = zeros(1, Nvalues);
for i=1:Nvalues
    random = randi([0 2^17-1],1,1);
    decimal = rand(1, Nvalues);
    random = random + decimal(i);
    fixed_point_value(i) =random;
end
fixed_point_value(Nvalues) = 2;

W = 36;
F = 18;
X = fi(0, 0, 36, 18);
X = 1;

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
    %fixed_point_value    = randi([1 2^fixed_word_width-1],1,1);  % choose a random integer between [0 2^W-1] - Note: cant have a zero input....
    fixed_point_signed   = 0;  % unsiged = 0, signed = 1;
    fixed_point_fraction = 18;  % fraction width (location of binary point within word)
    input_vector1 = fi(fixed_point_value(i), fixed_point_signed, fixed_word_width, fixed_point_fraction,Fm); % make the input a fixed point data type
    %f = fi(0, fixed_point_signed, fixed_word_width, 18);
    input_history{i} = input_vector1;  % capture the inputs
     X= X +1;
    %-----------------------------------------------------------------
    % Push the input(s) into the component using the step function on the
    % system object lzc_hdl
    % If there are multiple I/O, use
    % [out1, out2, out3] = step(lzc_hdl, in1, in2, in3);
    % and understand all I/O data types are fixed-point objects
    % where the inputs can be created by the fi() function.
    %-----------------------------------------------------------------
    for j = 1:Nlatency  % run for Nlatency clock cycles so that the answer will show up
        output_vector1 = step(rsqrt_hdl,input_vector1);
        %input_vector1;
        
        %y = step(rsqrt_hdl,input_vector1)
%         f = 1 / sqrt(input_vector1);
%         per = 1 - y/f;
%         dif = f - y;
%         
%         k = round(y);
%         m = round(f);
%         if(y == f)
%             disp("EQUALS")
%         else
%             disp("Nope")
    end

    %-----------------------------------------------------------------
    % Save the outputs (which are fixed-point objects)
    %-----------------------------------------------------------------
    output_history{i} = output_vector1;  % capture the output
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
latency = 0;
error_index = 1;
error_case  = [];
for i=1:Nvalues
    in1  = input_history{i};
    out1 = output_history{i+latency};  % get the output associated with current output
%     ------------------------------------------------------
%     Perfom the comparison with the "true" output
%     have matlab compute what the answer should be
%     ------------------------------------------------------
        in1;
        out1;
        ans = 1/sqrt(double(in1));
        
    if(ans == out1)
        disp("Equals")
    else 
       error_index = error_index + 1;
       error_case = i;
    end  
        
end
% Print out errors
error_index
error_case

end
