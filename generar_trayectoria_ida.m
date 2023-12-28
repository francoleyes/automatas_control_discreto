function [trayectoria_x, trayectoria_y] = generar_trayectoria_ida(punto_limite, grados, punto_inicial, punto_final)
coef_seguridad = 3;
punto_limite(2) = punto_limite(2) + coef_seguridad;
y_sup = 40;
tang = tan(grados*pi/180);
altura_bajar = 2; % Altura desde donde empieza a bajar en línea recta
punto_bajar_linea_recta = [punto_final(1), punto_final(2) + altura_bajar];
punto_bajar_oblicuo = [punto_inicial(1)-tang*(y_sup-punto_bajar_linea_recta), punto_inicial(2)];
pos_actual = punto_inicial;
trayectoria_x = pos_actual(1);
trayectoria_y = pos_actual(2);

% Verifico dependiendo de donde se encuentra, si está muy cerca del borde 
% del muelle entonces directamente sube hasta la parte sup
if pos_actual(1) < -5
    
    % Primer tramo (subir línea recta)
    altura_subir = 30;
    punto_a_subir = pos_actual(2) + altura_subir;
    % Verifico si puedo hacer un primer tramo en línea recta si es que no
    % supera la parte sup
    if punto_a_subir < y_sup
        pos_actual(2) = punto_a_subir;
        trayectoria_x = [trayectoria_x, pos_actual(1)];
        trayectoria_y = [trayectoria_y, pos_actual(2)];
    end

    % Segundo tramo (subir oblicuo)
    pos_actual(1) = pos_actual(1) + tang*(y_sup-pos_actual(2))
    pos_actual(2) = y_sup;
    trayectoria_x = [trayectoria_x, pos_actual(1)];
    trayectoria_y = [trayectoria_y, pos_actual(2)];
else
    % Primer tramo (subir línea recta)
    pos_actual(2) = y_sup;
    trayectoria_x = [trayectoria_x, pos_actual(1)];
    trayectoria_y = [trayectoria_y, pos_actual(2)];
end

% Tercer y cuarto tramo (avanzar en horizontal y bajar en oblicuo)
puede_bajar = false;
while ~puede_bajar
    m = (punto_bajar_linea_recta(2) - y_sup) / (punto_bajar_linea_recta(1) - pos_actual(1));
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
trayectoria_x = [trayectoria_x, punto_bajar_linea_recta(1)];
trayectoria_y = [trayectoria_y, punto_bajar_linea_recta(2)];

% Quinto tramo (bajar en línea recta)
trayectoria_x = [trayectoria_x, punto_final(1)];
trayectoria_y = [trayectoria_y, punto_final(2)];

end