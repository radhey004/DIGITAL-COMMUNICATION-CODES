clc;
clear;
close all;

% Binary Symmetric Channel (BSC)
n = 2;                     % Number of source symbols
p = [0.5 0.5];             % Source probabilities

epsilon = input('Enter the value of error probability e : ');  % e = 0 or 0.5

% Channel Matrix P(Y/X)
q = [1-epsilon epsilon; epsilon 1-epsilon];
disp('Channel matrix P(Y/X):');
disp(q);

% Source probability matrix P(X)
px = diag(p);
disp('P(X):');
disp(px);

% Joint probability P(X,Y) = P(X)*P(Y|X)
pxy = px * q;
disp('P(X,Y):');
disp('Joint probability P(X,Y) = P(X)*P(Y|X)');
disp(pxy);

% Output probability P(Y)
py = p * q;
disp('P(Y):');
disp('Output probability P(Y)');
disp(py);

% Entropy of source H(X)
Hx = -sum(p .* log2(p));
disp('Source Entropy H(X)');
disp(['H(X): ', num2str(Hx)]);

% Entropy of destination H(Y)
Hy = -sum(py .* log2(py));
disp('destination Entropy H(Y)');
disp(['H(Y): ', num2str(Hy)]);

% Joint Entropy H(X,Y)
hxy = 0;
for i = 1:n
    for j = 1:n
        if pxy(i,j) > 0
            hxy = hxy - pxy(i,j)*log2(pxy(i,j));
        end
    end
end
disp('Joint Entropy H(X,Y)');
disp(['H(X,Y): ', num2str(hxy)]);

% Conditional entropies
H_yx = hxy - Hx;   % H(Y|X)
H_xy = hxy - Hy;   % H(X|Y)
disp('Conditional Entropies');
disp(['H(Y|X): ', num2str(H_yx)]);
disp(['H(X|Y): ', num2str(H_xy)]);

% Mutual Information
Ixy = Hx - H_xy;
disp('Mutual Information');
disp(['I(X;Y): ', num2str(Ixy)]);

% Channel Type
if abs(H_xy) < 1e-6
    disp('This channel is NOISELESS and LOSSLESS');
elseif abs(Ixy) < 1e-6
    disp('This channel is USELESS');
else
    disp('This channel is NOISY');
end

