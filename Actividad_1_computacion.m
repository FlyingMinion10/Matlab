
% Actividad 1 Matlab
% Autor Juan Felipe Zepeda del Toro
% fecha 01/11/2024

% Descripción: Este script de MATLAB está diseñado para visualizar 
% datos mediante gráficas de líneas, áreas y escaleras. Calcula la 
% suma total de cinco áreas utilizando tres métodos diferentes: suma 
% directa, función anónima y bucle for. Luego, imprime los resultados 
% en la consola para comparar la eficacia de cada método. En resumen, 
% sirve para demostrar distintas técnicas de cálculo y visualización 
% de datos en MATLAB.

% limpieza de consola
clearvars  
clc
close all

% definir variables para la grafica
x = 1:11;
y1(1,1:3) = 2;
y2(1,1:3) = 4;
y3(1,1:1) = 1;
y4(1,1:1) = 6;
y5(1,1:3) = 3;

yt = [y1, y2, y3, y4, y5];

% graficas
figure % crear una grafica
plot(x, yt, 'LineWidth', 2)
ylabel('Eje Y')
xlabel('Eje X')
grid on
title('Actividad 1')

figure
area(yt)
grid on

figure
stairs(x, yt)

% teorema del rectangulo (integracion numerica)
% calculos matematicos (sacar el area de cada cuadrado)

% Forma básica
a1 = 6;
a2 = 12;
a3 = 1;
a4 = 6;
a5 = 9;
at_basica = a1 + a2 + a3 + a4 + a5;

% Forma con función anónima
areas = [a1, a2, a3, a4, a5];
sumar_areas = @(areas) sum(areas);
at_funcion_anonima = sumar_areas(areas);

% Forma utilizando for
at_for = 0;
for i = 1:length(areas)
    at_for = at_for + areas(i);
end

% Mostrar resultados
fprintf('Suma de áreas (forma básica): %d\n', at_basica);
fprintf('Suma de áreas (función anónima): %d\n', at_funcion_anonima);
fprintf('Suma de áreas (for loop): %d\n', at_for);

% ¿Qué y cómo cambiaria mi código si es que las áreas fueran triángulos?
    % Considerando la mismas bases y alturas en las figuras, se debe cambiar 
    % la fórmula para calcular el área de un triángulo. Es decir las areas 
    % se reducen a la mitad.

% Los beneficios de usar una función anónima son:
    % Simplicidad y legibilidad: Las funciones anónimas te 
    % permiten definir funciones pequeñas y simples de forma 
    % rápida, sin necesidad de crear un archivo de función separado.
    % Concisión: Puedes definir y usar la función en la misma 
    % línea de código, reduciendo la cantidad de código necesario.

% La sintaxis de una función anónima en MATLAB es la siguiente:    
    % nombre_funcion = @(argumentos) expresión;
    % @: Indica que es una función anónima.
    % argumentos: Lista de parámetros de entrada.
    % expresión: El valor que se devuelve cuando se llama a la función.
