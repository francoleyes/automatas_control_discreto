% clear, clc, close all

a_max = 200;
v_max = 500;
puntos = [0, 1500, 3500];


t_trans = v_max / a_max;
t_ant = 0;
perfil_vel = [0, 0];

for i = 1:size(puntos, 2)-1
    dist = puntos(i+1) - puntos(i)
    abs_dist = abs(dist);
    t_cte = abs_dist / v_max - t_trans;
    if t_cte > 0
        perfil_vel = [perfil_vel; 
            t_ant + t_trans, sign(dist)*v_max; 
            t_ant + t_trans + t_cte, sign(dist)*v_max; 
            t_ant + t_trans*2 + t_cte, 0];
    elseif t_cte == 0
        perfil_vel = [perfil_vel; 
            t_ant + t_trans, sign(dist)*v_max; 
            t_ant + t_trans*2, 0];
    else
        v_x = sqrt(a_max*abs_dist);
        t_x = abs_dist/v_x;
        perfil_vel = [perfil_vel; 
            t_ant + t_x, sign(dist)*v_x; 
            t_ant + t_x*2, 0];
    end
    t_ant = perfil_vel(end, 1);
end

figure
plot(perfil_vel(:, 1), perfil_vel(:, 2))
