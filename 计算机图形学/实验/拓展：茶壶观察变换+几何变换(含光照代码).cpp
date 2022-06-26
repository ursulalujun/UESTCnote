#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <GL/glut.h>

GLfloat xview = 0.0, yview = 0.0, zview = 0.0; // Viewingcoordinate origin.
GLfloat xref = 0.0, yref = 0.0, zref = -1.0; // Look-at point.
GLfloat Vx = 0.0, Vy = 1.0, Vz = 0.0; // View-up vector.

float mynear = 1.0; /* near clipping plane in eye coords */
float myfar = 7.0; /* far clipping plane in eye coords */
float viewxform_z = -5.0;
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
bool drawLines = 0;

void setLightRes() {
    GLfloat mat_specular[] = { 1.0, 1.0, 1.0, 1.0 };
    GLfloat mat_shininess[] = { 50.0 };
    GLfloat light_position[] = { 1.0, 1.0, 1.0, 0.0 };
    GLfloat white_light[] = { 1.0, 1.0, 1.0, 1.0 };
    GLfloat Light_Model_Ambient[] = { 0.2 , 0.2 , 0.2 , 1.0 };

    glClearColor(0.0, 0.0, 0.0, 0.0);
    glShadeModel(GL_SMOOTH);
    glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);
    glMaterialfv(GL_FRONT, GL_SHININESS, mat_shininess);
    glLightfv(GL_LIGHT0, GL_POSITION, light_position);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, white_light);
    glLightfv(GL_LIGHT0, GL_SPECULAR, white_light);
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, Light_Model_Ambient);
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glEnable(GL_DEPTH_TEST);

}

void display(void)
{
    glColor3f(0.8, 1.0, 0.8);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    //glMatrixMode(GL_PROJECTION);
    //glLoadIdentity();
    //glFrustum(-2.5, 2.5, -2.5, 2.5, mynear, myfar);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    gluLookAt(xview, yview, zview, xref, yref, zref, Vx, Vy, Vz);
    glTranslatef(0.0, 0.0, viewxform_z);

    if (transModeSelected == Translate)
    {
        // ƽ��
        glPushMatrix();
        glLoadIdentity();
        glTranslatef(axis[0], axis[1], axis[2]);
        glMultMatrixf((GLfloat*)objectXform);
        glGetFloatv(GL_MODELVIEW_MATRIX, (GLfloat*)objectXform);
        glPopMatrix();

    }
    else if (transModeSelected == Rotate)
    {
        // ��ת
        glPushMatrix();
        glLoadIdentity();
        glRotated(angle, axis[0], axis[1], axis[2]);
        glMultMatrixf((GLfloat*)objectXform);
        glGetFloatv(GL_MODELVIEW_MATRIX, (GLfloat*)objectXform);
        glPopMatrix();

    }
    else if (transModeSelected == Scale)
    {
        // ����
        glPushMatrix();
        glLoadIdentity();
        //�����ڼ���ʱ���� 1���ڵ���ʱ�� 1
        glScalef(axis[0] + 1, axis[1] + 1, axis[2] + 1);
        glMultMatrixf((GLfloat*)objectXform);//��ǰ�������
        glGetFloatv(GL_MODELVIEW_MATRIX, (GLfloat*)objectXform);//���ز�����objectXform������
        glPopMatrix();
    }

    glPushMatrix();
    glMultMatrixf((GLfloat*)objectXform);
    
    setLightRes();
    if (drawLines)
        glutWireTeapot(2.0);
    else
        glutSolidTeapot(2.0);
    glPopMatrix();
    // �ײ�ƽ��ο�
    //glPushMatrix();
    //glTranslatef(0.0, -1.0, 0.0);
    //glScalef(5.0, 0.1, 5.0);
    //glColor3f(0.187, 0.255, 0.255);
    //glutSolidCube(1.2);
    //glPopMatrix();   

    glFlush();
    glutSwapBuffers();

}

void myReshape(int w, int h)
{
    winWidth = w;
    winHeight = h;
    glViewport(0, 0, w, h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    if (w >= h)//ȷ���˵�ϵ��>=1�Ŵ�
        glFrustum(-2.5 * (GLfloat)w / (GLfloat)h, 2.5 * (GLfloat)w / (GLfloat)h, -2.5, 2.5, mynear, myfar);
    else
        glFrustum(-2.5, 2.5, -2.5 * (GLfloat)h / (GLfloat)w, 2.5 * (GLfloat)h / (GLfloat)w, mynear, myfar);
    viewxform_z = -5.0;
    glMatrixMode(GL_MODELVIEW);
}
#define M_PI 3.14159265358979323846 // pi

GLfloat VRightx = (yref - yview) * Vz - (zref - zview) * Vy;
GLfloat VRighty = (zref - zview) * Vx - (xref - xview) * Vz;
GLfloat VRightz = (xref - xview) * Vy - (yref - yview) * Vx;

void userEventAction(int key) {
    switch (key) {
    case '2': // ����ͼ
        xview = 0.0; yview = 0.0; zview = 0.0;
        xref = 0.0; yref = 0.0; zref = -5.0;
        Vx = 0.0; Vy = 1.0; Vz = 0.0;
        break;
    case '4': // ����ͼ
        xview = -5.0; yview = 0.0; zview = -5.0;
        xref = 0.0; yref = 0.0; zref = -5.0;
        Vx = 0.0; Vy = 1.0; Vz = 0.0;
        break;
    case '6': // ����ͼ
        xview = 5.0; yview = 0.0; zview = -5.0;
        xref = 0.0; yref = 0.0; zref = -5.0;
        Vx = 0.0; Vy = 1.0; Vz = 0.0;
        break;
    case '8': // ����ͼ
        xview = 0.0; yview = 0.0; zview = -10.0;
        xref = 0.0; yref = 0.0; zref = -5.0;
        Vx = 0.0; Vy = 1.0; Vz = 0.0;
        break;
    case '5': // ����ͼ
        xview = 0.0; yview = 5.0; zview = -5.0;
        xref = 0.0; yref = 0.0; zref = -5.0;
        Vx = 0.0; Vy = 0.0; Vz = -1.0;
        break;
    case '0': // ����
        angle = 0.0f;
        memset(axis, 0, sizeof(axis));
        memset(objectXform, 0, sizeof(objectXform)); // �任��������
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                if (i == j) {
                    objectXform[i][j] = 1.0f;
                }
            }
        }
        break;
    case 'r': // ��ת
        transModeSelected = Rotate;
        break;
    case 't': // ƽ��
        transModeSelected = Translate;
        break;
    case 's': // ����
        transModeSelected = Scale;
        break;
    case '1': // �߿�ͼ/�����
        drawLines = !drawLines;
        break;
    default:
        break;
    }
    glutPostRedisplay(); // �ػ�

    switch (key){
    case 'w':
        xview += 0.1 * (xref - xview);
        xref += 0.1 * (xref - xview);
        yview += 0.1 * (yref - yview);
        yref += 0.1 * (yref - yview);
        zview += 0.1 * (zref - zview);
        zref += 0.1 * (zref - zview);
        break;
    case 'a':
        VRightx = (yref - yview) * Vz - (zref - zview) * Vy;
        VRighty = (zref - zview) * Vx - (xref - xview) * Vz;
        VRightz = (xref - xview) * Vy - (yref - yview) * Vx;
        xview -= 0.1 * VRightx;
        xref -= 0.1 * VRightx;
        yview -= 0.1 * VRighty;
        yref -= 0.1 * VRighty;
        zview -= 0.1 * VRightz;
        zref -= 0.1 * VRightz;
        break;
    case 'x':
        xview -= 0.1 * (xref - xview);
        xref -= 0.1 * (xref - xview);
        yview -= 0.1 * (yref - yview);
        yref -= 0.1 * (yref - yview);
        zview -= 0.1 * (zref - zview);
        zref -= 0.1 * (zref - zview);
        break;
    case 'd':
        VRightx = (yref - yview) * Vz - (zref - zview) * Vy;
        VRighty = (zref - zview) * Vx - (xref - xview) * Vz;
        VRightz = (xref - xview) * Vy - (yref - yview) * Vx;

        xview += 0.1 * VRightx;
        xref += 0.1 * VRightx;
        yview += 0.1 * VRighty;
        yref += 0.1 * VRighty;
        zview += 0.1 * VRightz;
        zref += 0.1 * VRightz;
        break;
    case 'q':
        yview += 0.1 * 1.0;
        yref += 0.1 * 1.0;
        break;
    case 'e':
        yview -= 0.1 * 1.0;
        yref -= 0.1 * 1.0;
        break;
    case 27: // ESC ����ASCII: 27���˳�
        exit(0);
        break;
    default:
        break;
    }    
    glutPostRedisplay(); // �ػ�
}

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

bool rotateCamera = false;
void mouseButton(int button, int state, int x, int y)
{
    switch (button) {
    case GLUT_LEFT_BUTTON:
        rotateCamera = false;
        break;
    case GLUT_RIGHT_BUTTON:
        rotateCamera = true;
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

void quatRotate( GLfloat theta, GLfloat ux, GLfloat uy, GLfloat uz,GLfloat& px, GLfloat& py, GLfloat& pz);
void mouseMotion(int x, int y)
{
    float dx = x - lastX;
    float dy = y - lastY;
    if (!dx && !dy) return;

    if (rotateCamera) {
    // �Բο���Ϊ���ģ��ƾֲ� X ����ת�����ǣ���ƽ������ Y ����ת���ӣ�
        // ��˾ֲ���������(cross(v,vup))��ת��������� Y ������(0,1,0)��ת
        VRightx = (yref - yview) * Vz - (zref - zview) * Vy;
        VRighty = (zref - zview) * Vx - (xref - xview) * Vz;
        VRightz = (xref - xview) * Vy - (yref - yview) * Vx;
        // ��Ԫ����ת����ת���� dx �� dy ȷ��
        GLfloat thetaX = -dy * (M_PI / winHeight);
        GLfloat thetaY = -dx * (M_PI / winWidth);
        GLfloat px = xref - xview;
        GLfloat py = yref - yview;
        GLfloat pz = zref - zview;
        quatRotate(thetaX, VRightx, VRighty, VRightz, px, py, pz);
        quatRotate(thetaY, 0.0, 1.0, 0.0, px, py, pz);
 
        xref = xview + px;
        yref = yview + py;
        zref = zview + pz;
        // ���� vup ��
        quatRotate(thetaX, VRightx, VRighty, VRightz, Vx, Vy, Vz);
        quatRotate(thetaY, 0.0, 1.0, 0.0, Vx, Vy, Vz);
    }
    else {
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
            axis[2] = 0; 
        }
    }
        lastX = x;
        lastY = y;
        glutPostRedisplay();
}

void quatRotate(
    GLfloat theta, GLfloat ux, GLfloat uy, GLfloat uz,
    GLfloat & px, GLfloat& py, GLfloat& pz)
{
    GLfloat inpx = px;
    GLfloat inpy = py;
    GLfloat inpz = pz;
    px =
        (ux * ux * (1 - cos(theta)) + cos(theta)) * inpx +
        (ux * uy * (1 - cos(theta)) - uz * sin(theta)) * inpy +
        (ux * uz * (1 - cos(theta)) + uy * sin(theta)) * inpz;
    py =
        (uy * ux * (1 - cos(theta)) + uz * sin(theta)) * inpx +
        (uy * uy * (1 - cos(theta)) + cos(theta)) * inpy +
        (uy * uz * (1 - cos(theta)) - ux * sin(theta)) * inpz;
    pz =
        (uz * ux * (1 - cos(theta)) - uy * sin(theta)) * inpx +
        (uz * uy * (1 - cos(theta)) + ux * sin(theta)) * inpy +
        (uz * uz * (1 - cos(theta)) + cos(theta)) * inpz;
}

//�˵�����
struct menuEntryStruct {
    const char* label;
    char key;
};

static menuEntryStruct mainMenu[] = {
"����", '0',
"����ͼ", '2',
"����ͼ", '4',
"����ͼ", '6',
"����ͼ", '8',
"����ͼ", '5',
"��ת",'r',
"ƽ��",'t',
"����",'s',
"�߿�ͼ",'1',
"quit", 27, //ESC ����ASCII: 27��
};

int mainMenuEntries = sizeof(mainMenu) / sizeof(menuEntryStruct);

void selectMain(int choice) // ���->key ӳ�䣬���ò˵�����
{
    userEventAction(mainMenu[choice].key); // ����ͨ�ö������ͺ���
}

void keyboard(unsigned char key, int x, int y)//���ü��̲���
{
    userEventAction(key);
}

void init(void)
{
    glLineWidth(3.0);
    glEnable(GL_DEPTH_TEST); /* Enable hidden--surface--removal */

    // �󶨲˵�
    glutCreateMenu(selectMain); // ʹ�� selectMain ��Ϊ�˵����ú���
    for (int i = 0; i < mainMenuEntries; i++) {
        glutAddMenuEntry(mainMenu[i].label, i);
    }
    glutAttachMenu(GLUT_MIDDLE_BUTTON); // �˵����Ҽ�
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);//����άͼ�Σ�����Ȳ���
    glClearDepth(1.0); // ��1.0��������
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
