# Задача: Касательный конус \($T_{x_0}M$\) (Вариант 17)

**Условие задачи:**
Дано множество и точка:
\[
$M$ = \{ ($x_1, x_2$) \in \mathbb{$R}^2$ $\mid x_1 \leq 0,\  x_2 \leq 0,\  x_1^2 + x_2^2 \leq 1$ \}, \quad $x_0 = (0,0)$.
\]
Требуется исследовать множество \($M$\) в точке \($x_0$\) и найти касательный конус \($T_{x_0}M$\).

## 📄 Документы

*   **[📥 Скачать PDF с подробным решением](./Project/Задача_2_вариант_17_часть_2.pdf)**
*   **[📝 Скачать исходный код LaTeX](./Codes/Задача_2_вариант_17_часть_2.tex)**
*   **[💻 Скачать рабочий файл Maple (.mw)](./Codes/Задача_2_вариант_17_часть_2.mw)** *(откроется в программе)*
*   **[📄 Посмотреть код Maple (.mpl) прямо на сайте](./Codes/Задача_2_вариант_17_часть_2.mpl)** *(текстовая версия)*
*   **[📥 Скачать Jupiter с подробным решением](./Project/Задача_2_вариант_17_часть_2.ipynb)**

---

## 📊 Визуализация касательного конуса

На графике ниже представлена анимация, иллюстрирующая построение касательного конуса к заданному множеству \(M\) в точке \(x_0\).

<p align="left">
  <!-- Замените путь на ваш сохраненный GIF файл -->
  <img src="./images/tangent_cone.gif" width="600" alt="Анимация: Касательный конус">
</p>

**Что изображено на графике (кратко и понятно):**
* 🔵 **Светло-синяя область** — допустимое множество \(M\). Оно ограничено осями \(x_1 \le 0\), \(x_2 \le 0\) и дугой окружности \(x_1^2 + x_2^2 \le 1\).
* ⚫ **Черная точка** — исследуемая точка \(x_0(0,0)\).
* 🔴 **Красные стрелки \((\nabla g_1, \nabla g_2)\)** — градиенты активных ограничений \(x_1 \le 0\) и \(x_2 \le 0\). Они указывают направление «наружу» от множества \(M\) (вдоль положительных полуосей). Ограничение-окружность в точке \((0,0)\) не является активным, так как \(0^2 + 0^2 < 1\).
* 🟢🟣🟠 **Цветные кривые и векторы** — примеры допустимых траекторий внутри \(M\), стремящихся к \(x_0\), и их предельные направления (касательные векторы).
* 🔵 **Синяя анимированная стрелка** — «заметает» сектор от оси \(x_1\) до оси \(x_2\). Она визуализирует **касательный конус** \(T_{x_0}M\). Так как в точке \(x_0\) активны только ограничения \(x_1 \le 0\) и \(x_2 \le 0\), касательный конус совпадает с третьим квадрантом: \(T_{x_0}M = \{(d_1, d_2) \in \mathbb{R}^2 \mid d_1 \le 0, d_2 \le 0\}\).

---

## 💻 Код Maple (генерация анимации)

<details>
<summary><b>Нажмите, чтобы развернуть код Maple (построение графика и анимации)</b></summary>

```maple
restart;
with(plots):
with(plottools):

# 1. Допустимое множество M (третий квадрант, ограниченный окружностью)
# Примечание: визуально синяя область показывает третий квадрант, 
# так как окружность x1^2+x2^2<=1 в масштабе графика [-3.5, 2.5] не выходит за его пределы.
M_plot := inequal({x1 <= 0, x2 <= 0}, x1 = -3.5 .. 1, x2 = -3.5 .. 1, 
    optionsfeasible = [color = "LightBlue", transparency = 0.3], 
    optionsclosed = [color = black, thickness = 2], 
    optionsexcluded = [color = "white"]):

Point_O := pointplot([0, 0], symbol = solidcircle, symbolsize = 15, color = black):

# 2. Градиенты (внешние нормали)
Grad_1 := plots:-arrow([0, 0], [1.5, 0], color = red, thickness = 3, head_length = 0.15):
Grad_2 := plots:-arrow([0, 0], [0, 1.5], color = red, thickness = 3, head_length = 0.15):
Text_G1 := textplot([1.6, 0.2, "∇g1"], font = [TIMES, BOLD, 14], color = red):
Text_G2 := textplot([0.2, 1.6, "∇g2"], font = [TIMES, BOLD, 14], color = red):

# 3. Допустимые кривые
Curve_1 := plot([-t, -t^2, t = 0 .. 2.5], color = green, thickness = 2):
Curve_2 := plot([-t^2, -t, t = 0 .. 2.5], color = purple, thickness = 2):
Curve_3 := plot([-t, -t, t = 0 .. 2.5], color = orange, thickness = 2):

# Подписи к кривым
Text_C1 := textplot([-2.2, -0.5, "x2 = -x1²"], font = [TIMES, ITALIC, 12], color = green):
Text_C2 := textplot([-0.5, -2.2, "x1 = -x2²"], font = [TIMES, ITALIC, 12], color = purple):
Text_C3 := textplot([-1.5, -1.5, "x1 = x2"], font = [TIMES, ITALIC, 12], color = orange):

# 4. Предельные векторы направлений
Vec_1 := plots:-arrow([0, 0], [-2, 0], color = green, thickness = 3, head_length = 0.15):
Vec_2 := plots:-arrow([0, 0], [0, -2], color = purple, thickness = 3, head_length = 0.15):
Vec_3 := plots:-arrow([0, 0], [-2, -2], color = orange, thickness = 3, head_length = 0.15):

# 5. Анимация движения точек по кривым
Anim_Pt1 := animate(pointplot, [[-t, -t^2]], t = 2.5 .. 0, frames = 60, symbol = solidcircle, symbolsize = 12, color = green):
Anim_Pt2 := animate(pointplot, [[-t^2, -t]], t = 2.5 .. 0, frames = 60, symbol = solidcircle, symbolsize = 12, color = purple):
Anim_Pt3 := animate(pointplot, [[-t, -t]], t = 2.5 .. 0, frames = 60, symbol = solidcircle, symbolsize = 12, color = orange):

# 6. Анимация заметания касательного конуса (синий вектор)
Anim_Cone := animate(
    plots:-arrow, 
    [[0, 0], [2.5*cos(theta), 2.5*sin(theta)], color = blue, thickness = 4, head_length = 0.15], 
    theta = Pi .. (3*Pi)/2, 
    frames = 90
):

# Подпись к конусу
Text_Cone := textplot([-2.5, -2.8, "T(0,0)M"], font = [TIMES, BOLD, 14], color = blue):

# 7. Сборка всего графика с последовательной анимацией
display(
    M_plot, Point_O, 
    Grad_1, Grad_2, Text_G1, Text_G2, 
    Curve_1, Curve_2, Curve_3, Text_C1, Text_C2, Text_C3,
    Vec_1, Vec_2, Vec_3, 
    Anim_Pt1, Anim_Pt2, Anim_Pt3, 
    Anim_Cone, Text_Cone,
    title = "Касательный конус T(0,0)M", 
    titlefont = [TIMES, BOLD, 16], 
    axes = boxed, labels = ["x1", "x2"], 
    view = [-3.5 .. 2.5, -3.5 .. 2.5], 
    scaling = constrained,
    insequence = true
);
