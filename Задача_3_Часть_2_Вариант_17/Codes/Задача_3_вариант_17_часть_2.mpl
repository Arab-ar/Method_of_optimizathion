
restart;  with(plots):  with(plottools):    M_plot coloneq 

  inequal({x1 leq 0, x2 leq 0}, x1 = uminus03 .. 1, x2 = uminus03

   .. 1,      optionsfeasible = [color = "LightBlue", 

  transparency = 0.6],      optionsclosed = [color = black, 

  thickness = 2],      optionsexcluded = [color = "white"]):    

  Point_O coloneq pointplot([0, 0], symbol = solidcircle, 

  symbolsize = 15, color = black):  Grad_1 coloneq plots:-arrow([

  0, 0], [1.5, 0], color = red, thickness = 3, head_length = 0.15

  ):  Grad_2 coloneq plots:-arrow([0, 0], [0, 1.5], color = red, 

  thickness = 3, head_length = 0.15):  Text_G1 coloneq textplot

  ([1.6, 0.1, "&nabla;g1"], font = [TIMES, BOLD, 14], color = red

  ):  Text_G2 coloneq textplot([0.1, 1.6, "&nabla;g2"], font = 

  [TIMES, BOLD, 14], color = red):  Curve_1 coloneq plot([uminus0

  t, uminus0t^2, t = 0 .. 1], color = green, thickness = 2):  

  Curve_2 coloneq plot([uminus0t^2, uminus0t, t = 0 .. 1], color 

  = purple, thickness = 2):  Curve_3 coloneq plot([uminus0t, 

  uminus0t, t = 0 .. 1], color = orange, thickness = 2):  Vec_1 

  coloneq plots:-arrow([0, 0], [uminus02, 0], color = green, 

  thickness = 3, head_length = 0.15):  Vec_2 coloneq plots:-arrow

  ([0, 0], [0, uminus02], color = purple, thickness = 3, 

  head_length = 0.15):  Vec_3 coloneq plots:-arrow([0, 0], 

  [uminus02, uminus02], color = orange, thickness = 3, 

  head_length = 0.15):  Anim_Pt1 coloneq animate(pointplot, 

  [[uminus0t, uminus0t^2]], t = 1 .. 0, frames = 40, symbol = 

  solidcircle, symbolsize = 10, color = green):  Anim_Pt2 coloneq

   animate(pointplot, [[uminus0t^2, uminus0t]], t = 1 .. 0, 

  frames = 40, symbol = solidcircle, symbolsize = 10, color = 

  purple):  Anim_Pt3 coloneq animate(pointplot, [[uminus0t, 

  uminus0t]], t = 1 .. 0, frames = 40, symbol = solidcircle, 

  symbolsize = 10, color = orange):    Anim_Cone coloneq animate(

        plots:-arrow,      [[0, 0], [2.5*cos(theta), 2.5*sin(

  theta)],       color = blue, thickness = 4, head_length = 0.15]

  ,      theta = Pi .. (3*Pi)/2,      frames = 60  ):    display

  (M_plot, Point_O, Grad_1, Grad_2, Text_G1, Text_G2,      

  Curve_1, Curve_2, Curve_3, Vec_1, Vec_2, Vec_3,      Anim_Pt1, 

  Anim_Pt2, Anim_Pt3, Anim_Cone,      title = 

  "Касательное пространство T(0,0)M",      titlefont = [TIMES, 

  BOLD, 16],      axes = boxed, labels = ["x1", "x2"],      view 

  = [uminus03.5 .. 2, uminus03.5 .. 2], scaling = constrained);


                                

