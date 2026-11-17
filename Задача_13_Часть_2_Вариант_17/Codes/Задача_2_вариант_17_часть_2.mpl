restart;
with(plots):
Digits := 15:

# ============================================================
# 1. НАСТРОЙКА ПУТИ (АВТОМАТИЧЕСКИ НА РАБОЧИЙ СТОЛ)
# ============================================================
# kernelopts(homedir) автоматически находит C:\Users\ВашеИмя
output_dir := cat(kernelopts(homedir), "/Desktop/MaplePlots/"):

# Создаем папку на рабочем столе
try
    FileTools:-MakeDirectory(output_dir, recurse = true):
catch:
end try:

printf("Путь для сохранения: %s\n", output_dir);
printf("(Папка MaplePlots создана на вашем Рабочем столе)\n\n");

make_path := (anim_name, frame_idx) -> cat(output_dir, anim_name, "_", sprintf("%02d", frame_idx), ".png"):

printf("=== НАЧАЛО ГЕНЕРАЦИИ 320 КАДРОВ ===\n\n");

# ============================================================
# ПУНКТ 1
# ============================================================
f1 := x -> abs(x):

# --- АНИМАЦИЯ 1 ---
printf("Генерация anim1 (40 кадров)...\n");
for i from 0 to 39 do
    lam := -3.0 + i*6.0/39:
    if abs(lam) < 1e-12 then
        slope := 1:
        p := display(
            plot(f1(x), x = -0.5 .. 2.5, color = blue, thickness = 4, legend = "f(x) = |x|"),
            plot(1 + slope*(x - 1), x = -0.5 .. 2.5, color = red, linestyle = dash, thickness = 3, legend = "tangent"),
            pointplot([[1, 1]], symbol = solidcircle, symbolsize = 22, color = black),
            textplot([[1.5, 2.5, "slope = 1.000"]], font = [TIMES, BOLD, 14], color = red),
            title = cat("Point 1, x0=1, lambda = ", evalf[3](lam)),
            view = [-0.5 .. 2.5, -0.5 .. 3.0], labels = ["x", "y"]
        ):
    else
        slope := (abs(1+lam)-1)/lam:
        p := display(
            plot(f1(x), x = -0.5 .. 2.5, color = blue, thickness = 4, legend = "f(x) = |x|"),
            plot(1 + slope*(x - 1), x = -0.5 .. 2.5, color = red, linestyle = dash, thickness = 3, legend = "secant"),
            pointplot([[1, 1]], symbol = solidcircle, symbolsize = 22, color = black),
            textplot([[1.5, 2.5, cat("slope = ", evalf[3](slope))]], font = [TIMES, BOLD, 14], color = red),
            title = cat("Point 1, x0=1, lambda = ", evalf[3](lam)),
            view = [-0.5 .. 2.5, -0.5 .. 3.0], labels = ["x", "y"]
        ):
    end if:
    try Export(make_path("anim1", i), p);
    catch:
        printf("  Ошибка при сохранении anim1_%02d.png\n", i);
    end try;
end do:

# --- АНИМАЦИЯ 2 ---
printf("Генерация anim2 (40 кадров)...\n");
for i from 0 to 39 do
    lam := -1.5 + i*3.0/39:
    if abs(lam) < 1e-12 then
        slope := 0:
    else
        slope := abs(lam)/lam:
    end if:
    p := display(
        plot(f1(x), x = -2 .. 2, color = blue, thickness = 4, legend = "f(x) = |x|"),
        plot(slope*x, x = -2 .. 2, color = red, linestyle = dash, thickness = 3, legend = "secant"),
        pointplot([[0, 0]], symbol = solidcircle, symbolsize = 18, color = black),
        title = cat("Point 1, x0=0, lambda = ", evalf[3](lam)),
        view = [-2 .. 2, -2.0 .. 2.5], labels = ["x", "y"]
    ):
    try Export(make_path("anim2", i), p); catch: end try;
end do:

# --- АНИМАЦИЯ 3 ---
printf("Генерация anim3 (40 кадров)...\n");
for i from 0 to 39 do
    lam := -1.0 + i*2.0/39:
    if abs(lam) < 1e-12 then
        phi0 := 0: phi1 := 1:
    else
        phi0 := abs(lam)/lam: phi1 := 1:
    end if:
    p := display(
        plot(abs(t)/t, t = -1 .. 1, discont = true, color = red, thickness = 4, legend = "x0=0: phi=sgn(lambda)"),
        plot(1, t = -1 .. 1, color = green, thickness = 4, legend = "x0=1: phi=1"),
        pointplot([[lam, phi0], [lam, phi1]], symbol = solidcircle, symbolsize = 18, color = [red, green]),
        title = cat("phi(lambda), current lambda = ", evalf[3](lam)),
        view = [-1 .. 1, -1.6 .. 1.6], labels = ["lambda", "phi"]
    ):
    try Export(make_path("anim3", i), p); catch: end try;
end do:

# --- АНИМАЦИЯ 4 ---
printf("Генерация anim4 (40 кадров)...\n");
for i from 0 to 39 do
    x_test := -2.0 + i*4.0/39:
    p := display(
        plot(signum(x), x = -2 .. 2, discont = true, color = green, thickness = 4, legend = "sgn(x) - matrix entry (3,1)"),
        plot([x_test, x_test], -1.6 .. 1.6, color = red, linestyle = dot, thickness = 2),
        pointplot([[x_test, signum(x_test)]], symbol = solidcircle, symbolsize = 20, color = blue),
        title = cat("Point 1, condition (3): check x = ", evalf[3](x_test)),
        view = [-2 .. 2, -1.6 .. 1.6], labels = ["x", "sgn(x)"]
    ):
    try Export(make_path("anim4", i), p); catch: end try;
end do:


# ============================================================
# ПУНКТ 2
# ============================================================
xf := t -> t^2:
hf := t -> sin(Pi*t):
xdd := t -> 2:
hdd := t -> -Pi^2*sin(Pi*t):

G_fn := t -> xdd(t)^2 - cos(xf(t)):
Psi_fn := t -> 2*xdd(t)*hdd(t) + hf(t)*sin(xf(t)):

PsiL := (t, lam) -> 2*xdd(t)*hdd(t) + lam*hdd(t)^2 + cos(xf(t))*(1 - cos(lam*hf(t)))/lam + sin(xf(t))*sin(lam*hf(t))/lam:

gL := (t, lam) -> (xdd(t) + lam*hdd(t))^2 - cos(xf(t) + lam*hf(t)):
Fq := (t, lam) -> (gL(t, lam)^2 - G_fn(t)^2)/lam:
dF := t -> 2*G_fn(t)*Psi_fn(t):
tgrid := [seq(0.0 .. 1.0, 0.01)]:

# --- АНИМАЦИЯ 5 ---
printf("Генерация anim5 (40 кадров)...\n");
for i from 0 to 39 do
    lam := 0.5 - i*0.49/39:
    p := display(
        plot(Psi_fn(t), t = 0 .. 1, color = black, thickness = 5, legend = "Psi(t) - limit"),
        plot(PsiL(t, lam), t = 0 .. 1, color = red, linestyle = dash, thickness = 2, legend = "Psi_lambda(t)"),
        title = cat("Point 2, step 6: lambda = ", evalf[3](lam)),
        view = [0 .. 1, -25 .. 5], labels = ["t", "Psi"]
    ):
    try Export(make_path("anim5", i), p); catch: end try;
end do:

# --- АНИМАЦИЯ 6 ---
printf("Генерация anim6 (40 кадров)...\n");
lams6 := [seq(0.5 - i*0.49/39, i = 0 .. 39)]:
err_vals := [seq(max(seq(abs(PsiL(tt, l) - Psi_fn(tt)), tt in tgrid)), l in lams6)]:

for i from 0 to 39 do
    p := display(
        pointplot([[lams6[i+1], err_vals[i+1]]], symbol = solidcircle, symbolsize = 18, color = red),
        plot([0, lams6[i+1]], [err_vals[i+1], err_vals[i+1]], color = red, thickness = 2),
        plot([lams6[i+1], lams6[i+1]], [0, err_vals[i+1]], color = red, linestyle = dot, thickness = 1),
        plot(30*e, e = 0.01 .. 0.5, color = blue, linestyle = dash, thickness = 2, legend = "bound O(lambda)"),
        title = cat("||Psi_lambda - Psi||_C at lambda = ", evalf[3](lams6[i+1])),
        view = [0 .. 0.5, 0 .. 30], labels = ["lambda", "norm"]
    ):
    try Export(make_path("anim6", i), p); catch: end try;
end do:

# --- АНИМАЦИЯ 7 ---
printf("Генерация anim7 (40 кадров)...\n");
for i from 0 to 39 do
    lam := 0.5 - i*0.49/39:
    p := display(
        plot(dF(t), t = 0 .. 1, color = black, thickness = 5, legend = "delta F(x,h) = 2*G*Psi"),
        plot(Fq(t, lam), t = 0 .. 1, color = red, linestyle = dash, thickness = 2, legend = "difference quotient"),
        title = cat("Point 2, step 10: lambda = ", evalf[3](lam)),
        view = [0 .. 1, -40 .. 10], labels = ["t", "value"]
    ):
    try Export(make_path("anim7", i), p); catch: end try;
end do:

# --- АНИМАЦИЯ 8 ---
printf("Генерация anim8 (40 кадров)...\n");
C_op := evalf(2*(2*max(seq(abs(xdd(t)), t in tgrid)) + 1)^2 + 6*max(seq(abs(G_fn(t)), t in tgrid))):

for i from 0 to 39 do
    eps := 0.5 - i*0.49/39:
    p := display(
        plot(C_op*e, e = 0.01 .. 0.5, color = red, thickness = 3, legend = "||F'_r(x+k) - F'_r(x)||"),
        plot(0, e = 0.01 .. 0.5, color = black, linestyle = dot, thickness = 2, legend = "limit = 0"),
        pointplot([[eps, C_op*eps]], symbol = solidcircle, symbolsize = 18, color = blue),
        title = cat("Point 2, step 14: eps = ||k|| = ", evalf[3](eps)),
        view = [0 .. 0.5, 0 .. max(100, C_op*eps*1.2)], labels = ["eps", "operator norm"]
    ):
    try Export(make_path("anim8", i), p); catch: end try;
end do:

# ============================================================
# ПРОВЕРКА
# ============================================================
printf("\n=== ПРОВЕРКА СОХРАНЕННЫХ ФАЙЛОВ ===\n");
try
    file_list := FileTools:-ListDirectory(output_dir):
    printf("Найдено файлов: %d\n", nops(file_list));
    if nops(file_list) >= 320 then
        printf("✅ ВСЕ ОТЛИЧНО! Все 320 файлов успешно сохранены на Рабочем столе в папке MaplePlots.\n");
    else
        printf("⚠️ Найдено %d файлов.\n", nops(file_list));
    end if;
catch:
    printf("❌ Не удалось прочитать папку.\n");
end try:
