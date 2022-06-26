# Assignment 4

![image-20211212190914946](D:\应用软件\Typora2\Typora\typora-user-images\image-20211212190914946.png)



**7-10**

关于直线y=x的反射变换矩阵：M=$$ \left[ \matrix{  0 & 1 & 0\\  1 & 0 & 0\\  0 & 0 & 1  } \right] $$

相对x轴的反射矩阵：N=$$ \left[ \matrix{  1 & 0 & 0\\  0 & -1 & 0\\  0 & 0 & 1  } \right] $$

逆时针旋转90°的矩阵：R=$$ \left[ \matrix{  0 & -1 & 0\\  1 & 0 & 0\\  0 & 0 & 1  } \right] $$

M=R·N，因此关于直线y=x的反射变换矩阵等价于相对x轴的反射加上逆时针旋转90度。

**7-13**

！不管怎么旋转，<font color='red'>逆时针转-θ（顺时针转θ）</font>，逆时针转（180°-θ）都可以使直线与x轴重合，但是<font color='red'>恢复的操作一定要是逆操作</font>，你先逆时针转（180°-θ），再逆时针转θ就错了

现将该直线平移到过原点，旋转至与x轴重合，然后做关于x轴的反射，再旋转、平移回到原来位置

平移变换矩阵T=$$ \left[ \matrix{  1 & 0 & 0\\  0 & 1 & -b\\  0 & 0 & 1  } \right] $$，

旋转变换矩阵R=$$ \left[ \matrix{  -cosθ & -sinθ & 0\\  sinθ & -cosθ & 0\\  0 & 0 & 1  } \right] $$

此时直线与x轴正方向的夹角为θ，tanθ=m，`θ=arctan m`，将直线逆时针旋转（180°-θ）即可与x轴重合

关于x轴反射的变换矩阵S=$$ \left[ \matrix{  1 & 0 & 0\\  0 & -1 & 0\\  0 & 0 & 1  } \right] $$

R'=$$ \left[ \matrix{  cosθ & -sinθ & 0\\  sinθ & cosθ & 0\\  0 & 0 & 1  } \right] $$

订正：逆时针转θ-180，R'=$$ \left[ \matrix{  -cosθ & sinθ & 0\\  -sinθ & -cosθ & 0\\  0 & 0 & 1  } \right] $$

T'=$$ \left[ \matrix{  1 & 0 & 0\\  0 & 1 & b\\  0 & 0 & 1  } \right] $$

复合变换矩阵M=T'·R'·S·R·T

M=$$ \left[ \matrix{  1-2cos^2θ & -2sinθcosθ & 2bsinθcosθ\\  -2sinθcosθ & 1-2sin^2θ & 2bsin^2θ\\  0 & 0 & 1  } \right] $$

订正：M=$$ \left[ \matrix{  cos2θ & sin2θ & -bsin2θ\\  sin2θ & -cos2θ & 2bsin^2θ\\  0 & 0 & 1  } \right] $$

2、

![image-20211001172059316](D:\应用软件\Typora2\Typora\typora-user-images\image-20211001172059316.png)

1）做关于y轴的反射

2）做关于x轴的反射

3）平移到指定位置

$$ Sy=\left[ \matrix{  -1 & 0 & 0\\  0 & 1 & 0\\  0 & 0 & 1  } \right] $$

$$Sx= \left[ \matrix{  1 & 0 & 0\\  0 & -1 & 0\\  0 & 0 & 1  } \right] $$

T=$$ \left[ \matrix{  1 & 0 & 6\\  0 & 1 & 0\\  0 & 0 & 1  } \right] $$

$$ M=T·Sx·Sy=\left[ \matrix{  -1 & 0 & 6\\  0 & -1 & 0\\  0 & 0 & 1  } \right] $$

3、

先将L绕y轴旋转到xoy平面上（Ry(α)），再绕z轴旋转到与x轴重合（Rz(β)），再做绕x轴逆时针旋转-60°的变换（Rx(θ)），再旋转回到原来的位置（Ry(-α)、Rz(-β)）

订正：求β的时候错了，绕轴旋转之后得到的线不是投影！投影的话长度都变了，形成以y轴为轴线的圆锥，y坐标不变，长度不变，所以d=(b^2^+c^2^)^1/2^

![image-20211110165234725](D:\应用软件\Typora2\Typora\typora-user-images\image-20211110165234725.png)

![image-20211110165847315](D:\应用软件\Typora2\Typora\typora-user-images\image-20211110165847315.png)

![image-20211011212544721](D:\应用软件\Typora2\Typora\typora-user-images\image-20211011212544721.png)

![image-20211011212518890](D:\应用软件\Typora2\Typora\typora-user-images\image-20211011212518890.png)

复合变换矩阵 `M=Ry(-α)Rz(-β)R(θ)Rz(β)Ry(α)`

1.转到面，投影到垂直该轴的面上求旋转角

2.求旋转后的直线（<font color='red'>不是投影</font>），计算旋转到轴的旋转角

注意：右手系画坐标系，站在箭头指向你的方向判断是顺时针旋转还是逆时针，顺时针旋转要变成-θ代入公式

3.算之前最好先求直线的单位化方向矢量

## 实验自学记录

感觉reshape函数还不是很理解，助教哥哥讲实验的时候能不能重点讲讲二维和三维的投影变换gluOrtho2D、glFrustum，还有视口的调整glViewPort，讲讲这几个函数内部具体执行的是什么操作。谢谢:rose::rose:

### 实验二

？由于窗口大小变化，而视图大小被硬编码，导致比例失准，圆形变成椭圆

改变窗口大小时视口的大小没变，所以显示的图像比例就改变了，用glViewPort把视口和窗口的宽高比例设置成一样的就不会再改变窗口大小时变形了

通过回调函数glutReshapeFunc调用myReshape，在窗口大小发生改变时，就会将窗口宽度和高度传入绑定函数，进行自定义处理。

![image-20211018170658413](D:\应用软件\Typora2\Typora\typora-user-images\image-20211018170658413.png)

![image-20211018173321867](D:\应用软件\Typora2\Typora\typora-user-images\image-20211018173321867.png)

### 实验四

![image-20211018190505577](D:\应用软件\Typora2\Typora\typora-user-images\image-20211018190505577.png)

显示隐藏的面为什么只有下表面被显示出来了，其他内表面没显示？

应该是因为画图顺序的原因，其他的面被正面覆盖了，下表面是在正面之后画的

这种涂色是在画面的时候给同一个面涂了不同的颜色，smooth会有渐变效果，flat后面的颜色直接覆盖前面的，想给六个面画上不同的颜色应该要在画面的时候进行设置

![image-20211025150017709](D:\应用软件\Typora2\Typora\typora-user-images\image-20211025150017709.png)

![image-20211018195909732](D:\应用软件\Typora2\Typora\typora-user-images\image-20211018195909732.png)

不显示隐藏的面之后正视图就是一个正方形

![image-20211018192354874](D:\应用软件\Typora2\Typora\typora-user-images\image-20211018192354874.png)



<font color='green'>openGL画图基本框架</font>

```c++
#include <GL/glut.h>
#include <cstdlib>

void main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB); // 在创建窗口的时候，指定其显示模式的类型(包括颜色模式和缓冲区类型) 
    glutInitWindowPosition(50, 100); // 设置窗口显示的初始位置
    glutInitWindowSize(400, 300); // 设置窗口的宽和高
    glutCreateWindow("窗口的名字"); // 创建窗口
    init(); // 执行你自己编写的初始化函数
    glutDisplayFunc(myDisplay); // 回调函数，显示图像，参数是你自己编写的显示函数
    glutMainLoop(); // 显示并且等待后续的命令
}

void init(void)
{
    glClearColor(1.0, 1.0, 1.0, 0.0); // 指定颜色缓冲区的清除值，设置窗口的背景颜色
    //投影的变换也常常被写到reshape里面，init中就不用写了
    //画二维的图像
    glMatrixMode(GL_PROJECTION); // ？
    gluOrtho2D(0.0, 200.0, 0.0, 150.0);// ？二维正投影
    //画三维的图像
    glFrustum(-2.5, 2.5, -2.5, 2.5, mynear, myfar);//设置视椎体
}

void myDisplay(void)
{
    //设置颜色，R,G,B在0到1
    glColor3f(0.0, 0.4, 0.2);
    //在显示函数里面调用执行画图操作的函数
    myGraphy();
    //刷新当前缓冲区
    glFlush();
}

void myGraphy()
{
    //画点，不可以直接用glVertex2i，这应该只是一个定位函数，不会显示
    glBegin(GL_POINTS);
	glVertex2i(xCoord, yCoord);
	glEnd();
    //画线，设置两个端点的位置
    glBegin(GL_LINES);
        glVertex2i(180, 15); 
        glVertex2i(10, 145); 
    glEnd();
}
```

glutInitDisplayMode

![image-20211018171128076](D:\应用软件\Typora2\Typora\typora-user-images\image-20211018171128076.png)

![image-20211018172144784](D:\应用软件\Typora2\Typora\typora-user-images\image-20211018172144784.png)
