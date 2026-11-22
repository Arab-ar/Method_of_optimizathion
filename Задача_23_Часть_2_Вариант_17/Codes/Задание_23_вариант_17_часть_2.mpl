
restart;  with(plots):  with(plottools):    #

   =========================================================  #

   1. ВЫЧИСЛЕНИЕ КОНСТАНТЫ КЛЕРО (c)  #

   =========================================================  

  eq_c coloneq int(c*sqrt(1+4*r^2)/(r*sqrt(r^2uminus0c^2)), r=1..

  3) = Pi/2:  c_opt coloneq fsolve(eq_c, c=0..1);    #

   =========================================================  #

   2. ВЫЧИСЛЕНИЕ ДЛИНЫ ГЕОДЕЗИЧЕСКОЙ (S_max)  #

   =========================================================  

  S_max coloneq evalf(int(r*sqrt(1+4*r^2)/sqrt(r^2uminus0c_opt^2)

  , r=1..3));  S_euclid coloneq evalf(sqrt(74));    #

   =========================================================  #

   3. РЕШЕНИЕ ОДУ (Натуральная параметризация)  #

   =========================================================  sys

   coloneq {      diff(r(s), s) = sqrt(r(s)^2 uminus0 c_opt^2) / 

  (r(s) * sqrt(1 + 4*r(s)^2)),      diff(phi(s), s) = c_opt / r(s

  )^2,      r(0) = 1,       phi(0) = 0  }:  sol coloneq dsolve(

  sys, numeric, [r(s), phi(s)]):    #

   Функция для получения 3D-координат (x, y, z) точки на 

   геодезической  Geo_pt coloneq proc(s_val)       local res, 

  r_val, phi_val;      res coloneq sol(s_val);      r_val coloneq

   eval(r(s), res);      phi_val coloneq eval(phi(s), res);      

  return [r_val*cos(phi_val), r_val*sin(phi_val), r_val^2];  end 

  proc:    #

   Предвычисление точек для идеально плавной отрисовки линии  

  N_curve coloneq 200:  s_vals coloneq [seq(i*S_max/N_curve, i=0

  ..N_curve)]:  pts_geo coloneq [seq(Geo_pt(sv), sv in s_vals)]: 

     # ========================================================= 

   # 4. ПОСТРОЕНИЕ ГЕОМЕТРИЧЕСКИХ ОБЪЕКТОВ  #

   =========================================================  #

   Поверхность  Surf coloneq plot3d([r*cos(theta), r*sin(theta), 

  r^2], r=0..3.5, theta=0..2*Pi,       style=surface, color=

  "LightBlue", transparency=0.4, grid=[50,50],       axes=boxed, 

  labels=["x","y","z"]):    #

   Геодезическая линия (оранжевая) - без legend  Geo coloneq 

  spacecurve(pts_geo, color=orange, thickness=4):    #

   Евклидова прямая (пунктирная синяя) - без legend  Seg coloneq 

  line([1,0,1], [0,3,9], color=blue, thickness=3, linestyle=dash)

  :    # Точки A и B  PtA coloneq sphere([1,0,1], 0.15, color=red

  ):  PtB coloneq sphere([0,3,9], 0.15, color=green):  TextA 

  coloneq textplot3d([1, 0, 1.3, "A(1,0,1)"], color=red, font=

  [TIMES, BOLD, 16]):  TextB coloneq textplot3d([0, 3, 9.5, 

  "B(0,3,9)"], color=green, font=[TIMES, BOLD, 16]):    #

   Подписи к линиям (вместо legend)  #

   Берем точку на середине геодезической для подписи  mid_pt 

  coloneq Geo_pt(S_max/2):  Text_Geo coloneq textplot3d([mid_pt[1

  ], mid_pt[2], mid_pt[3]uminus01.5, "Геодезическая (S≈8.78)"],  

       color=orange, font=[TIMES, BOLD, 14], align={ABOVE, LEFT})

  :    # Подпись для прямой (середина между A и B)  Text_Seg 

  coloneq textplot3d([0.5, 1.5, 5, "Евклидова прямая (√74≈8.60)"]

  ,       color=blue, font=[TIMES, BOLD, 14], align={ABOVE, RIGHT

  }):    #

   =========================================================  #

   5. СОЗДАНИЕ АНИМАЦИИ  #

   =========================================================  N 

  coloneq 120: # Количество кадров анимации  frames coloneq [seq(

        display(Surf, Seg, Geo, PtA, PtB, TextA, TextB, Text_Geo,

   Text_Seg,          # Анимированная черная точка          

  pointplot3d(Geo_pt(si), symbol=solidsphere, symbolsize=25, 

  color=black),          title=cat(

  "Геодезическая на z=x^2+y^2. Пройдено дуги: s = ", evalf[4](si)

  , " из ", evalf[4](S_max)),          view=[uminus01..3.5, 

  uminus01..3.5, 0..10],           scaling=constrained,          

   orientation=[50, 70, 10] # Угол обзора      ),      si = 0 .. 

  S_max, S_max/(Numinus01)  )]:    # Воспроизведение анимации  

  display(frames, insequence = true);


                                

