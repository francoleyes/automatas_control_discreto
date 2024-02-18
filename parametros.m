

% ||================================||
% || Parámetros del Sistema Físico  ||
% ||================================||
Y_t0 = 45;                       %[m]------------------------* Altura poleas suspension izaje *  
H_c = 2.5;                       %[m]------------------------* Ancho y alto de container est  *
M_s = 15000;                     %[Kg]-----------------------*   Masa spreader + headnlock    *
M_c_MAX = 50000 + M_s;           %[Kg]-----------------------* Masa nominal containers a izar *
M_c_MIN = 2000;                  %[Kg]-----------------------*   Masa container vacio a izar  *
g = 9.80665;                     %[m/s2]---------------------*    Aceleracion gravitatoria    *

M_real = 10000;

TensionMinima=(M_s*g/2)*0.5;           %[N]------------------------*    Umbral de tensión mínima    *

% ||================================||
% ||        Variables Izaje         ||
% ||================================||
r_hd = 0.75;                      %[m]-----------------------*   Radio primitivo del tambor   *
r_h = 22;                         %[ ]-----------------------*  Relacion de trans caja reduct *

J_hd_hEb = 3800;                  %[kg.m2]-------------------*  Momento de inercia eje lento  *
J_hm_hb = 30;                     %[kg.m2]-------------------*  Momento de inercia eje rapido *

b_hd = 8.0;                       %[N.m.s/rad]---------------*  Coef fricc viscosa eje lento  *
b_hm = 18;                        %[N.m.s/rad]---------------*  Coef fric viscosa eje rapido  *
b_hb = 1*10^8;                    %[N.m.s/rad]---------------* Coef fric visc Freno operacion *
b_hEb = 2.2*10^9;                 %[N.m.s/rad]---------------* Coef fric visc Fren emergencia *

T_hEb_MAX = 1.1*10^6;             %[N.m]---------------------* Torque max freno de emergencia *
T_hb_MAX = 5*10^4;                %[N.m]---------------------*    T max freno de operacion    *
T_hm_MAX = 2*10^4;                %[N.m]---------------------*    T max motorizacion/FrenR    *

tau_hm = 1e-3;                    %[ms]----------------------* Constante tiempo mod de torque *
tau_hm =1.0e-2;
J_eqh = 2*(J_hd_hEb+J_hm_hb*(r_h^2))/r_hd; %-----------------* Momento de inercia equivalente *
b_eqh = 2*(b_hd+b_hm*(r_h^2))/r_hd;        %-----------------*  Friccion viscosa equivalente  *

% ||================================||
% ||      ----> Carga Suspendida:
% ||
k_wu = 2.36*10^8;                 %[N/m]----------------------*  Rigidez equiv a tracc cable C *
b_wu = 150;                       %[N.s/m]--------------------*   Friccion int hilos roz int   *


% ||================================||
% ||      ----> Limites Movimiento Vertical:
% ||
x_h_MIN = -20; % [m]
x_h_MAX = +40; % [m]
v_h_MIN_c = -1.5;  % [m/s]
v_h_MAX_c = +1.5; % [m/s]
v_h_MIN_sc = -3;  % [m/s]
v_h_MAX_sc = +3; % [m/s]
dv_h_MIN = -0.75;  % [m/s2]
dv_h_MAX = +0.75; % [m/s2]
w_hm_min=pi/4;        %[rad/s]
w_hm_max=((2*r_h)/r_hd)*v_h_MAX_sc;

% ||================================||
% ||        Variables carro         ||
% ||================================||
r_td = 0.5;                       %[m]-----------------------*   Radio primitivo del tambor   *
r_t = 30;                         %[ ]-----------------------*  Relacion de trans caja reduct *

J_td = 1200;                      %[kg.m2]-------------------*  Momento de inercia eje lento  *
J_tm_tb = 7;                      %[kg.m2]-------------------*  Momento de inercia eje rapido *

b_td = 1.8;                       %[N.m.s/rad]---------------*  Coef fricc viscosa eje lento  *
b_tm = 6;                         %[N.m.s/rad]---------------*  Coef fric viscosa eje rapido  *
b_tb = 5*10^6;                    %[N.m.s/rad]---------------* Coef fric visc Freno operacion *

T_tm_MAX = 3*10^3;                %[N.m]---------------------*    T max motorizacion/FrenR    *
T_tb_MAX = 5*10^3;                %[N.m]---------------------*    T max freno de operacion    *

tau_tm = 1e-3;                    %[ms]----------------------* Constante tiempo mod de torque *
tau_tm =1.0e-2;
J_eq = (J_td+J_tm_tb*(r_t^2))/r_td; %----------* Momento de inercia equivalente *
b_eq = (b_td+b_tm*(r_t^2))/r_td;    %----------*  Friccion viscosa equivalente  *

% ||================================||
% ||      ----> Carro y Cable de Acero:
% ||
M_t = 30000;                      %[Kg]----------------------*   Masa equivalente del carro   *
b_t = 90;                         %[N.s/m]-------------------* Coef fric visc equiv del carro *
K_tw = 4.8*10^5;                  %[N/m]---------------------*  Rigidez equiv a tracc cable T *
b_tw = 3*10^3;                    %[N.s/m]-------------------*  Friccion total cable tensado  *

% ||================================||
% ||      ----> Limites Movimiento Horizontal:
% ||
x_t_MIN = -30; % [m]
x_t_MAX = +50; % [m]
v_t_MIN = -4;  % [m/s]
v_t_MAX = +4; % [m/s]
dv_t_MIN = -1;  % [m/s2]
dv_t_MAX = +1; % [m/s2]
w_tm_min=pi/4; % [rad/s]


% ||=======================================||
% || Carga apoyada, parámetros de contacto ||
% ||=======================================||
K_cy = 1.8*10^9;                 %[N/m]----------------------*  Rigidez equiv a comp vertical *
b_cy = 1*10^7;                   %[N.s/m]--------------------*   Friccion int por contacto v  *
b_cx = 1*10^6;                   %[N.s/m]--------------------*   Friccion de arrastre horiz   *


% ||================================||
% ||         Controladores          ||
% ||================================||
T_s2 = 5e-3;
T_s1 = 20e-3;
T_s0 = 20e-3;


% ||================================||
% ||================================||
% ||       NIVEL DE CONTROL 2       ||
% ||================================||
% ||================================||

%||================================||
%||     Controlador de izaje       ||
%||
 
m_l_ = M_s + M_real;             %[Kg]---------------------* Masa para calcular las ganancias *

coef_h = [(-1/r_h)*(J_eqh+m_l_*r_hd/2); (-1/r_h)*b_eqh; 0];
polos_h = roots(coef_h);

w_posh = -7*polos_h(2);         %[rad/s]------------------* Frecuencia calcular las ganancias *

n_h = 3;                         %[ ]----------------------*       Método sintonía serie       *

b_ha = b_eqh/r_h - n_h*w_posh*(J_eqh + 0.5*m_l_*r_hd)/r_h;     %[ ]----------------------*   Ganancia Derivativa   *
K_hsa = -n_h*(w_posh^2)*(J_eqh + 0.5*m_l_*r_hd)/r_t;           %[ ]----------------------*  Ganancia Proporcional  *
K_hsia = -(w_posh^3)*(J_eqh + 0.5*m_l_*r_hd)/r_t;             %[ ]----------------------*    Ganancia Integral    *

%||================================||
%||      Controlador de carro      ||
%||

J_eqt = M_t + ((r_t/r_td)^2)*J_tm_tb + J_td/(r_td^2) + m_l_; %[ ]----------------------* Momento de inercia equivalente *
b_eqt = ((r_t/r_td)^2)*b_tm + b_td/(r_td^2) + b_t;           %[ ]----------------------*  Friccion viscosa equivalente  *

coef_t = [r_td*(J_eqt)/r_t; r_td*(b_eqt)/r_t; 0];
polos_t = roots(coef_t);
w_post = -10*polos_t(2);         %[rad/s]------------------* Frecuencia calcular las ganancias *

n_t = 3;                         %[ ]----------------------*       Método sintonía serie       *

b_ta = n_t*w_post*(r_td*J_eqt/r_t) - r_td*b_eqt/r_t;         %[ ]----------------------*   Ganancia Derivativa   *
K_tsa = n_t*(w_post^2)*J_eqt*r_td/r_t;                       %[ ]----------------------*  Ganancia Proporcional  *
K_tsia = (w_post^3)*J_eqt*r_td/r_t;                          %[ ]----------------------*    Ganancia Integral    *




%||================================||
%||     Condiciones iniciales      ||
%||================================||
xt_inicial = -10;               %   41.5;   -10.00;         47.0615    ;           -20.8700    
yl_inicial = 5;
lh_inicial = 45-yl_inicial;
pos_inicial=[xt_inicial, yl_inicial];

%FILTRO JOYSTICK
f=0.1;     

dt=5e-3;

%_________COSAS NO NUESTRAS, SOLO PARA COMPARAR
Matriz_Contenedores =[8 8 6 16 11 8 6 16 11 8 9 10 1];
Matriz_Muelle =[1 0 0];
hc_x=2.5;       %Ancho container
hc_y=2.5;       %Alto container
long_barco = 50; % Longitud total del barco en metros
ancho_pared = 1.1; %Pared de barco en metros
ancho_sb=ancho_pared/5;
long_puerto=25; % Longitud total útil del puerto en metros
cs=hc_x/5 ; % Coeficiente de seguridad que considera el ancho seguro de movimiento 
y_ref=-20;      % alturas del interior del barco respecto al muelle en metros
Delta_F_hw=20;  %  Umbral de estabilidad


% Fines de carrera
max_x_t=49;
min_x_t=-29;
max_y=-19;
min_y=39;

i_h = 22;
i_t = 30;
J_tmtb=7.0;    % [kg*m^2] Momento de inercia equivalente del eje rápido (motor, disco de freno de operación y etapa de entrada de caja reductora)
% 
