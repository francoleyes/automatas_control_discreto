function [perfil_vel] = obtener_perfil_velocidad(tipo, puntos, cargado, cant_puntos_discretizacion)
    % Obtener parámetros de aceleración y velocidad máxima
    [a_max, v_max] = obtenerParametros(tipo, cargado);

    % Inicializar el perfil de velocidad
    perfil_vel = zeros(1, 2);
    
    % Calcular el tiempo de transición
    t_trans = v_max / a_max;
    
    % Iterar sobre los puntos
    t_ant = 0;
    for i = 1:numel(puntos)-1
        dist = puntos(i+1) - puntos(i);
        abs_dist = abs(dist);
        
        % Calcular tiempo en tramo constante
        t_cte = abs_dist / v_max - t_trans;
        
        if t_cte > 0
            % Tramo con velocidad constante
            perfil_vel = [perfil_vel; 
                t_ant + t_trans, sign(dist)*v_max; 
                t_ant + t_trans + t_cte, sign(dist)*v_max; 
                t_ant + t_trans*2 + t_cte, 0];
        elseif t_cte == 0
            % Tramo sin velocidad constante pero llegando a la v_max
            perfil_vel = [perfil_vel; 
                t_ant + t_trans, sign(dist)*v_max; 
                t_ant + t_trans*2, 0];
        else
            % Tramo sin velocidad constante sin llegar a la v_max
            v_x = sqrt(a_max*abs_dist);
            t_x = abs_dist/v_x;
            perfil_vel = [perfil_vel; 
                t_ant + t_x, sign(dist)*v_x; 
                t_ant + t_x*2, 0];
        end
        
        % Actualizar tiempo anterior
        t_ant = perfil_vel(end, 1);
    end
    % Discretizar el perfil de velocidad al final
    % La opción 'pchip' en interp1 realiza una interpolación cúbica
    t_vals_discretizados = linspace(perfil_vel(1, 1), perfil_vel(end, 1), cant_puntos_discretizacion);
    v_vals_discretizados = interp1(perfil_vel(:, 1), perfil_vel(:, 2), t_vals_discretizados, 'pchip');
    
    perfil_vel = [t_vals_discretizados', v_vals_discretizados'];
end

function [a_max, v_max] = obtenerParametros(tipo, cargado)
    switch tipo
        case 'carro'
            a_max = 1;
            v_max = 4;
        otherwise
            a_max = 0.75;
            v_max = cargado * 1.5 + ~cargado * 3;
    end
end