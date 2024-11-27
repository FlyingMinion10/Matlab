clearvars; 
clc;
close all;

% Definir las funciones a integrar
f1 = @(t) t.^2 + 3*t + 5;
f2 = @(t, wo) sin(wo * t);

% Configurar los parámetros para la integración
wo = 2; % Frecuencia para la función f2(t)
a = 0; % Límite inferior de integración
b = 10; % Límite superior de integración
n = 50; % Número de subintervalos

% Discretización del intervalo
t = linspace(a, b, n+1);
dt = (b - a) / n;

% Integración numérica por el método del Rectángulo
rect_f1 = sum(f1(t(1:end-1))) * dt;
rect_f2 = sum(f2(t(1:end-1), wo)) * dt;

% Integración numérica por el método del Trapecio
trap_f1 = (sum(f1(t)) - 0.5 * (f1(a) + f1(b))) * dt;
trap_f2 = (sum(f2(t, wo)) - 0.5 * (f2(a, wo) + f2(b, wo))) * dt;

% Mostrar los resultados
fprintf('Integración de f1(t) por el método del Rectángulo: %.4f\n', rect_f1);
fprintf('Integración de f1(t) por el método del Trapecio: %.4f\n', trap_f1);
fprintf('Integración de f2(t) por el método del Rectángulo: %.4f\n', rect_f2);
fprintf('Integración de f2(t) por el método del Trapecio: %.4f\n', trap_f2);

% Graficar las funciones y sus áreas aproximadas
figure;

% Gráfica de f1(t) con método del Rectángulo
subplot(2, 2, 1);
plot(t, f1(t), 'b', 'LineWidth', 1.5);
hold on;
for i = 1:n
    x_rect = [t(i), t(i+1), t(i+1), t(i)];
    y_rect = [0, 0, f1(t(i)), f1(t(i))];
    fill(x_rect, y_rect, 'g', 'FaceAlpha', 0.4, 'EdgeColor', 'k');
end
xlabel('t'); ylabel('f1(t)');
title('f1(t) - Método Rectángulo');
legend('f1(t)', 'Rectángulo');
hold off;

% Gráfica de f1(t) con método del Trapecio
subplot(2, 2, 2);
plot(t, f1(t), 'b', 'LineWidth', 1.5);
hold on;
for i = 1:n
    x_trap = [t(i), t(i+1), t(i+1), t(i)];
    y_trap = [0, 0, f1(t(i+1)), f1(t(i))];
    fill(x_trap, y_trap, 'g', 'FaceAlpha', 0.4, 'EdgeColor', 'k');
end
xlabel('t'); ylabel('f1(t)');
title('f1(t) - Método Trapecio');
legend('f1(t)', 'Trapecio');
hold off;

% Gráfica de f2(t) con método del Rectángulo
subplot(2, 2, 3);
plot(t, f2(t, wo), 'r', 'LineWidth', 1.5);
hold on;
for i = 1:n
    x_rect = [t(i), t(i+1), t(i+1), t(i)];
    y_rect = [0, 0, f2(t(i), wo), f2(t(i), wo)];
    fill(x_rect, y_rect, 'b', 'FaceAlpha', 0.4, 'EdgeColor', 'k');
end
xlabel('t'); ylabel('f2(t)');
title('f2(t) - Método Rectángulo');
legend('f2(t)', 'Rectángulo');
hold off;

% Gráfica de f2(t) con método del Trapecio
subplot(2, 2, 4);
plot(t, f2(t, wo), 'r', 'LineWidth', 1.5);
hold on;
for i = 1:n
    x_trap = [t(i), t(i+1), t(i+1), t(i)];
    y_trap = [0, 0, f2(t(i+1), wo), f2(t(i), wo)];
    fill(x_trap, y_trap, 'b', 'FaceAlpha', 0.4, 'EdgeColor', 'k');
end
xlabel('t'); ylabel('f2(t)');
title('f2(t) - Método Trapecio');
legend('f2(t)', 'Trapecio');
hold off;
