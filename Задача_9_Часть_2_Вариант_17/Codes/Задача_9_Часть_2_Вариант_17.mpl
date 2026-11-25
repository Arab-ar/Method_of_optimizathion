
restart;  with(plots):  with(plottools):    #

   ============================================================  

  # Общие определения  #

   ============================================================  

  x_opt coloneq t srarr sqrt(2)*sin(Pi*t);  u_opt coloneq t srarr

   sqrt(2)*Pi*cos(Pi*t);    TITLE_FONT coloneq [TIMES, BOLD, 15]:

    LABEL_FONT coloneq [TIMES, BOLD, 13]:  TEXT_FONT  coloneq 

  [TIMES, BOLD, 12]:    #

   ============================================================  

  # 1. Оптимальная траектория и управление  #

   ============================================================  

  anim1 coloneq proc(tau)      local xc, uc, fillx, fillu, p1, p2

  , txt;      xc    coloneq plot(x_opt(t), t=0..1, color=blue, 

  thickness=4,                    legend="x(t)=sqrt(2) sin(pi t)"

  );      uc    coloneq plot(u_opt(t), t=0..1, color=red, 

  thickness=2,                    linestyle=dash, legend=

  "u(t)=sqrt(2) pi cos(pi t)");      fillx coloneq plot(x_opt(t),

   t=0..tau, color=blue, thickness=4,                    filled=

  true, transparency=0.85);      fillu coloneq plot(u_opt(t), t=0

  ..tau, color=red, thickness=2,                    linestyle=

  dash, filled=true, transparency=0.9);      p1    coloneq point

  ([tau, x_opt(tau)], color=blue, symbol=solidcircle, symbolsize=

  20);      p2    coloneq point([tau, u_opt(tau)], color=red,  

  symbol=solidcircle, symbolsize=20);      txt   coloneq textplot

  ([0.5, 3.8,          sprintf("t = %.3f   x = %.3f   u = %.3f", 

  tau, x_opt(tau), u_opt(tau))],          font=TEXT_FONT);      

  display(xc, uc, fillx, fillu, p1, p2, txt,              title=

  "Анимация 1: Оптимальные траектория и управление",             

   titlefont=TITLE_FONT, labels=["t","x, u"],              

  labelfont=LABEL_FONT, view=[0..1, uminus04.5..4.5], gridlines=

  true);  end proc:    #

   ============================================================  

  # 2. Вариация седловой точки n=2  #

   ============================================================  

  x_pert coloneq (t, eps) srarr sqrt(2 uminus0 eps^2)*sin(2*Pi*t)

   + eps*sin(Pi*t);  J_pert coloneq eps srarr Pi^2*(4 uminus0 1.5

  *eps^2);   # аналитически!    anim2 coloneq proc(eps)      

  local p, pt, txt;      p   coloneq plot(x_pert(t, eps), t=0..1,

   color=green, thickness=3,                  labels=["t","x(t)"]

  , labelfont=LABEL_FONT);      pt  coloneq point([0.5, x_pert(

  0.5, eps)],                   color=black, symbol=solidcircle, 

  symbolsize=16);      txt coloneq textplot([0.5, uminus02.3,    

        sprintf("eps = %.3f   J(eps) = %.3f   J_min = %.3f",     

               eps, J_pert(eps), evalf(Pi^2))],          font=

  TEXT_FONT);      display(p, pt, txt,              title=

  "Анимация 2: n=2 — седловая точка (J падает при eps != 0)",    

            titlefont=TITLE_FONT, view=[0..1, uminus02.6..2.6], 

  gridlines=true);  end proc:    #

   ============================================================  

  # 3. Накопление интеграла от (dx/dt)^2  #

   ============================================================  

  anim3 coloneq proc(tau)      local integrand, fill, pt, vline, 

  txt, val;      val coloneq Pi^2*tau;   #

   int_0^tau 2*pi^2*cos(pi*t)^2 dt = pi^2 * tau      integrand 

  coloneq plot(2*Pi^2*cos(Pi*t)^2, t=0..1, color=purple, 

  thickness=3,                        labels=["t","(dx/dt)^2"], 

  labelfont=LABEL_FONT);      fill coloneq plot(2*Pi^2*cos(Pi*t)^

  2, t=0..tau, color=purple, thickness=3,                   

  filled=true, transparency=0.3);      pt   coloneq point([tau, 2

  *Pi^2*cos(Pi*tau)^2],                    color=red, symbol=

  solidcircle, symbolsize=18);      vline coloneq plot([[tau,0],

  [tau,2*Pi^2*cos(Pi*tau)^2]],                    color=red, 

  linestyle=dash, thickness=2);      txt  coloneq textplot([0.5, 

  22,          sprintf(

  "tau = %.3f   J(tau) = %.3f   (J_max = pi^2 = %.2f)",          

          tau, val, evalf(Pi^2))],          font=TEXT_FONT);     

   display(integrand, fill, pt, vline, txt,              title=

  "Анимация 3: Накопление J = int (dx/dt)^2 dt",              

  titlefont=TITLE_FONT, view=[0..1, 0..24], gridlines=true);  end

   proc:    #

   ============================================================  

  # 4. Парабола J(A) с допустимой областью |A| >= sqrt(2)  #

   ============================================================  

  anim4 coloneq proc(A)      local parab, feas_p, feas_n, pt, 

  vline, txt, ok, Amax;      Amax coloneq 3;      parab  coloneq 

  plot(Pi^2*A0^2/2, A0=uminus0Amax..Amax, color=blue, thickness=4

  ,                     labels=["A","J(A)"], labelfont=LABEL_FONT

  );      feas_p coloneq plot(Pi^2*A0^2/2, A0=sqrt(2)..Amax,     

                  color=green, thickness=6, transparency=0.3);   

     feas_n coloneq plot(Pi^2*A0^2/2, A0=uminus0Amax..uminus0sqrt

  (2),                     color=green, thickness=6, transparency

  =0.3);      vline  coloneq plot([[A,0],[A, Pi^2*A^2/2]],       

                color=red, linestyle=dash, thickness=2);      pt 

      coloneq point([A, Pi^2*A^2/2],                      color=

  red, symbol=solidcircle, symbolsize=20);      ok coloneq `if`

  (evalf(abs(A)) GreaterEqual evalf(sqrt(2)), "ДА", "НЕТ");      

  txt coloneq textplot([0, 37,          sprintf(

  "A = %.3f   J = %.3f\n"                  

  "Допустимо (|A| >= sqrt(2)): %s   J_min = %.3f",               

     A, Pi^2*A^2/2, ok, evalf(Pi^2))],          font=TEXT_FONT); 

       display(parab, feas_p, feas_n, vline, pt, txt,            

    title=

  "Анимация 4: J(A). Зелёное = допустимая область |A| >= sqrt(2)"

  ,              titlefont=TITLE_FONT, view=[uminus0Amax..Amax, 0

  ..40], gridlines=true);  end proc:   #

   ============================================================  

  # 5. Две равноправные оптимальные пары (с закраской)  #

   ============================================================  

  anim5 coloneq proc(tau)      local p1, p2, u1, u2,            

  fx1, fx2, fu1, fu2,            pp1, pp2, pu1, pu2, txt;      #

   --- полные кривые ---      p1 coloneq plot( x_opt(t), t=0..1, 

  color=blue,   thickness=4, legend="x_+(t)");      p2 coloneq 

  plot(uminus0x_opt(t), t=0..1, color=red,    thickness=4, legend

  ="x_-(t)");      u1 coloneq plot( u_opt(t), t=0..1, color=green

  ,   thickness=3,                  linestyle=dash, legend=

  "u_+(t)");      u2 coloneq plot(uminus0u_opt(t), t=0..1, color=

  magenta, thickness=3,                  linestyle=dash, legend=

  "u_-(t)");      #

   --- закраска пройденной части (0..tau), цвета как у кривых ---

        fx1 coloneq plot( x_opt(t), t=0..tau, color=blue,    

  thickness=4,                   filled=true, transparency=0.80);

        fx2 coloneq plot(uminus0x_opt(t), t=0..tau, color=red,   

    thickness=4,                   filled=true, transparency=0.80

  );      fu1 coloneq plot( u_opt(t), t=0..tau, color=green,   

  thickness=3,                   linestyle=dash, filled=true, 

  transparency=0.85);      fu2 coloneq plot(uminus0u_opt(t), t=0

  ..tau, color=magenta, thickness=3,                   linestyle=

  dash, filled=true, transparency=0.85);      #

   --- маркеры-точки ---      pp1 coloneq point([tau,  x_opt(tau)

  ], color=blue,    symbol=solidcircle, symbolsize=18);      pp2 

  coloneq point([tau, uminus0x_opt(tau)], color=red,     symbol=

  solidcircle, symbolsize=18);      pu1 coloneq point([tau,  

  u_opt(tau)], color=green,   symbol=solidcircle, symbolsize=14);

        pu2 coloneq point([tau, uminus0u_opt(tau)], color=magenta

  , symbol=solidcircle, symbolsize=14);      # --- подпись ---   

     txt coloneq textplot([0.5, 4.3,          sprintf(

  "t=%.2f   |x|=%.3f   J[x_+]=J[x_-]=pi^2=%.2f",                 

   tau, abs(x_opt(tau)), evalf(Pi^2))],          font=TEXT_FONT);

        display(p1, p2, u1, u2,              fx1, fx2, fu1, fu2, 

               pp1, pp2, pu1, pu2, txt,              title=

  "Анимация 5: Две симметричные оптимальные пары",              

  titlefont=TITLE_FONT, labels=["t","x, u"],              

  labelfont=LABEL_FONT, view=[0..1, uminus05..5], gridlines=true)

  ;  end proc:   #

   ============================================================  

  # 6. Семейство экстремалей x_n = sqrt(2) sin(n pi t)  #

   ============================================================  

  anim6 coloneq proc(nn)      local curves, pt, txt, k, n;      n

   coloneq round(nn);      curves coloneq [seq(plot(sqrt(2)*sin(k

  *Pi*t), t=0..1,                          color     = `if`(k=n, 

  blue, gray),                          thickness = `if`(k=n, 5, 

  2),                          legend    = sprintf(

  "n=%d: J=%d pi^2", k, k^2)), k=1..5)];      pt  coloneq point

  ([0.5, sqrt(2)*sin(n*Pi*0.5)],                   color=red, 

  symbol=solidcircle, symbolsize=20);      txt coloneq textplot

  ([0.5, 2.3,          sprintf(

  "n = %d   x_n(t) = sqrt(2) sin(%d pi t)   J_n = %d pi^2 = %.2f"

  ,                  n, n, n^2, evalf(n^2*Pi^2))],          font=

  TEXT_FONT);      display(op(curves), pt, txt,              

  title="Анимация 6: Семейство экстремалей. Минимум — при n=1",  

              titlefont=TITLE_FONT, labels=["t","x_n(t)"],       

         labelfont=LABEL_FONT, view=[0..1, uminus02.6..2.6], 

  gridlines=true);  end proc:   #

   ============================================================  

  # ЗАПУСК ВСЕХ 6 АНИМАЦИЙ  #

   ============================================================  

    plots:-animate(anim1, [tau], tau=0..1,     frames=120, 

  background=white);  plots:-animate(anim2, [eps], eps=uminus00.8

  ..0.8, frames=120, background=white);  plots:-animate(anim3, 

  [tau], tau=0..1,     frames=120, background=white);  plots:-

  animate(anim4, [A],   A=uminus02.5..2.5,  frames=120, 

  background=white);  plots:-animate(anim5, [tau], tau=0..1,     

  frames=120, background=white); plots:-animate(anim6, [m], m=1..

  5, frames=100, background=white);


                                

