clc;
clear;
close all;

% Parámetros del péndulo
g = 9.81;                
L = 1;                   
theta0 = deg2rad(10);    
w = sqrt(g / L);         
phi = 0;                 
m = 1;                   

% Tiempo de simulación
tiempo = 9; % segundos
t = linspace(0, tiempo, 100); % Tiempo de 0 a 10 segundos
mr = 1.3; % Margen de las gráficas

% Posición angular (θ)
theta = theta0 * cos(w * t + phi);

% Velocidad angular (ω)
omega = -theta0 * w * sin(w * t + phi);

% Energías
K = 0.5 * m * (L * omega).^2;                 % Energía cinética
U = m * g * (L * (1 - cos(theta)));           % Energía potencial
E_total = K + U;                              % Energía total

% Posición del péndulo en coordenadas cartesianas
x = L * sin(theta);
y = -L * cos(theta);

% PENDULO
figure;
axis equal;
hold on;
grid on;
xlabel('X (m)');
ylabel('Y (m)');
title('Animación del Péndulo Simple');
plot([-L L], [0 0], 'k--'); % Línea de referencia del pivote
pivot = plot(0, 0, 'ko', 'MarkerFaceColor', 'k'); % Pivote
line = plot([0, x(1)], [0, y(1)], 'b-', 'LineWidth', 2); % Línea del péndulo
bob = plot(x(1), y(1), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 12); % Bob del péndulo


% Grafica posicion angular
figure;
subplot(3, 1, 1);
axis([0 tiempo -theta0*mr theta0*mr]);
hold on;
grid on;
xlabel('T (s)');
ylabel('Theta (rad)');
title('Grafica posicion del pendulo');
legend;

animated_line_pos = plot(0, 0, 'b-', 'LineWidth', 2);

% Velocidad angular vs. Tiempo
subplot(3, 1, 2);
axis([0 tiempo -max(omega)*mr max(omega)*mr]);
hold on;
grid on;
xlabel('T (s)');
ylabel('Velocidad Angular (rad/s)');
title('Velocidad Angular vs. Tiempo');
legend;

animated_line_vel = plot(0, 0, 'b-', 'LineWidth', 2);

% Energías vs. Tiempo
subplot(3, 1, 3);
axis([0 tiempo 0 max(E_total)*1.1]);
hold on;
grid on;
xlabel('T (s)');
ylabel('Energía (J)');
title('Energías vs. Tiempo');
legend;

animated_line_epg = plot(0, 0, 'y-', 'LineWidth', 1);
animated_line_ek = plot(0, 0, 'g-', 'LineWidth', 1);
animated_line_et = plot(0, 0, 'r-', 'LineWidth', 2);

% Animar el movimiento del péndulo
for i = 1:length(t)
    % Actualizar la posición del bob y la línea
    set(line, 'XData', [0, x(i)], 'YData', [0, y(i)]);
    set(bob, 'XData', x(i), 'YData', y(i));
    
    % Actualizar la posición de la línea animada
    set(animated_line_pos, 'XData', t(1:i), 'YData', theta(1:i), 'DisplayName', 'Pos Ang');
    set(animated_line_vel, 'XData', t(1:i), 'YData', omega(1:i), 'DisplayName', 'Vel Ang');
    set(animated_line_epg, 'XData', t(1:i), 'YData', U(1:i), 'DisplayName', 'U');
    set(animated_line_ek, 'XData', t(1:i), 'YData', K(1:i), 'DisplayName', 'K');
    set(animated_line_et, 'XData', t(1:i), 'YData', E_total(1:i), 'DisplayName', 'EM');
    
    % Pausa para controlar la velocidad de la animación
    pause(0.1);
end

% Utiliza la regla de simpson para calcular la integral
a = 0; 
b = tiempo; 
n = 10000; 
h = (b - a) / n; % Tamaño del intervalo

I_simp = (h / 3) * (omega(1) + 4*sum(omega(2:2:end-1)) + 2*sum(omega(3:2:end-2)) + omega(end));
fprintf('Velocidad angular obtenida mediante integracion: %.4f\n', I_simp);

I_simp2 = (h / 3) * (theta(1) + 4*sum(theta(2:2:end-1)) + 2*sum(theta(3:2:end-2)) + theta(end));
fprintf('Posicion angular obtenida mediante integracion: %.4f\n', I_simp2);