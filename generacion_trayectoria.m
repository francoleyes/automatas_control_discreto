clear, clc, close all

punto_limite = [5,5];
punto_inicial = [5.5,0];
tang = tan(30*pi/180);
y_sup = 10;
pos_actual = punto_inicial;
subir = 0;
puede_subir = false;

trayectoria_x = punto_inicial(1);
trayectoria_y = punto_inicial(2);

while ~puede_subir
    dist = tang * (y_sup - pos_actual(2));
    m = (y_sup - pos_actual(2)) / ((pos_actual(1) - dist) - pos_actual(1));
    b = pos_actual(2) - m * pos_actual(1);
    
    interseccion_x = m * punto_limite(1) + b;
    interseccion_y = (punto_limite(2) - b) / m;
    
    if interseccion_x <= punto_limite(2) || interseccion_x <= punto_limite(1)
        subir = subir + 0.5;
        pos_actual = [pos_actual(1), pos_actual(2) + 0.5];
        
        trayectoria_x = [trayectoria_x, pos_actual(1)];
        trayectoria_y = [trayectoria_y, pos_actual(2)];
    else
        puede_subir = true;
    end
end

trayectoria_x = [trayectoria_x, pos_actual(1)-dist];
trayectoria_y = [trayectoria_y, y_sup];
if ~isempty(trayectoria_x) && ~isempty(trayectoria_y)
    figure;
    plot(trayectoria_x, trayectoria_y, 'LineWidth', 2);
    hold on;
    plot(punto_inicial(1), punto_inicial(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
    plot(punto_limite(1), punto_limite(2), 'go', 'MarkerSize', 10, 'LineWidth', 2);
    xlabel('X');
    ylabel('Y');
    title('Trayectoria Generada');
    legend('Trayectoria', 'Punto Inicial', 'Punto Límite');
    grid on;

    xlim([min(trayectoria_x), max(trayectoria_x)]);
    ylim([min(trayectoria_y), max(trayectoria_y)]);
    hold off;
else
    disp('No hay datos para graficar la trayectoria.');
end

