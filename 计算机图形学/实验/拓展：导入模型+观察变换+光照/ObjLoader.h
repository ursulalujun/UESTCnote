
#include <fstream>
#include <iostream>
#include <vector>
#include <string>
#include <GL/glut.h>
using namespace std;
class ObjLoader {
public:
    ObjLoader(string filename);//���캯��
    void Draw();//���ƺ���
private:
    vector<vector<GLfloat>>vSets;//��Ŷ���(x,y,z)����
    vector<vector<GLint>>fSets;//������������������
};