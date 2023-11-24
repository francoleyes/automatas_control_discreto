% Inicializar la figura
figure;
hold on;
xlabel('x');
ylabel('y');
grid on;
axis([-35, 55, -20, 50]);

% Izaje
hc_izaje = 2.5;
x_izaje = -35:55;
yt0 = ones(size(x_izaje)) * 45;
plot(x_izaje, yt0, '*b');

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

% Dibujo de todos los contenedores y perfil de seguridad
for fila = 1:num_filas
    % Dibujo de todos los contenedores en la fila actual
    num_contenedores_fila = randi([num_contenedores_min, num_contenedores_max]);
    posiciones_fila = zeros(num_contenedores_fila, 2);
    
    for i = 1:num_contenedores_fila
        pos_x = 2.5 + (fila - 1) * 2.5;
        pos_y = -20 + (i - 1) * 2.5;
        
        % Dibuja el contenedor
        rectangle('Position', [pos_x, pos_y, 2.5, 2.5], 'EdgeColor', 'r', 'LineWidth', 2);
        
        % Almacena la posición del contenedor
        posiciones_fila(i, :) = [pos_x, pos_y];
        
        % Etiqueta 'x' en el centro del contenedor
        x_center = pos_x + 1.25;
        y_center = pos_y + 1.25;
        text(x_center, y_center, 'x', 'Color', 'r', 'FontSize', 12, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    end
    
    % Almacena las posiciones de la fila
    contenedor_posiciones{fila} = posiciones_fila;
end

% Pausa para visualizar antes de empezar a desaparecer
pause(2);

% Bucle para desaparecer los contenedores de arriba hacia abajo
for fila = 1:num_filas
    num_contenedores_fila = size(contenedor_posiciones{fila}, 1);
    
    % Punto de inicio
    start_point = [-30, 45];

    % Trayectoria hacia el contenedor superior de la fila actual
    first_container_top_center = contenedor_posiciones{fila}(end, :) + [1.25, 2.5];
    trayectoria_x = [start_point(1), first_container_top_center(1), first_container_top_center(1)];
    trayectoria_y = [start_point(2), 45, first_container_top_center(2)];

    % Dibujar la trayectoria hacia el contenedor superior
    plot(trayectoria_x, trayectoria_y, 'g', 'LineWidth', 2);

    % Pausa para visualizar antes de empezar a desaparecer
    pause(1);

    % Bucle para desaparecer los contenedores de arriba hacia abajo
    for i = num_contenedores_fila:-1:1
        % Trayectoria de bajada
        contenedor_actual = contenedor_posiciones{fila}(i, :);
        trayectoria_bajada_x = [first_container_top_center(1), contenedor_actual(1) + 1.25];
        trayectoria_bajada_y = [first_container_top_center(2), contenedor_actual(2) + 2.5];

        % Dibujar la trayectoria de bajada
        plot(trayectoria_bajada_x, trayectoria_bajada_y, 'g', 'LineWidth', 2);
        drawnow;
        
        % Trayectoria de vuelta
        trayectoria_vuelta_x = [contenedor_actual(1) + 1.25, contenedor_actual(1)+ 1.25, return_destination(1), return_destination(1)];
        trayectoria_vuelta_y = [contenedor_actual(2) + 2.5, 45, 45, return_destination(2)];

        % Dibujar la trayectoria de vuelta al muelle
        plot(trayectoria_vuelta_x, trayectoria_vuelta_y, '--m', 'LineWidth', 2);

        % Pausa para visualizar antes de eliminar el contenedor
        pause(1);

        % Eliminar gráficamente el contenedor que se llevó
        rectangle('Position', [contenedor_actual(1), contenedor_actual(2), 2.5, 2.5], 'EdgeColor', 'w', 'LineWidth', 2);

        % Actualizar la figura
        drawnow;

        % Pausa para visualizar antes de pasar al siguiente contenedor
        pause(1)
    end
    
    % Pausa para visualizar antes de pasar a la siguiente fila
    pause(1);
end