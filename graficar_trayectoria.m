function [] = graficar_trayectoria(trayectoria_x, trayectoria_y, punto_limite, punto_inicial, punto_final)
    if ~isempty(trayectoria_x) && ~isempty(trayectoria_y)
        figure;
        plot(trayectoria_x, trayectoria_y, 'LineWidth', 2);
        hold on;
        plot(punto_inicial(1), punto_inicial(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2, 'Color', [1, 0.5, 0]);
        plot(punto_final(1), punto_final(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
        plot(punto_limite(1), punto_limite(2), 'go', 'MarkerSize', 10, 'LineWidth', 2);
        xlabel('X');
        ylabel('Y');
        title('Trayectoria Generada');
        legend('Trayectoria', 'Punto Inicial', 'Punto Final', 'Punto Límite');
        grid on;
        axis([-35, 55, -20, 50]);
        hold off;
    else
        disp('No hay datos para graficar la trayectoria.');
    end
end