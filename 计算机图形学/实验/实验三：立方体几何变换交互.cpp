#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <GL/glut.h>

float mynear = 1.0; /* near clipping plane in eye coords */
float myfar = 7.0; /* far clipping plane in eye coords */
float viewxform_z = -5.0;

GLfloat vertices[8][3] = {
{-1.0,-1.0,-1.0}, {1.0,-1.0,-1.0}, {1.0,1.0,-1.0}, {-1.0,1.0,-1.0},
{-1.0,-1.0,1.0}, {1.0,-1.0,1.0}, {1.0,1.0,1.0}, {-1.0,1.0,1.0}
};

GLfloat colors[8][3] = {
{0.0,0.0,0.0}, {1.0,0.0,0.0}, {1.0,1.0,0.0}, {0.0,1.0,0.0},
{0.0,0.0,1.0}, {1.0,0.0,1.0}, {1.0,1.0,1.0}, {0.0,1.0,1.0}
};

GLfloat objectXform[4][4] = {
{1.0, 0.0, 0.0, 0.0},
{0.0, 1.0, 0.0, 0.0},
{0.0, 0.0, 1.0, 0.0},
{0.0, 0.0, 0.0, 1.0}
};

enum TransMode {
    Translate,
    Rotate,
    Scale
};
TransMode transModeSelected = Rotate;
float angle = 0.0, axis[3];
int winWidth, winHeight;

void myReshape(int w, int h)
{
    winWidth = w;
    winHeight = h;
    glViewport(0, 0, w, h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrtho(-5.0, 5.0, -5.0, 5.0, mynear, myfar);
    viewxform_z = -5.0;
    glMatrixMode(GL_MODELVIEW);
}

bool drawLines = false;
void polygon(int a, int b, int c, int d, int face)
{
    /* draw a polygon via list of vertices */
    if (drawLines) {
        glColor3f(1.0, 1.0, 1.0);
        glBegin(GL_LINE_LOOP);
        glVertex3fv(vertices[a]);
        glVertex3fv(vertices[b]);
        glVertex3fv(vertices[c]);
        glVertex3fv(vertices[d]);
        glEnd();
    }
    else {
        glBegin(GL_POLYGON);
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
}

void colorcube(void)
{
    /* map vertices to faces */
    polygon(1, 0, 3, 2, 0);
    polygon(3, 7, 6, 2, 1);
    polygon(7, 3, 0, 4, 2);
    polygon(2, 6, 5, 1, 3);
    polygon(4, 5, 6, 7, 4);
    polygon(5, 4, 0, 1, 5);
}

void display(void)
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
         /* view transform */
    glLoadIdentity();
    glTranslatef(0.0, 0.0, viewxform_z);
 
    if (transModeSelected == Translate)
    {
        // 平移
        glPushMatrix();
        glLoadIdentity();
        glTranslatef(axis[0], axis[1], axis[2]);
        glMultMatrixf((GLfloat*)objectXform);
        glGetFloatv(GL_MODELVIEW_MATRIX, (GLfloat*)objectXform);
        glPopMatrix();

    }
    else if (transModeSelected == Rotate)
    {
        // 旋转
        glPushMatrix();
        glLoadIdentity();
        glRotated(angle, axis[0], axis[1], axis[2]);
        glMultMatrixf((GLfloat*)objectXform);
        glGetFloatv(GL_MODELVIEW_MATRIX, (GLfloat*)objectXform);
        glPopMatrix();

    }
    else if (transModeSelected == Scale)
    {
        // 缩放
        //将当前状态存入矩阵栈
        glPushMatrix();

        //重置当前指定的矩阵为单位矩阵，GL_MODELVIEW_MATRIX=I
        glLoadIdentity();
        
        //将缩放变换的矩阵乘到GL_MODELVIEW_MATRIX上，GL_MODELVIEW_MATRIX=S*GL_MODELVIEW_MATRIX
        //缩放变换在调用时加1
        glScalef(axis[0]+1, axis[1]+1, axis[2]+1);
 
        //将缩放变换的矩阵左乘物体当前的坐标变换矩阵，GL_MODELVIEW_MATRIX=GL_MODELVIEW_MATRIX*objectXform
        glMultMatrixf((GLfloat*)objectXform);

        //返回参数更新objectXform,objectXform=GL_MODELVIEW_MATRIX
        glGetFloatv(GL_MODELVIEW_MATRIX, (GLfloat*)objectXform);

        //矩阵弹栈，世界坐标回到变换之前的状态，以免变换累积
        glPopMatrix();
    }

    glPushMatrix();
    //用objectXform做变换后画出colorcube，GL_MODELVIEW_MATRIX=GL_MODELVIEW_MATRIX*objectXform
    glMultMatrixf((GLfloat*)objectXform);
    colorcube();
    glPopMatrix();
    glFlush();
    glutSwapBuffers();
}

void mouseButton(int button, int state, int x, int y);
void mouseMotion(int x, int y);
void keyboard(unsigned char key, int x, int y);
void init(void);

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);//画三维图形，打开深度测试
    glClearDepth(1.0); // 用1.0填满缓存
    glutInitWindowSize(500, 500);
    glutCreateWindow("Cube");

    glutMouseFunc(mouseButton);
    glutMotionFunc(mouseMotion);
    glutKeyboardFunc(keyboard);
    init();
    glutReshapeFunc(myReshape);
    glutDisplayFunc(display);
    glutMainLoop();
    return 0;
}

//
int lastX, lastY;
void startMotion(int x, int y)
{
    lastX = x;
    lastY = y;
}

void stopMotion(int x, int y)
{
    angle = 0.0f;
    memset(axis, 0, sizeof(axis));
    printf("objectXform:\n");
    for (int i = 0; i < 4; i++)
    {
        printf("\t");
        for (int j = 0; j < 4; j++)
        {
            printf("%.2f\t", objectXform[i][j]);
        }
        printf("\n");
    }
}

void mouseButton(int button, int state, int x, int y)
{
    switch (button) {
    case GLUT_LEFT_BUTTON:
        break;
    default:
        return;
    }
    switch (state) {
    case GLUT_DOWN:
        startMotion(x, y);
        break;
    case GLUT_UP:
        stopMotion(x, y);
        break;
    }
}

void mouseMotion(int x, int y)
{
    float dx = x - lastX;
    float dy = y - lastY;
    if (!dx && !dy) return;
    if (transModeSelected == Translate) {
        axis[0] = dx * (10.0f / winWidth);
        axis[1] = -dy * (10.0f / winHeight);
        axis[2] = 0;
    }
    else if (transModeSelected == Rotate) {
        angle = 3.0;
        axis[0] = dy * (360.0f / winHeight);
        axis[1] = dx * (360.0f / winWidth);
        axis[2] = 0;
    }
    else if (transModeSelected == Scale) {
        axis[0] = dx * (4.0f / winWidth);
        axis[1] = -dy * (4.0f / winHeight);
        axis[2] = 0; // 在调用glScale时要 +1
    }
    lastX = x;
    lastY = y;
    glutPostRedisplay();
}

//键盘操作
void userEventAction(int key);
void keyboard(unsigned char key, int x, int y)
{
    userEventAction(key);
}

void userEventAction(int key) {
    switch (key) {
    case '0':
        angle = 0.0f;
        memset(axis, 0, sizeof(axis));
        memset(objectXform, 0, sizeof(objectXform)); // 变换矩阵重置
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                if (i == j) {
                    objectXform[i][j] = 1.0f;
                }
            }
        }
        break;
    case 'r': // 旋转
        transModeSelected = Rotate;
        break;
    case 't': // 平移
        transModeSelected = Translate;
        break;
    case 's': // 缩放
        transModeSelected = Scale;
        break;
    case '1': // 线框图/多边形
        drawLines = !drawLines;
        break;
    case 27: // ESC 键（ASCII: 27）退出
        exit(0);
        break;
    default:
        break;
    }
    glutPostRedisplay(); // 重绘
}

//菜单功能
struct menuEntryStruct {
    const char* label;
    char key;
};

static menuEntryStruct mainMenu[] = {
"Reset", '0',
"Rotate", 'r',
"Translate", 't',
"Scale", 's',
"lines/polygons", '1',
"quit", 27, //ESC 键（ASCII: 27）
};
int mainMenuEntries = sizeof(mainMenu) / sizeof(menuEntryStruct);

void selectMain(int choice) // 序号->key 映射
{
    userEventAction(mainMenu[choice].key); // 调用通用动作解释函数
}

void init(void)
{
    glLineWidth(3.0);
    glEnable(GL_DEPTH_TEST); /* Enable hidden--surface--removal */

    // 绑定菜单
    glutCreateMenu(selectMain); // 使用 selectMain 作为菜单调用函数
    for (int i = 0; i < mainMenuEntries; i++) {
        glutAddMenuEntry(mainMenu[i].label, i);
    }
    glutAttachMenu(GLUT_RIGHT_BUTTON); // 菜单绑定右键
}

