#include <GL/glut.h>
#include <cstdlib>

GLfloat vertices[8][3] = {
{-1.0,-1.0,-1.0}, {1.0,-1.0,-1.0}, {1.0,1.0,-1.0}, {-1.0,1.0,-1.0},
{-1.0,-1.0,1.0}, {1.0,-1.0,1.0}, {1.0,1.0,1.0}, {-1.0,1.0,1.0}
};

GLfloat colors[8][3] = {
{0.0,0.0,0.0}, {1.0,0.0,0.0}, {1.0,1.0,0.0}, {0.0,1.0,0.0},
{0.0,0.0,1.0}, {1.0,0.0,1.0}, {1.0,1.0,1.0}, {0.0,1.0,1.0}
};

float mynear = 3.0; /* near clipping plane in eye coords */
float myfar = 7.0; /* far clipping plane in eye coords */
float viewxform_z = -5.0;

void init(void)
{
    //glShadeModel(GL_FLAT);
    glShadeModel(GL_SMOOTH);//设置着色的模式
    glEnable(GL_DEPTH_TEST); //开启深度检测，Enable hidden--surface--removal
}

void polygon(int a, int b, int c, int d)
{
    /* draw a polygon via list of vertices */
    glColor3f(1.0, 1.0, 1.0);
    //glBegin(GL_LINE_LOOP);//画边
    glBegin(GL_POLYGON);//画面
        glColor3fv(colors[a]);
        glVertex3fv(vertices[a]);
        glColor3fv(colors[b]);
        glVertex3fv(vertices[b]);
        glColor3fv(colors[c]);
        glVertex3fv(vertices[c]);
        glColor3fv(colors[d]);
        glVertex3fv(vertices[d]);
    glEnd();
}

void drawcube(void)
{
    /* map vertices to faces */
    polygon(1, 0, 3, 2);
    polygon(3, 7, 6, 2);
    polygon(7, 3, 0, 4);
    polygon(2, 6, 5, 1);
    polygon(4, 5, 6, 7);
    polygon(5, 4, 0, 1);
}

void display(void)
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    /* view transform */
    glLoadIdentity();
    glTranslatef(0.0, 0.0, viewxform_z);
    //需要保证在后续渲染时对象不会累积平移量 ，因 此 使 用 glLoadIdentity 复 位
    //glRotated(45, 1, 0.5, 0);
    drawcube();
    glutSwapBuffers();
    //双缓冲使用额外一倍空间的缓冲区存储下一帧将要绘制的图像，
    //在显示时交换两个缓冲区，因此原来的 glFlush 函数只能刷新当前缓冲区显示，
    //需改用 glutSwapBuffers函数交换两个缓冲区内容。
    glutPostRedisplay();
    //通知 GLUT 程序重新绘制窗口
    
}

void myReshape(int w, int h)
{
    glViewport(0, 0, w, h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    if (w >= h)//确保乘的系数>=1放大
        glFrustum(-2.5 * (GLfloat)w / (GLfloat)h, 2.5 * (GLfloat)w / (GLfloat)h, -2.5, 2.5, mynear, myfar);
    else
        glFrustum(-2.5 , 2.5 , -2.5 * (GLfloat)h / (GLfloat)w, 2.5 * (GLfloat)h / (GLfloat)w, mynear, myfar);
    
    glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);//画三维图形，打开深度测试
    glClearDepth(1.0); // 用1.0填满缓存
    glutInitWindowSize(500, 500);
    glutCreateWindow("Cube");

    init();
    glutReshapeFunc(myReshape);
    glutDisplayFunc(display);
    glutMainLoop();
    return 0;
}