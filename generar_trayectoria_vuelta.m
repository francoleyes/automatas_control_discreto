function [trayectoria_x, trayectoria_y] = generar_trayectoria_vuelta(punto_limite, grados, punto_inicial, punto_final)
    coef_seguridad = 3;
    punto_limite(2) = punto_limite(2) + coef_seguridad;
    tang = tan(grados*pi/180);
    trayectoria_x = punto_inicial(1);
    trayectoria_y = punto_inicial(2);
    pos_actual = punto_inicial;
    y_sup = 40;
    puede_subir = false;
    % Primer tramo y segundo tramo (subir en línea recta y subir en oblicuo)
    while ~puede_subir
        dist = tang * (y_sup - pos_actual(2));
        m = (y_sup - pos_actual(2)) / ((pos_actual(1) - dist) - pos_actual(1));
        b = pos_actual(2) - m * pos_actual(1);

        interseccion_x = m * punto_limite(1) + b;
        interseccion_y = (punto_limite(2) - b) / m;

        if interseccion_x <= punto_limite(2) || interseccion_x <= punto_limite(1)
            pos_actual = [pos_actual(1), pos_actual(2) + 0.5];

            trayectoria_x = [trayectoria_x, pos_actual(1)];
            trayectoria_y = [trayectoria_y, pos_actual(2)];
        else
            puede_subir = true;
        end
    end
    
    pos_actual(1) = pos_actual(1)-dist;
    pos_actual(2) = y_sup;
    trayectoria_x = [trayectoria_x, pos_actual(1)];
    trayectoria_y = [trayectoria_y, pos_actual(2)];
    
    % Segundo tramo (línea recta horizontal)
    altura_bajar = 30; % Altura desde donde empieza a bajar en línea recta
    punto_bajar_oblicuo_y = tang * (y_sup - altura_bajar);
    if (punto_final(1) + punto_bajar_oblicuo_y) < pos_actual(1)
        punto_final_linea_recta = [punto_final(1)+punto_bajar_oblicuo_y, y_sup];
        trayectoria_x = [trayectoria_x, punto_final_linea_recta(1)];
        trayectoria_y = [trayectoria_y, punto_final_linea_recta(2)];
    end
    % Tercer tramo (bajar en oblicuo)
    trayectoria_x = [trayectoria_x, punto_final(1)];
    trayectoria_y = [trayectoria_y, punto_final(2)+altura_bajar];
    
    % Cuarto tramo (bajar en línea recta)
    trayectoria_x = [trayectoria_x, punto_final(1)];
    trayectoria_y = [trayectoria_y, punto_final(2)];
end