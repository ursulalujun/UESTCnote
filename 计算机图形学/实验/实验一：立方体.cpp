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
    glShadeModel(GL_SMOOTH);//������ɫ��ģʽ
    glEnable(GL_DEPTH_TEST); //������ȼ�⣬Enable hidden--surface--removal
}

void polygon(int a, int b, int c, int d)
{
    /* draw a polygon via list of vertices */
    glColor3f(1.0, 1.0, 1.0);
    //glBegin(GL_LINE_LOOP);//����
    glBegin(GL_POLYGON);//����
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
    //��Ҫ��֤�ں�����Ⱦʱ���󲻻��ۻ�ƽ���� ���� �� ʹ �� glLoadIdentity �� λ
    //glRotated(45, 1, 0.5, 0);
    drawcube();
    glutSwapBuffers();
    //˫����ʹ�ö���һ���ռ�Ļ������洢��һ֡��Ҫ���Ƶ�ͼ��
    //����ʾʱ�������������������ԭ���� glFlush ����ֻ��ˢ�µ�ǰ��������ʾ��
    //����� glutSwapBuffers���������������������ݡ�
    glutPostRedisplay();
    //֪ͨ GLUT �������»��ƴ���
    
}

void myReshape(int w, int h)
{
    glViewport(0, 0, w, h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    if (w >= h)//ȷ���˵�ϵ��>=1�Ŵ�
        glFrustum(-2.5 * (GLfloat)w / (GLfloat)h, 2.5 * (GLfloat)w / (GLfloat)h, -2.5, 2.5, mynear, myfar);
    else
        glFrustum(-2.5 , 2.5 , -2.5 * (GLfloat)h / (GLfloat)w, 2.5 * (GLfloat)h / (GLfloat)w, mynear, myfar);
    
    glMatrixMode(GL_MODELVIEW);
}

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