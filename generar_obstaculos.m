function [contenedor_pos, y_superior] = generar_obstaculos()
    % Inicializar la figura
    figure;
    hold on;
    xlabel('x');
    ylabel('y');
    grid on;
    axis([-35, 55, -20, 50]);

    % Izaje
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
    num_columnas = 16;
    num_contenedores_min = 10;
    num_contenedores_max = 18;

    contenedor_pos = zeros(num_contenedores_max, num_columnas);

    for columna = 1:num_columnas
        % Dibujo de todos los contenedores en la fila actual
        num_contenedores_fila = randi([num_contenedores_min, num_contenedores_max]);
        posiciones_fila = zeros(num_contenedores_fila, 2);

        for i = 1:num_contenedores_fila
            contenedor_pos(i,columna) = 1;
            
            % ------------ Para graficar -------------
            pos_x = 2.5 + (columna - 1) * 3;
            pos_y = -20 + (i - 1) * 2.5;
            % Almacena la posición del contenedor
            posiciones_fila(i, :) = [pos_x, pos_y];
            
            % Dibuja el contenedor
            rectangle('Position', [pos_x, pos_y, 2.5, 2.5], 'EdgeColor', 'r', 'LineWidth', 2);
            % Etiqueta 'x' en el centro del contenedor
            x_center = pos_x + 1.25;
            y_center = pos_y + 1.25;
            text(x_center, y_center, 'x', 'Color', 'r', 'FontSize', 12, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
        end
        
    end
    
    unos_por_columna = sum(contenedor_pos); % Me da la suma de cada columna
    max_contenedores = max(unos_por_columna); % Busco el máximo de la suma de cada columna
    
    coef_seguridad = 5;
    y_superior = max_contenedores*2.5 + coef_seguridad;
end