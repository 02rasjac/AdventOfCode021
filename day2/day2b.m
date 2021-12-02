%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: D:\Dokument\Programmering\adventofcode2021\day2\day2a_input.txt
%
% Auto-generated by MATLAB on 02-Dec-2021 13:07:17

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["Direction", "Distance"];
opts.VariableTypes = ["string", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, "Direction", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Direction", "EmptyFieldRule", "auto");

% Import the data
day2ainput = readtable("D:\Dokument\Programmering\adventofcode2021\day2\day2a_input.txt", opts);

%% Clear temporary variables
clear opts


%% Code
distance = [0, 0]; % [HORIZONTAL, DEPTH]
aim = 0;
for i = 1:height(day2ainput)
    curDist = day2ainput(i, :).Distance;
    switch day2ainput(i, :).Direction
    case 'forward'
        distance(1) = distance(1) + curDist;
        distance(2) = distance(2) + aim*curDist;
    case 'up'
        aim = aim - curDist;
    case 'down'
        aim = aim + curDist;
    end
end

fprintf("====== Position ======\n");
fprintf("Horizontal:  %d\n", distance(1));
fprintf("Depth:       %d\n", distance(2));
fprintf("Horiz*Depth: %d\n", distance(1)*distance(2));