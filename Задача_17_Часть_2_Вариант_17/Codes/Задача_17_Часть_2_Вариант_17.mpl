
restart;  with(plots):  with(plottools):  Digits coloneq 15;    #

   Числовые значения констант (evalf обязательно!)  tau_val 

  coloneq evalf(2 + sqrt(5/3));  T_val coloneq evalf(1.5 * (1 + 

  sqrt(5/3)));  x2_tau coloneq evalf(sqrt(5/3));  x1_tau coloneq 

  uminus01/6;    # Функции состояния и управления  x1_t coloneq t

   srarr piecewise(t leq tau_val, 1 uminus0 2*t + t^2/2, x1_tau +

   x2_tau*(tuminus0tau_val) uminus0 (tuminus0tau_val)^2):  x2_t 

  coloneq t srarr piecewise(t leq tau_val, uminus02 + t, x2_tau 

  uminus0 2*(tuminus0tau_val)):  u_t coloneq t srarr piecewise(t 

  leq tau_val, 1, uminus02):    frames coloneq 100;    #

   =============================================================\

  ========  # ГРАФИК 1: ФАЗОВЫЙ ПОРТРЕТ  #

   =============================================================\

  ========    Gamma1 coloneq plot(uminus0x2^2/4 + 1/4, x2=1..2.5,

   color=black, thickness=2, linestyle=dot):  Gamma2 coloneq plot

  (x2^2/2 uminus0 1/2, x2=uminus02.5..1, color=black, thickness=2

  , linestyle=dot):  Gamma coloneq display(Gamma1, Gamma2):    #

   Две отдельные точки (Maple не поддерживает разные символы в 

   одном pointplot)  pt_start coloneq pointplot([1, uminus02], 

  symbol=solidcircle, symbolsize=20, color=black):  pt_end 

  coloneq pointplot([0, 1], symbol=diamond, symbolsize=20, color=

  black):    seq_plots1 coloneq [seq(      display(          

  Gamma, pt_start, pt_end,          plot([x1_t(t), x2_t(t), t=0..

  min(evalf(i*T_val/frames), tau_val)], color=blue, thickness=3),

            `if`(evalf(i*T_val/frames) > tau_val,                

  plot([x1_t(t), x2_t(t), t=tau_val..evalf(i*T_val/frames)], 

  color=green, thickness=3),                NULL),          

  pointplot([evalf(x1_t(i*T_val/frames)), evalf(x2_t(i*T_val/

  frames))], symbol=solidcircle, symbolsize=25, color=orange),   

         title=cat("Фазовый портрет. t = ", evalf[2](i*T_val/

  frames)),          labels=["x_1", "x_2"],          view=[

  uminus01.5..1.5, uminus02.5..2.5],          scaling=constrained

        ),      i=1..frames  )]:  anim1 coloneq display(

  seq_plots1, insequence=true):      #

   =============================================================\

  ========  # ГРАФИК 2: ГРАФИКИ ОТ ВРЕМЕНИ  #

   =============================================================\

  ========    p_x1_static coloneq plot(x1_t(t), t=0..T_val, color

  =blue, thickness=2, legend="x_1(t)"):  p_x2_static coloneq plot

  (x2_t(t), t=0..T_val, color=red, thickness=2, legend="x_2(t)"):

      seq_plots2 coloneq [seq(      display(          p_x1_static

  , p_x2_static,          #

   Вертикальная линия: plot([x,x], [y1,y2])          plot([evalf(

  i*T_val/frames), evalf(i*T_val/frames)], [uminus03, 3], color=

  black, linestyle=dash, thickness=2),          pointplot([evalf(

  i*T_val/frames), evalf(x1_t(i*T_val/frames))], symbol=

  solidcircle, symbolsize=20, color=blue),          pointplot

  ([evalf(i*T_val/frames), evalf(x2_t(i*T_val/frames))], symbol=

  solidcircle, symbolsize=20, color=red),          title=cat(

  "Координаты и скорость. t = ", evalf[2](i*T_val/frames)),      

      labels=["Время t", "Значения"],          view=[0..T_val, 

  uminus03..3]      ),      i=1..frames  )]:  anim2 coloneq 

  display(seq_plots2, insequence=true):      #

   =============================================================\

  ========  # ГРАФИК 3: УПРАВЛЕНИЕ U(T)  #

   =============================================================\

  ========    p_u_step coloneq plot(u_t(t), t=0..T_val, color=

  black, thickness=4, discont=true, legend="u(t)"):  #

   Горизонтальные линии: plot([x1,x2], [y1,y2])  p_level1 coloneq

   plot([0, T_val], [1, 1], color=green, linestyle=dot, thickness

  =1):  p_level2 coloneq plot([0, T_val], [uminus02, uminus02], 

  color=red, linestyle=dot, thickness=1):    seq_plots3 coloneq 

  [seq(      display(          p_u_step, p_level1, p_level2,     

       plot([evalf(i*T_val/frames), evalf(i*T_val/frames)], 

  [uminus03, 2], color=black, linestyle=dash, thickness=1),      

      pointplot([evalf(i*T_val/frames), `if`(evalf(i*T_val/frames

  ) leq tau_val, 1, uminus02)],                     symbol=

  solidcircle, symbolsize=30,                     color=`if`(

  evalf(i*T_val/frames) leq tau_val, green, red)),          title

  =cat("Управление u(t). t = ", evalf[2](i*T_val/frames)),       

     labels=["Время t", "u(t)"],          view=[0..T_val, uminus0

  3..2]      ),      i=1..frames  )]:  anim3 coloneq display

  (seq_plots3, insequence=true):      #

   =============================================================\

  ========  # ВЫВОД  #

   =============================================================\

  ========  print("Анимация 1: Фазовый портрет");  anim1;    

  print("Анимация 2: Графики x1 и x2 от времени");  anim2;    

  print("Анимация 3: Управление u(t)");  anim3;


                                

