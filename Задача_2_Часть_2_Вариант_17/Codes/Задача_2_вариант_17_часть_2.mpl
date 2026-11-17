restart;
with(plots):
Digits := 15:

# ============================================================
# ПУНКТ 1
# ============================================================
f1 := x -> abs(x):

# --- ГРАФИК 1: Секущая при x0 = 1 ---
lam := 0.5:
slope := (abs(1+lam)-1)/lam:
p1 := display(
    plot(f1(x), x = -0.5 .. 2.5, color = blue, thickness = 4, legend = "f(x) = |x|"),
    plot(1 + slope*(x - 1), x = -0.5 .. 2.5, color = red, linestyle = dash, thickness = 3, legend = "secant"),
    pointplot([[1, 1]], symbol = solidcircle, symbolsize = 22, color = black),
    textplot([[1.5, 2.5, cat("slope = ", evalf[3](slope))]], font = [TIMES, BOLD, 14], color = red),
    title = cat("Point 1, x0=1, lambda = ", evalf[3](lam)),
    view = [-0.5 .. 2.5, -0.5 .. 3.0], labels = ["x", "y"]
):
p1;

# --- ГРАФИК 2: Секущая при x0 = 0 ---
lam := 0.5:
slope := abs(lam)/lam:
p2 := display(
    plot(f1(x), x = -2 .. 2, color = blue, thickness = 4, legend = "f(x) = |x|"),
    plot(slope*x, x = -2 .. 2, color = red, linestyle = dash, thickness = 3, legend = "secant"),
    pointplot([[0, 0]], symbol = solidcircle, symbolsize = 18, color = black),
    title = cat("Point 1, x0=0, lambda = ", evalf[3](lam)),
    view = [-2 .. 2, -2.0 .. 2.5], labels = ["x", "y"]
):
p2;

# --- ГРАФИК 3: Функция phi(lambda) ---
lam := 0.5:
phi0 := abs(lam)/lam: 
phi1 := 1:
p3 := display(
    plot(abs(t)/t, t = -1 .. 1, discont = true, color = red, thickness = 4, legend = "x0=0: phi=sgn(lambda)"),
    plot(1, t = -1 .. 1, color = green, thickness = 4, legend = "x0=1: phi=1"),
    pointplot([[lam, phi0], [lam, phi1]], symbol = solidcircle, symbolsize = 18, color = [red, green]),
    title = cat("phi(lambda) at lambda = ", evalf[3](lam)),
    view = [-1 .. 1, -1.6 .. 1.6], labels = ["lambda", "phi"]
):
p3;

# --- ГРАФИК 4: sgn(x) ---
x_test := 0.5:
p4 := display(
    plot(signum(x), x = -2 .. 2, discont = true, color = green, thickness = 4, legend = "sgn(x) - matrix entry (3,1)"),
    plot([x_test, x_test], -1.6 .. 1.6, color = red, linestyle = dot, thickness = 2),
    pointplot([[x_test, signum(x_test)]], symbol = solidcircle, symbolsize = 20, color = blue),
    title = cat("Point 1, condition (3): check x = ", evalf[3](x_test)),
    view = [-2 .. 2, -1.6 .. 1.6], labels = ["x", "sgn(x)"]
):
p4;


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

# --- ГРАФИК 5: Psi_lambda(t) -> Psi(t) ---
lam := 0.1: # Берем маленькую лямбду, чтобы показать сходимость
p5 := display(
    plot(Psi_fn(t), t = 0 .. 1, color = black, thickness = 5, legend = "Psi(t) - limit"),
    plot(PsiL(t, lam), t = 0 .. 1, color = red, linestyle = dash, thickness = 2, legend = "Psi_lambda(t)"),
    title = cat("Point 2, step 6: lambda = ", evalf[3](lam)),
    view = [0 .. 1, -25 .. 5], labels = ["t", "Psi"]
):
p5;

# --- ГРАФИК 6: Оценка скорости сходимости ---
lam := 0.1:
err_val := max(seq(abs(PsiL(tt, lam) - Psi_fn(tt)), tt in tgrid)):
p6 := display(
    pointplot([[lam, err_val]], symbol = solidcircle, symbolsize = 18, color = red),
    plot([0, lam], [err_val, err_val], color = red, thickness = 2),
    plot([lam, lam], [0, err_val], color = red, linestyle = dot, thickness = 1),
    plot(30*e, e = 0.01 .. 0.5, color = blue, linestyle = dash, thickness = 2, legend = "bound O(lambda)"),
    title = cat("||Psi_lambda - Psi||_C at lambda = ", evalf[3](lam)),
    view = [0 .. 0.5, 0 .. 30], labels = ["lambda", "norm"]
):
p6;

# --- ГРАФИК 7: Разностное отношение -> dF ---
lam := 0.1:
p7 := display(
    plot(dF(t), t = 0 .. 1, color = black, thickness = 5, legend = "delta F(x,h) = 2*G*Psi"),
    plot(Fq(t, lam), t = 0 .. 1, color = red, linestyle = dash, thickness = 2, legend = "difference quotient"),
    title = cat("Point 2, step 10: lambda = ", evalf[3](lam)),
    view = [0 .. 1, -40 .. 10], labels = ["t", "value"]
):
p7;

# --- ГРАФИК 8: Операторная норма ---
C_op := evalf(2*(2*max(seq(abs(xdd(t)), t in tgrid)) + 1)^2 + 6*max(seq(abs(G_fn(t)), t in tgrid))):
eps := 0.1:
p8 := display(
    plot(C_op*e, e = 0.01 .. 0.5, color = red, thickness = 3, legend = "||F'_r(x+k) - F'_r(x)||"),
    plot(0, e = 0.01 .. 0.5, color = black, linestyle = dot, thickness = 2, legend = "limit = 0"),
    pointplot([[eps, C_op*eps]], symbol = solidcircle, symbolsize = 18, color = blue),
    title = cat("Point 2, step 14: eps = ||k|| = ", evalf[3](eps)),
    view = [0 .. 0.5, 0 .. max(100, C_op*eps*1.2)], labels = ["eps", "operator norm"]
):
p8;
