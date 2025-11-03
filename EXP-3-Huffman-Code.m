clc;
clear;
close all;

pkg load communications;

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

% ---------- Huffman coding ----------
dict = huffmandict(symbols, p);

codes = cell(1, n);
len = zeros(1, n);

for i = 1:n
    % Each dict element is the code for corresponding symbol
    code_vector = dict{i};
    % Convert numeric code to string (remove spaces )
    code_str = num2str(code_vector);
    code_str = code_str(code_str ~= ' ');
    codes{i} = code_str;
    len(i) = length(code_vector);
end

% ---------- Display codes ----------
disp(' ');
disp('Symbol    Probability    Code     Length');
for i = 1:n
    fprintf('%s          %.3f           %s         %d\n', symbols{i}, p(i), codes{i}, len(i));
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
