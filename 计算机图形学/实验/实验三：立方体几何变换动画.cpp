#include <math.h>
#include <windows.h>
#include <GL/glut.h>
using namespace std;
float mynear = 3.0; /* near clipping plane in eye coords */
float myfar = 7.0; /* far clipping plane in eye coords */
float viewxform_z = -5.0;
void display(void);
GLfloat vertices[][3] = {
{-1.0,-1.0,-1.0}, {1.0,-1.0,-1.0}, {1.0,1.0,-1.0}, {-1.0,1.0,-1.0},
{-1.0,-1.0,1.0}, {1.0,-1.0,1.0}, {1.0,1.0,1.0}, {-1.0,1.0,1.0}
};

GLfloat colors[][3] = {
{0.0,0.0,0.0}, {1.0,0.0,0.0}, {1.0,1.0,0.0}, {0.0,1.0,0.0},
{0.0,0.0,1.0}, {1.0,0.0,1.0}, {1.0,1.0,1.0}, {0.0,1.0,1.0}
};

//�任��������ģ�;ֲ�����ϵ�������������ϵ�ı任���������ڴ���׶��Ա任��ʵ�ֱ任���ۻ�
GLfloat objectXform[4][4] = {
{1.0, 0.0, 0.0, 0.0},
{0.0, 1.0, 0.0, 0.0},
{0.0, 0.0, 1.0, 0.0},
{0.0, 0.0, 0.0, 1.0}
};
void init(void)
{
    glLineWidth(3.0);
    glEnable(GL_DEPTH_TEST); /* Enable hidden--surface--removal */
}

void myReshape(int w, int h)
{
    glViewport(0, 0, w, h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrtho(-5.0, 5.0, -5.0, 5.0, mynear, myfar);
    viewxform_z = -5.0;
    glMatrixMode(GL_MODELVIEW);
}


float time = 0.0;
float deltaTime = 0.01;
int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);//����άͼ�Σ�����Ȳ���
    glClearDepth(1.0); // ��1.0��������
    glutInitWindowSize(500, 500);
    glutCreateWindow("Cube");

    init();
    glutReshapeFunc(myReshape);
    glutDisplayFunc(display);
    glutMainLoop();
    return 0;
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
    ///////////////////////////////////////////////////////////////////////
    /*
    // ƽ��
    glPushMatrix();
    glLoadIdentity();
    GLfloat deltaHeight = (GLfloat)(sin(time + deltaTime) - sin(time)) * 2;

    glTranslatef(0.0, deltaHeight, 0.0);
    glMultMatrixf((GLfloat*)objectXform);
    glGetFloatv(GL_MODELVIEW_MATRIX, (GLfloat*)objectXform);
    glPopMatrix();
    */
    // ��ת ...
    glPushMatrix();
    glLoadIdentity();
    //����deltaAngle�����������ڡ�180�ȵķ�Χ����ת
    GLfloat deltaAngle = (GLfloat)(sin(time + deltaTime) - sin(time)) * 90;
    glRotated(1, deltaAngle, 0.5, 0);//�������Ƕȣ���ת����
    glMultMatrixf((GLfloat*)objectXform);//����ǰ��������������
    //glGet�鿴ָ��������GL_MODELVIEW_MATRIX��ʾ���������ջ�������Ϣ
    glGetFloatv(GL_MODELVIEW_MATRIX, (GLfloat*)objectXform);
    glPopMatrix();//ѹ��͵�����ǰ�����ջ
    // ���� ...
    ///////////////////////////////////////////////////////////////////////
    glPushMatrix();
    glMultMatrixf((GLfloat*)objectXform);
    colorcube();
    glPopMatrix();
    glFlush();
    glutSwapBuffers();
    Sleep(deltaTime * 1000);
    time += deltaTime;
    glutPostRedisplay();
}
