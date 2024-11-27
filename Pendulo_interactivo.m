clc;
clear;
close all;

% Código para simular el movimiento armónico simple de un péndulo en MATLAB

% Añadir controles interactivos
f = figure;
uicontrol('Style', 'text', 'Position', [10 380 100 20], 'String', 'Longitud (m)');
L_slider = uicontrol('Style', 'slider', 'Min', 0.1, 'Max', 5, 'Value', 1.0, 'Position', [120 380 120 20]);
uicontrol('Style', 'text', 'Position', [10 340 100 20], 'String', 'Ángulo inicial (rad)');
theta0_slider = uicontrol('Style', 'slider', 'Min', 0, 'Max', pi, 'Value', pi/6, 'Position', [120 340 120 20]);
uicontrol('Style', 'text', 'Position', [10 300 100 20], 'String', 'Gravedad (m/s^2)');
g_slider = uicontrol('Style', 'slider', 'Min', 0.1, 'Max', 20, 'Value', 9.81, 'Position', [120 300 120 20]);
uicontrol('Style', 'text', 'Position', [10 260 100 20], 'String', 'Masa (kg)');
m_slider = uicontrol('Style', 'slider', 'Min', 0.1, 'Max', 10, 'Value', 1.0, 'Position', [120 260 120 20]);

uicontrol('Style', 'pushbutton', 'Position', [10 220 100 30], 'String', 'Simular', 'Callback', @(src, event) simular_pendulo(g_slider, L_slider, theta0_slider, m_slider));

% Parámetros iniciales
dt = 0.01; % paso de tiempo (s)
T_max = 10; % tiempo total de simulación (s)

% Función de simulación
function simular_pendulo(g_slider, L_slider, theta0_slider, m_slider)
    g = get(g_slider, 'Value');
    L = get(L_slider, 'Value');
    theta0 = get(theta0_slider, 'Value');
    m = get(m_slider, 'Value'); % masa del péndulo

    
% Parámetros del péndulo
% g = 9.81;                
% L = 1;                   
% theta0 = deg2rad(10);    
% m = 1;           

    w = sqrt(g / L);         
    phi = 0;                 

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
    % pivot = plot(0, 0, 'ko', 'MarkerFaceColor', 'k'); % Pivote
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

    % ------- INTEGRACION -----------------------------------------------------------------------------------

    % Funciones del péndulo
    velocidad_angular = @(t) -theta0 * w * sin(w * t + phi); % Velocidad angular
    aceleracion_angular = @(t) -theta0 * w^2 * cos(w * t + phi); % Aceleración angular

    % Definiciones para las reglas numéricas
    N = 8000; % Número de intervalos
    dx = tiempo / N;
    x = linspace(0, tiempo, N + 1); % Puntos de evaluación

    % Inicialización
    fa_vel = velocidad_angular(x); % Valores de velocidad angular en puntos
    fa_acc = aceleracion_angular(x); % Valores de aceleración angular en puntos
    fm_vel = velocidad_angular((x(1:end-1) + x(2:end)) / 2); % Puntos medios para velocidad
    fm_acc = aceleracion_angular((x(1:end-1) + x(2:end)) / 2); % Puntos medios para aceleración

    % Reglas de integración
    rectangulo = @(dx, f) sum(dx * f(1:end-1));
    trapecio = @(dx, f) dx * sum((f(1:end-1) + f(2:end)) / 2);
    simpson = @(dx, f, fm) dx / 6 * sum(f(1:end-1) + 4 * fm + f(2:end));

    % Cálculo de áreas para velocidad angular
    A_rect_vel = rectangulo(dx, fa_vel);
    A_trap_vel = trapecio(dx, fa_vel);
    A_simp_vel = simpson(dx, fa_vel, fm_vel);

    % Cálculo de áreas para aceleración angular
    A_rect_acc = rectangulo(dx, fa_acc);
    A_trap_acc = trapecio(dx, fa_acc);
    A_simp_acc = simpson(dx, fa_acc, fm_acc);

    % Resultados
    disp('Área bajo la curva de velocidad angular:');
    fprintf('  Regla de Rectángulos: %.4f\n', A_rect_vel);
    fprintf('  Regla de Trapecios: %.4f\n', A_trap_vel);
    fprintf('  Regla de Simpson: %.4f\n', A_simp_vel);

    disp('Área bajo la curva de aceleración angular:');
    fprintf('  Regla de Rectángulos: %.4f\n', A_rect_acc);
    fprintf('  Regla de Trapecios: %.4f\n', A_trap_acc);
    fprintf('  Regla de Simpson: %.4f\n', A_simp_acc);


    % ------- ANIMACION ----------------------------------------------------------------------------------- 
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
end