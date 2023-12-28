function [trayectoria_x, trayectoria_y] = generar_trayectoria_vuelta(y_sup, punto_limite, punto_inicial, punto_final)
    % Parámetros
    grados = 30;
    coef_seguridad = 3;
    altura_bajar = 25; % Altura desde donde empieza a bajar en línea recta

    % Ajustes iniciales
    punto_limite(2) = punto_limite(2) + coef_seguridad;
    tang = tan(grados*pi/180);

    % Inicializar trayectoria
    trayectoria_x = punto_inicial(1);
    trayectoria_y = punto_inicial(2);
    pos_actual = punto_inicial;

    % Primer y segundo tramo (subir en línea recta y subir en oblicuo)
    puede_subir = false;
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

    % Ajuste de posición después de subir en oblicuo
    pos_actual(1) = pos_actual(1) - dist;
    pos_actual(2) = y_sup;
    trayectoria_x = [trayectoria_x, pos_actual(1)];
    trayectoria_y = [trayectoria_y, pos_actual(2)];

    % Tercer tramo (línea recta horizontal)
    punto_final_linea_recta = [punto_final(1) + tang * (y_sup - altura_bajar), y_sup];
    if punto_final_linea_recta(1) < pos_actual(1)
        trayectoria_x = [trayectoria_x, punto_final_linea_recta(1)];
        trayectoria_y = [trayectoria_y, punto_final_linea_recta(2)];
    end

    % Cuarto tramo (bajar en oblicuo)
    trayectoria_x = [trayectoria_x, punto_final(1)];
    trayectoria_y = [trayectoria_y, punto_final(2) + altura_bajar];

    % Quinto tramo (bajar en línea recta)
    trayectoria_x = [trayectoria_x, punto_final(1)];
    trayectoria_y = [trayectoria_y, punto_final(2)];
end