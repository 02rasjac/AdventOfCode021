filename = "day1a_input.txt";
delimiter = "\n";
depthReport = importdata(filename, delimiter);

prevWindow = sum(depthReport(1:3));
increases = 0;
for index = 2:length(depthReport)-2
    increases = increases + (sum(depthReport(index:(index+2))) > prevWindow);
    prevWindow = sum(depthReport(index:(index+2)));
end

fprintf("Number of three-measurement sliding window larger than previous: %d\n", increases);