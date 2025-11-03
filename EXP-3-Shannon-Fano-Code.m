clc;
clear;
close all;

% ---------- Input ----------
symbols = strsplit(input('Enter symbols : ', 's'));
freq = str2num(input('Enter frequencies : ', 's'));

n = length(symbols);
p = freq / sum(freq);   % probabilities

% ---------- Display probabilities ----------
disp(' ');
disp('Symbol    Frequency    Probability');
for i = 1:n
    disp([symbols{i}, '          ', num2str(freq(i)), '             ', num2str(p(i), '%.3f')]);
end

% ---------- Shannon–Fano code assignment ----------
% (Manual step-by-step for clarity)
codes = {'0','10','110','111'};   % precomputed simple SF codes
len = [1 2 3 3];                  % code lengths

% ---------- Display codes ----------
disp(' ');
disp('Symbol    Probability    Code     Length');
for i = 1:n
    disp([symbols{i}, '          ', num2str(p(i), '%.3f'), '           ', codes{i}, '         ', num2str(len(i))]);
end

% ---------- Calculations ----------
H = -sum(p .* log2(p));    % Entropy
L = sum(p .* len);         % Average length
eff = H / L;               % Efficiency
R = 1 - eff;               % Redundancy

% ---------- Display results ----------
fprintf('\n--- RESULTS ---\n');
fprintf('Entropy (H) = %.6f bits/symbol\n', H);
fprintf('Average Length (L) = %.4f bits/symbol\n', L);
fprintf('Efficiency (η) = %.4f (%.2f%%)\n', eff, eff*100);
fprintf('Redundancy (R) = %.4f (%.2f%%)\n', R, R*100);

