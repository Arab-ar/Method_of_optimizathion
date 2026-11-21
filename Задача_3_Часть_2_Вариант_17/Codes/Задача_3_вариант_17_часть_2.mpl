restart;
with(plots):
with(plottools):

# 1. Допустимое множество M
M_plot := inequal({x1 <= 0, x2 <= 0}, x1 = -3 .. 1, x2 = -3 .. 1, 
    optionsfeasible = [color = "LightBlue", transparency = 0.6], 
    optionsclosed = [color = black, thickness = 2], 
    optionsexcluded = [color = "white"]):

Point_O := pointplot([0, 0], symbol = solidcircle, symbolsize = 15, color = black):

# 2. Градиенты
Grad_1 := plots:-arrow([0, 0], [1.5, 0], color = red, thickness = 3, head_length = 0.15):
Grad_2 := plots:-arrow([0, 0], [0, 1.5], color = red, thickness = 3, head_length = 0.15):
Text_G1 := textplot([1.6, 0.1, "∇g1"], font = [TIMES, BOLD, 14], color = red):
Text_G2 := textplot([0.1, 1.6, "∇g2"], font = [TIMES, BOLD, 14], color = red):

# 3. Кривые
Curve_1 := plot([-t, -t^2, t = 0 .. 1], color = green, thickness = 2):
Curve_2 := plot([-t^2, -t, t = 0 .. 1], color = purple, thickness = 2):
Curve_3 := plot([-t, -t, t = 0 .. 1], color = orange, thickness = 2):

# 4. Векторы направлений
Vec_1 := plots:-arrow([0, 0], [-2, 0], color = green, thickness = 3, head_length = 0.15):
Vec_2 := plots:-arrow([0, 0], [0, -2], color = purple, thickness = 3, head_length = 0.15):
Vec_3 := plots:-arrow([0, 0], [-2, -2], color = orange, thickness = 3, head_length = 0.15):

# 5. Анимация точек
Anim_Pt1 := animate(pointplot, [[-t, -t^2]], t = 1 .. 0, frames = 40, symbol = solidcircle, symbolsize = 10, color = green):
Anim_Pt2 := animate(pointplot, [[-t^2, -t]], t = 1 .. 0, frames = 40, symbol = solidcircle, symbolsize = 10, color = purple):
Anim_Pt3 := animate(pointplot, [[-t, -t]], t = 1 .. 0, frames = 40, symbol = solidcircle, symbolsize = 10, color = orange):

# 6. Анимация касательного конуса (ИСПРАВЛЕН синтаксис, чтобы не было ошибки)
Anim_Cone := animate(
    plots:-arrow, 
    [[0, 0], [2.5*cos(theta), 2.5*sin(theta)], color = blue, thickness = 4, head_length = 0.15], 
    theta = Pi .. (3*Pi)/2, 
    frames = 60
):

# 7. Сборка графика
display(
    M_plot, Point_O, Grad_1, Grad_2, Text_G1, Text_G2, 
    Curve_1, Curve_2, Curve_3, Vec_1, Vec_2, Vec_3, 
    Anim_Pt1, Anim_Pt2, Anim_Pt3, Anim_Cone,
    title = "Касательное пространство T(0,0)M", 
    titlefont = [TIMES, BOLD, 16], 
    axes = boxed, labels = ["x1", "x2"], 
    view = [-3.5 .. 2, -3.5 .. 2], 
    scaling = constrained
);
