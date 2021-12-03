%% Import data from text file.
% Script for importing data from the following text file:
%
%    C:\Users\rasmu\Documents\programing\AdventOfCode2021\day3\day3a_input.txt
%
% To extend the code to different selected data or a different text file, generate a function instead of a script.

% Auto-generated by MATLAB on 2021/12/03 10:44:15

filename = 'C:\Users\rasmu\Documents\programing\AdventOfCode2021\day3\day3a_input.txt';

% For more information, see the TEXTSCAN documentation.
formatSpec = '%1s%1s%1s%1s%1s%1s%1s%1s%1s%1s%1s%s%[^\n\r]';

fileID = fopen(filename,'r');

% This call is based on the structure of the file used to generate this code. If an error occurs for a different file, try regenerating the code from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string',  'ReturnOnError', false);

fclose(fileID);

%% Convert the contents of columns containing numeric text to numbers.
% Replace non-numeric text with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4,5,6,7,8,9,10,11,12]
    % Converts text in the input cell array to numbers. Replaced non-numeric text with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1)
        % Create a regular expression to detect and remove non-numeric prefixes and suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData(row), regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if numbers.contains(',')
                thousandsRegExp = '^[-/+]*\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(numbers, thousandsRegExp, 'once'))
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric text to numbers.
            if ~invalidThousandsSeparator
                numbers = textscan(char(strrep(numbers, ',', '')), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch
            raw{row, col} = rawData{row};
        end
    end
end


%% Create output variable
day3ainput = cell2mat(raw);
%% Clear temporary variables
clearvars filename formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp;

%% Code
numOfOnes = zeros(length(day3ainput(1, :)), 1)';
gamma = zeros(length(numOfOnes), 1)';
epsilon = zeros(length(numOfOnes), 1)';

% Count number of ones in a number
for i = 1:length(day3ainput(:, 1));
    for j = 1:length(day3ainput(1, :))
        numOfOnes(j) = numOfOnes(j) + day3ainput(i, j);
    end
end

% Calculate bit for gamma/epsilon
for i = 1:length(numOfOnes)
    if numOfOnes(i) >= length(day3ainput(:, 1))/2
        gamma(i) = 1;
        epsilon(i) = 0;
        continue;
    end
    gamma(i) = 0;
    epsilon(i) = 1;
end

powerUsage = binToDec(gamma) * binToDec(epsilon);
fprintf("Powerusage is: %d\n", powerUsage);

% Convert row-array of bits to scalar decimal
function dec = binToDec(bin)
    dec = 0;
    for i = 1:length(bin)
        dec = dec + bin(i)*2^(length(bin)-i)
    end
end