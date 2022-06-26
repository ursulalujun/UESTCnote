#include<GL/glut.h>


// Initialize material property, light source, lighting model, * and depth buffer.

void init(void)

{

    GLfloat mat_specular[] = { 1.0, 1.0, 1.0, 1.0 };

    GLfloat mat_shininess[] = { 50.0 };

    GLfloat light_position[] = { 1.0, 1.0, 1.0, 0.0 };

    GLfloat white_light[] = { 1.0, 1.0, 1.0, 1.0 };

    GLfloat Light_Model_Ambient[] = { 0.2 , 0.2 , 0.2 , 1.0 }; //

    glClearColor(0.0, 0.0, 0.0, 0.0);

    glShadeModel(GL_SMOOTH);

    glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);

    glMaterialfv(GL_FRONT, GL_SHININESS, mat_shininess);

    glLightfv(GL_LIGHT0, GL_POSITION, light_position);

    glLightfv(GL_LIGHT0, GL_DIFFUSE, white_light);

    glLightfv(GL_LIGHT0, GL_SPECULAR, white_light);

    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, Light_Model_Ambient); //

    glEnable(GL_LIGHTING);

    glEnable(GL_LIGHT0);

    glEnable(GL_DEPTH_TEST);

}

void display(void)

{

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    //glutSolidSphere (1.0, 20, 16);

    glutSolidTeapot(0.5);

    glFlush();

}

void reshape(int w, int h)

{

    glViewport(0, 0, (GLsizei)w, (GLsizei)h);

    glMatrixMode(GL_PROJECTION);

    glLoadIdentity();

    if (w <= h)

        glOrtho(-1.5, 1.5, -1.5 * (GLfloat)h / (GLfloat)w,

            1.5 * (GLfloat)h / (GLfloat)w, -10.0, 10.0);

    else

        glOrtho(-1.5 * (GLfloat)w / (GLfloat)h,

            1.5 * (GLfloat)w / (GLfloat)h, -1.5, 1.5, -10.0, 10.0);

    glMatrixMode(GL_MODELVIEW);

    glLoadIdentity();

}

int main(int argc, char** argv)

{

    glutInit(&argc, argv);

    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB | GLUT_DEPTH);

    glutInitWindowSize(500, 500);

    glutInitWindowPosition(100, 100);

    glutCreateWindow(argv[0]);

    init();

    glutDisplayFunc(display);

    glutReshapeFunc(reshape);

    glutMainLoop();

    return 0;

}