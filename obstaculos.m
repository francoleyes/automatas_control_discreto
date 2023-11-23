hold on
% Muelle
% Línea horizontal
x_muelle_h = -35:0;
y_muelle_h = zeros(size(x_muelle_h));
plot(x_muelle_h, y_muelle_h, 'k', 'LineWidth', 2);

% Línea vertical
y_muelle_v = -20:0;
x_muelle_v = zeros(size(y_muelle_v));
plot(x_muelle_v, y_muelle_v, 'k', 'LineWidth', 2);

% Barco
% Horizontal abajo
x_barco_h_a = 2.5:50;
y_barco_h_a = ones(size(x_barco_h_a)) * -20;
plot(x_barco_h_a, y_barco_h_a, 'y', 'LineWidth', 4);

% Horizontal izquierda
x_barco_h_i = 0:2.5;
y_barco_h_i = zeros(size(x_barco_h_i));
plot(x_barco_h_i, y_barco_h_i, 'y', 'LineWidth', 4);

% Vertical izquierda
y_barco_v = -20:0;
x_barco_v_i = ones(size(y_muelle_v)) * 2.5;
plot(x_barco_v_i, y_barco_v, 'y', 'LineWidth', 4);

% Vertical derecha
x_barco_v_d = ones(size(y_muelle_v)) * 50;
plot(x_barco_v_d, y_barco_v, 'y', 'LineWidth', 4);

% Contenedores dentro del barco
num_filas = 19;
num_contenedores_min = 10;
num_contenedores_max = 18;

% Generar posiciones aleatorias para los contenedores dentro del barco por fila
for fila = 1:num_filas
    num_contenedores_fila = randi([num_contenedores_min, num_contenedores_max])
    
    for i = 1:num_contenedores_fila
        pos_x = 2.5 + (fila - 1) * 2.5;
        pos_y = -20 + (i - 1) * 2.5;
        
        % Dibujar el contenedor
        rectangle('Position', [pos_x, pos_y, 2.5, 2.5], 'EdgeColor', 'r', 'LineWidth', 2);
        
        % Dibujar la "x" dentro del contenedor
        x_center = pos_x + 1.25;
        y_center = pos_y + 1.25;
        text(x_center, y_center, 'x', 'Color', 'r', 'FontSize', 12, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    end
end

hc_izaje = 2.5;
x_izaje = -35:55;
yt0 = ones(size(x_izaje)) * 45;
plot(x_izaje, yt0, '*b');

xlabel('x');
ylabel('y');
grid on;
axis([-35, 55, -20, 50]);

