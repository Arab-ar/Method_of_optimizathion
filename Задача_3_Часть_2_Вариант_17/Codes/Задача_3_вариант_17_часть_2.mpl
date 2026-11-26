restart;
with(plots):
with(plottools):

# ============================================
# АНИМАЦИЯ 1: Множество M
# ============================================

# M в области x1<=0, x2<=0 - закрашиваем полигон
M_region := polygonplot([[-2, 0], [0, 0], [0, -2], [-2, -2]], 
                        color = COLOR(RGB, 0.7, 0.85, 1.0), 
                        transparency = 0.3):

g1_line := plot([0, t, t = -2..1.5], color = red, thickness = 2):
g2_line := plot([t, 0, t = -2..1.5], color = blue, thickness = 2):
g3_curve := implicitplot(x1^3 + x2^3 = 1, x1 = -1.5..1.5, x2 = -1.5..1.5, 
                          color = green, thickness = 2, linestyle = dash):

origin_point := pointplot([0, 0], symbol = solidcircle, symbolsize = 20, color = black):

labels1 := textplot([[0.15, -0.15, "(0,0)"], [0.3, 0.5, "g1: x1=0"], 
                     [0.5, 0.1, "g2: x2=0"], [1.2, 0.8, "g3: x1^3+x2^3=1"]]):

display(M_region, g1_line, g2_line, g3_curve, origin_point, labels1,
        title = "Множество M (синяя область)",
        labels = ["x1", "x2"],
        scaling = constrained,
        view = [-2..1.5, -2..1.5]);

# ============================================
# АНИМАЦИЯ 2: Кривые alpha(t) внутри M
# ============================================

frames2 := [seq(
    display(
        M_region, g1_line, g2_line, origin_point,
        plot([t*(-1), t*0, t = 0..i/20], color = red, thickness = 3),
        plot([t*0, t*(-1), t = 0..i/20], color = red, thickness = 3),
        plot([t*(-0.7), t*(-0.7), t = 0..i/20], color = red, thickness = 3),
        textplot([[0.15, -0.15, "(0,0)"]]),
        title = sprintf("Кривые alpha(t) внутри M, t = %.2f", i/20),
        scaling = constrained,
        view = [-2..1.5, -2..1.5]
    ),
    i = 1..20
)]:

display(frames2, insequence = true);

# ============================================
# АНИМАЦИЯ 3: Касательный конус K_M(0,0)
# ============================================

cone_region := polygonplot([[-2, 0], [0, 0], [0, -2], [-2, -2]], 
                           color = COLOR(RGB, 1.0, 0.85, 0.3), 
                           transparency = 0.3):

cone_arrows := display(seq(
    arrow([0, 0], [-1.5*cos(Pi + i*Pi/8), -1.5*sin(Pi + i*Pi/8)], 
          0.05, 0.1, 0.1, color = darkblue, thickness = 2),
    i = 0..4
)):

labels3 := textplot([[0.15, -0.15, "(0,0)"], [-1.2, -1.2, "K_M(0,0)"], 
                     [0.3, 0.5, "g1: x1=0"], [0.5, 0.1, "g2: x2=0"]]):

display(cone_region, g1_line, g2_line, origin_point, cone_arrows, labels3,
        title = "Касательный конус K_M(0,0) (жёлтый)",
        labels = ["x1", "x2"],
        scaling = constrained,
        view = [-2..1.5, -2..1.5]);

# ============================================
# АНИМАЦИЯ 4: Касательное пространство T_(0,0)M = R^2
# ============================================

full_plane := polygonplot([[-2, -2], [1.5, -2], [1.5, 1.5], [-2, 1.5]], 
                          color = COLOR(RGB, 0.85, 1.0, 0.85), 
                          transparency = 0.3):

space_arrows := display(
    arrow([0, 0], [-1.5, 0], 0.05, 0.1, 0.1, color = red, thickness = 3),
    arrow([0, 0], [0, -1.5], 0.05, 0.1, 0.1, color = red, thickness = 3),
    arrow([0, 0], [1.5, 0], 0.05, 0.1, 0.1, color = darkgreen, thickness = 3),
    arrow([0, 0], [0, 1.5], 0.05, 0.1, 0.1, color = darkgreen, thickness = 3),
    arrow([0, 0], [1.2, 1.2], 0.05, 0.1, 0.1, color = darkgreen, thickness = 2),
    arrow([0, 0], [-1.2, 1.2], 0.05, 0.1, 0.1, color = darkgreen, thickness = 2),
    arrow([0, 0], [1.2, -1.2], 0.05, 0.1, 0.1, color = darkgreen, thickness = 2),
    arrow([0, 0], [-1.2, -1.2], 0.05, 0.1, 0.1, color = darkgreen, thickness = 2)
):

labels4 := textplot([[0.15, -0.15, "(0,0)"], [1.0, 1.0, "T_(0,0)M = R^2"], 
                     [-1.7, -0.2, "u1=(-1,0)"], [-0.2, -1.7, "u2=(0,-1)"], 
                     [1.3, 0.1, "span{u1,u2}=R^2"]]):

display(full_plane, g1_line, g2_line, origin_point, space_arrows, labels4,
        title = "Касательное пространство T_(0,0)M = R^2 (зелёная плоскость)",
        labels = ["x1", "x2"],
        scaling = constrained,
        view = [-2..1.5, -2..1.5]);

# ============================================
# АНИМАЦИЯ 5: Комбинированная визуализация
# ============================================

combined := display(
    M_region, cone_region, full_plane,
    g1_line, g2_line, g3_curve,
    origin_point, space_arrows,
    textplot([[0.15, -0.15, "(0,0)"], [-1.3, -1.3, "M"], 
              [-0.8, -0.8, "K_M"], [1.0, 1.0, "T_(0,0)M=R^2"]]),
    title = "Полная картина: M ⊃ K_M(0,0), span(K_M) = R^2",
    labels = ["x1", "x2"],
    scaling = constrained,
    view = [-2..1.5, -2..1.5]
):

display(combined);

# ============================================
# АНИМАЦИЯ 6: Динамическое построение линейной оболочки
# ============================================

frames6 := [seq(
    display(
        cone_region, g1_line, g2_line, origin_point,
        arrow([0, 0], [-1.5, 0], 0.05, 0.1, 0.1, color = red, thickness = 3),
        arrow([0, 0], [0, -1.5], 0.05, 0.1, 0.1, color = red, thickness = 3),
        seq(
            arrow([0, 0], [1.5*i/10*cos(j*Pi/5), 1.5*i/10*sin(j*Pi/5)], 
                  0.04, 0.08, 0.06, color = darkgreen, thickness = 2),
            j = 0..9
        ),
        textplot([[0.15, -0.15, "(0,0)"], [-1.7, -0.2, "u1"], 
                  [-0.2, -1.7, "u2"], [1.0, 1.0, sprintf("span: %d%%", i*10)]]),
        title = sprintf("Линейная оболочка: %d%%", i*10),
        scaling = constrained,
        view = [-2..1.5, -2..1.5]
    ),
    i = 1..10
)]:

display(frames6, insequence = true);

print("Все анимации готовы!");
