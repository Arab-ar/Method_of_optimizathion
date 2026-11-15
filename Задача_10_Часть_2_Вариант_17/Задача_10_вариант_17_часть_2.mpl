
with(plots):    # --- Определение функций ---  x_opt coloneq t 

  srarr (2/(Pi*(3+Pi^2))) * ( uminus02*(2+Pi^2)*sin(t) + t*( (4+

  Pi^2)*cos(t) + Pi*sin(t) ) );  u_opt coloneq t srarr (2/(Pi*(3+

  Pi^2))) * ( uminus0Pi^2*cos(t) + Pi*sin(t) + t*( Pi*cos(t) 

  uminus0 (4+Pi^2)*sin(t) ) );  u_prime coloneq t srarr uminus0

  x_opt(t) + (4/(Pi^2+3))*cos(t) uminus0 (4*(Pi^2+4)/(Pi*(Pi^2+3)

  ))*sin(t);    # --- 1. Траектория ---  p1 coloneq plot(x_opt(t)

  , t = 0..Pi, color = blue, thickness = 3, title = 

  "1. Оптимальная траектория x(t)", labels = ["t", "x"], 

  gridlines):  frames1 coloneq seq(display([p1, pointplot([[t, 

  x_opt(t)]], symbol = solidcircle, symbolsize = 12, color = red)

  , plot([[t, 0], [t, x_opt(t)]], color = gray, linestyle = dash)

  ]), t = 0..evalf(Pi), 0.05):  anim1 coloneq display(frames1, 

  insequence = true, scaling = constrained):    #

   --- 2. Управление ---  p2 coloneq plot(u_opt(t), t = 0..Pi, 

  color = red, thickness = 3, title = 

  "2. Оптимальное управление u(t)", labels = ["t", "u"], 

  gridlines):  frames2 coloneq seq(display([p2, pointplot([[t, 

  u_opt(t)]], symbol = solidcircle, symbolsize = 12, color = blue

  ), plot([[t, 0], [t, u_opt(t)]], color = gray, linestyle = dash

  )]), t = 0..evalf(Pi), 0.05):  anim2 coloneq display(frames2, 

  insequence = true, scaling = constrained):    #

   --- 3. Фазовый портрет ---  p3 coloneq plot([x_opt(t), u_opt(t

  ), t = 0..Pi], color = green, thickness = 2, title = 

  "3. Фазовый портрет (x, u)", labels = ["x", "u"], gridlines):  

  frames3 coloneq seq(display([p3, pointplot([[x_opt(t), u_opt(t)

  ]], symbol = solidcircle, symbolsize = 12, color = red), plots

  :-arrow([x_opt(t), u_opt(t)], [x_opt(t) + 0.3*u_opt(t), u_opt(t

  ) + 0.3*u_prime(t)], color = black, thickness = 2)]), t = 0..

  evalf(Pi), 0.05):  anim3 coloneq display(frames3, insequence = 

  true, scaling = constrained):    #

   --- 4. Подынтегральная функция L(t) ---  L_func coloneq t 

  srarr u_opt(t)^2 uminus0 x_opt(t)^2:  p4 coloneq plot(L_func(t)

  , t = 0..Pi, color = purple, thickness = 3, title = 

  "4. Функция L(t) = x'^2 - x^2", labels = ["t", "L"], gridlines)

  :  frames4 coloneq seq(display([p4, plot(L_func(s), s = 0..t, 

  filled = true, color = yellow, transparency = 0.5), pointplot([

  [t, L_func(t)]], symbol = solidcircle, symbolsize = 12, color =

   orange)]), t = 0..evalf(Pi), 0.05):  anim4 coloneq display

  (frames4, insequence = true, scaling = constrained):    #

   --- ВЫВОД ---  "Анимация 1: Траектория";  anim1;  

  "Анимация 2: Управление";  anim2;  

  "Анимация 3: Фазовый портрет";  anim3;  

  "Анимация 4: Накопление площади";  anim4;


                                

