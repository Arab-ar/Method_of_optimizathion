restart;
with(plots):
with(plottools):

# =========================================================
# 1. ВЫЧИСЛЕНИЕ КОНСТАНТЫ КЛЕРО (c)
# =========================================================
eq_c := int(c*sqrt(1+4*r^2)/(r*sqrt(r^2-c^2)), r=1..3) = Pi/2:
c_opt := fsolve(eq_c, c=0..1);

# =========================================================
# 2. ВЫЧИСЛЕНИЕ ДЛИНЫ ГЕОДЕЗИЧЕСКОЙ (S_max)
# =========================================================
S_max := evalf(int(r*sqrt(1+4*r^2)/sqrt(r^2-c_opt^2), r=1..3));
S_euclid := evalf(sqrt(74));

# =========================================================
# 3. РЕШЕНИЕ ОДУ (Натуральная параметризация)
# =========================================================
sys := {
    diff(r(s), s) = sqrt(r(s)^2 - c_opt^2) / (r(s) * sqrt(1 + 4*r(s)^2)),
    diff(phi(s), s) = c_opt / r(s)^2,
    r(0) = 1, 
    phi(0) = 0
}:
sol := dsolve(sys, numeric, [r(s), phi(s)]):

# Функция для получения 3D-координат (x, y, z) точки на геодезической
Geo_pt := proc(s_val) 
    local res, r_val, phi_val;
    res := sol(s_val);
    r_val := eval(r(s), res);
    phi_val := eval(phi(s), res);
    return [r_val*cos(phi_val), r_val*sin(phi_val), r_val^2];
end proc:

# Предвычисление точек для идеально плавной отрисовки линии
N_curve := 200:
s_vals := [seq(i*S_max/N_curve, i=0..N_curve)]:
pts_geo := [seq(Geo_pt(sv), sv in s_vals)]:

# =========================================================
# 4. ПОСТРОЕНИЕ ГЕОМЕТРИЧЕСКИХ ОБЪЕКТОВ
# =========================================================
# Поверхность
Surf := plot3d([r*cos(theta), r*sin(theta), r^2], r=0..3.5, theta=0..2*Pi, 
    style=surface, color="LightBlue", transparency=0.4, grid=[50,50], 
    axes=boxed, labels=["x","y","z"]):

# Геодезическая линия (оранжевая)
Geo := spacecurve(pts_geo, color=orange, thickness=4):

# Евклидова прямая (пунктирная синяя)
Seg := line([1,0,1], [0,3,9], color=blue, thickness=3, linestyle=dash):

# Точки A и B
PtA := sphere([1,0,1], 0.15, color=red):
PtB := sphere([0,3,9], 0.15, color=green):
TextA := textplot3d([1, 0, 1.3, "A(1,0,1)"], color=red, font=[TIMES, BOLD, 16]):
TextB := textplot3d([0, 3, 9.5, "B(0,3,9)"], color=green, font=[TIMES, BOLD, 16]):

# Подписи к линиям (вместо legend)
mid_pt := Geo_pt(S_max/2):
Text_Geo := textplot3d([mid_pt[1], mid_pt[2], mid_pt[3]-1.5, "Геодезическая (S≈8.78)"], 
    color=orange, font=[TIMES, BOLD, 14], align={ABOVE, LEFT}):

Text_Seg := textplot3d([0.5, 1.5, 5, "Евклидова прямая (√74≈8.60)"], 
    color=blue, font=[TIMES, BOLD, 14], align={ABOVE, RIGHT}):

# =========================================================
# 5. СОЗДАНИЕ АНИМАЦИИ
# =========================================================
N := 120: # Количество кадров анимации
frames := [seq(
    display(Surf, Seg, Geo, PtA, PtB, TextA, TextB, Text_Geo, Text_Seg,
        # Анимированная черная точка
        pointplot3d(Geo_pt(si), symbol=solidsphere, symbolsize=25, color=black),
        title=cat("Геодезическая на z=x^2+y^2. Пройдено дуги: s = ", evalf[4](si), " из ", evalf[4](S_max)),
        view=[-1..3.5, -1..3.5, 0..10], 
        scaling=constrained, 
        orientation=[50, 70, 10] # Угол обзора
    ),
    si = 0 .. S_max, S_max/(N-1)
)]:

# Воспроизведение анимации
display(frames, insequence = true);
