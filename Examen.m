clc; 
clear; 
close all;

% Número de intervalos y límites
a = 0; 
b = 10; 
n = 10000; 
h = (b - a) / n; % Tamaño del intervalo

% Puntos del intervalo
x = linspace(a, b, n+1); 
f = sin(x); % Funcion

% Regla del Rectángulo
I_rect = h * sum(f(1:end-1)); 
fprintf('Integral usando la Regla del Rectángulo: %.4f\n', I_rect);

% Regla del Trapecio
I_trap = (h / 2) * (f(1) + 2*sum(f(2:end-1)) + f(end));
fprintf('Integral usando la Regla del Trapecio: %.4f\n', I_trap);

% Regla de Simpson
if mod(n, 2) == 0 
    I_simp = (h / 3) * (f(1) + 4*sum(f(2:2:end-1)) + 2*sum(f(3:2:end-2)) + f(end));
    fprintf('Integral usando la Regla de Simpson: %.4f\n', I_simp);
else
    error('El número de intervalos (n) debe ser par para la Regla de Simpson.');
end