filename = "day1a_input.txt";
delimiter = "\n";
depthReport = importdata(filename, delimiter);

prev = depthReport(1);
increases = 0;
for index = 2:length(depthReport)
    increases = increases + (depthReport(index) > prev);
    prev = depthReport(index);
end

fprintf("Number of measurements larger than previous: %d\n", increases);