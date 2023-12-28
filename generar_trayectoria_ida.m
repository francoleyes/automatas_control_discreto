function [trayectoria_x, trayectoria_y] = generar_trayectoria_ida(y_sup, punto_limite, punto_inicial, punto_final)
    % Parámetros
    grados = 30;
    coef_seguridad = 3;

    % Ajustes iniciales
    punto_limite(2) = punto_limite(2) + coef_seguridad;
    tang = tan(grados*pi/180);

    % Inicializar trayectoria
    trayectoria_x = punto_inicial(1);
    trayectoria_y = punto_inicial(2);
    pos_actual = punto_inicial;

    % Verificar si está cerca del borde del muelle para subir directamente
    if pos_actual(1) < -5
        % Si la pos_actual es mayor a la y_sup directamente va a avanzar
        if pos_actual(2) < y_sup
            % Primer tramo (subir línea recta)
            altura_subir_bajar = 25;
            punto_a_subir = pos_actual(2) + altura_subir_bajar;

            % Verificar si puede hacer un primer tramo en línea recta sin superar la parte superior
            if punto_a_subir < y_sup
                pos_actual(2) = punto_a_subir;
                trayectoria_x = [trayectoria_x, pos_actual(1)];
                trayectoria_y = [trayectoria_y, pos_actual(2)];
            end

            % Segundo tramo (subir oblicuo)
            pos_actual(1) = pos_actual(1) + tang * (y_sup - pos_actual(2));
            pos_actual(2) = y_sup;
            trayectoria_x = [trayectoria_x, pos_actual(1)];
            trayectoria_y = [trayectoria_y, pos_actual(2)];   
        end

    else
        % Primer tramo (subir/bajar línea recta)
        pos_actual(2) = y_sup;
        trayectoria_x = [trayectoria_x, pos_actual(1)];
        trayectoria_y = [trayectoria_y, pos_actual(2)];
    end

    % Tercer y cuarto tramo (avanzar en horizontal y bajar en oblicuo)
    puede_bajar = false;
    while ~puede_bajar
        m = (punto_final(2) - y_sup) / (punto_final(1) - pos_actual(1));
        b = pos_actual(2) - m * pos_actual(1);

        interseccion_x = m * punto_limite(1) + b;
        interseccion_y = (punto_limite(2) - b) / m;

        if interseccion_x <= punto_limite(2) || interseccion_x <= punto_limite(1)
            pos_actual = [pos_actual(1) + 0.5, pos_actual(2)];
            trayectoria_x = [trayectoria_x, pos_actual(1)];
            trayectoria_y = [trayectoria_y, pos_actual(2)];
        else
            puede_bajar = true;
        end
    end

    % Quinto tramo (bajar en línea recta)
    trayectoria_x = [trayectoria_x, punto_final(1)];
    trayectoria_y = [trayectoria_y, punto_final(2)];
end