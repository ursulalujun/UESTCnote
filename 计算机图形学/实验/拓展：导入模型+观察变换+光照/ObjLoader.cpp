#include "ObjLoader.h"
using namespace std;

ObjLoader::ObjLoader(string filename)
{
    string line;
    fstream f;
    f.open(filename, ios::in);
    if (!f.is_open()) {
        cout << "Something Went Wrong When Opening Objfiles" << endl;
    }

    while (!f.eof()) {
        getline(f, line);//�õ�obj�ļ���һ�У���Ϊһ���ַ���
        vector<string>parameters;
        string tailMark = " ";
        string ans = "";

        line = line.append(tailMark);
        for (int i = 0; i < line.length(); i++) {
            char ch = line[i];
            if (ch != ' ') {
                ans += ch;
            }
            else {
                parameters.push_back(ans); //ȡ���ַ����е�Ԫ�أ��Կո��з�
                ans = "";
            }
        }
        //cout << parameters.size() << endl;
        if (parameters.size() != 4 && parameters.size() != 5) {
            cout << "the size is not correct" << endl;
        }
        else {
            if (parameters[0] == "v") {   //����Ƕ���Ļ�
                vector<GLfloat>Point;
                for (int i = 1; i < 4; i++) {   //��1��ʼ���������xyz����������붥��vector
                    GLfloat xyz = atof(parameters[i].c_str());
                    Point.push_back(xyz);
                }
                vSets.push_back(Point);
            }

            else if (parameters[0] == "f") {   //�������Ļ�������������������
                vector<GLint>vIndexSets;
                if (parameters.size() == 5)
                {
                    for (int i = 1; i <= 4; i++) {
                        string x = parameters[i];
                        string ans = "";
                        for (int j = 0; j < x.length(); j++) {   //������/��
                            char ch = x[j];
                            if (ch != '/') {
                                ans += ch;
                            }
                            else {
                                break;
                            }
                        }
                        GLint index = atof(ans.c_str());
                        index = index--;//��Ϊ����������obj�ļ����Ǵ�1��ʼ�ģ������Ǵ�ŵĶ���vector�Ǵ�0��ʼ�ģ����Ҫ��1
                        vIndexSets.push_back(index);
                    }
                    fSets.push_back(vIndexSets);
                }
                else
                {
                    for (int i = 1; i < 4; i++) {
                        string x = parameters[i];
                        string ans = "";
                        for (int j = 0; j < x.length(); j++) {   //������/��
                            char ch = x[j];
                            if (ch != '/') {
                                ans += ch;
                            }
                            else {
                                break;
                            }
                        }
                        GLint index = atof(ans.c_str());
                        index = index--;//��Ϊ����������obj�ļ����Ǵ�1��ʼ�ģ������Ǵ�ŵĶ���vector�Ǵ�0��ʼ�ģ����Ҫ��1
                        vIndexSets.push_back(index);
                    }
                    fSets.push_back(vIndexSets);                      
                }
            }
        }
    }
    f.close();
}

void ObjLoader::Draw() {
    for (int i = 0; i < fSets.size(); i++) {
        GLfloat VN[3];
        //��������
        GLfloat SV1[4];
        GLfloat SV2[4];
        GLfloat SV3[4];
        GLfloat SV4[4];

        if ((fSets[i]).size() != 4&& (fSets[i]).size() != 3) {
            cout << "the fSetsets_Size is not correct" << endl;
        }
        else {
            if ((fSets[i]).size() == 3)
            {
                glBegin(GL_TRIANGLES);//��ʼ����������
                glColor3f(0.255, 0.215, 0);
                GLint firstVertexIndex = (fSets[i])[0];//ȡ����������
                GLint secondVertexIndex = (fSets[i])[1];
                GLint thirdVertexIndex = (fSets[i])[2];

                SV1[0] = (vSets[firstVertexIndex])[0];//��һ������
                SV1[1] = (vSets[firstVertexIndex])[1];
                SV1[2] = (vSets[firstVertexIndex])[2];

                SV2[0] = (vSets[secondVertexIndex])[0]; //�ڶ�������
                SV2[1] = (vSets[secondVertexIndex])[1];
                SV2[2] = (vSets[secondVertexIndex])[2];

                SV3[0] = (vSets[thirdVertexIndex])[0]; //����������
                SV3[1] = (vSets[thirdVertexIndex])[1];
                SV3[2] = (vSets[thirdVertexIndex])[2];


                GLfloat vec1[3], vec2[3], vec3[3];//���㷨����
                //(x2-x1,y2-y1,z2-z1)
                vec1[0] = SV1[0] - SV2[0];
                vec1[1] = SV1[1] - SV2[1];
                vec1[2] = SV1[2] - SV2[2];

                //(x3-x2,y3-y2,z3-z2)
                vec2[0] = SV1[0] - SV3[0];
                vec2[1] = SV1[1] - SV3[1];
                vec2[2] = SV1[2] - SV3[2];

                //(x3-x1,y3-y1,z3-z1)
                vec3[0] = vec1[1] * vec2[2] - vec1[2] * vec2[1];
                vec3[1] = vec2[0] * vec1[2] - vec2[2] * vec1[0];
                vec3[2] = vec2[1] * vec1[0] - vec2[0] * vec1[1];

                GLfloat D = sqrt(pow(vec3[0], 2) + pow(vec3[1], 2) + pow(vec3[2], 2));

                VN[0] = vec3[0] / D;
                VN[1] = vec3[1] / D;
                VN[2] = vec3[2] / D;

                glNormal3f(VN[0], VN[1], VN[2]);//���Ʒ�����
                glVertex3f(SV1[0], SV1[1], SV1[2]);//����������Ƭ
                glVertex3f(SV2[0], SV2[1], SV2[2]);
                glVertex3f(SV3[0], SV3[1], SV3[2]);
                glEnd();
            }
            else
            {
               
                glBegin(GL_POLYGON);
                glColor3f(0.5, 0.5, 0);
                GLint firstVertexIndex = (fSets[i])[0];//ȡ����������
                GLint secondVertexIndex = (fSets[i])[1];
                GLint thirdVertexIndex = (fSets[i])[2];
                GLint fourthVertexIndex = (fSets[i])[3];

                SV1[0] = (vSets[firstVertexIndex])[0];//��һ������
                SV1[1] = (vSets[firstVertexIndex])[1];
                SV1[2] = (vSets[firstVertexIndex])[2];

                SV2[0] = (vSets[secondVertexIndex])[0]; //�ڶ�������
                SV2[1] = (vSets[secondVertexIndex])[1];
                SV2[2] = (vSets[secondVertexIndex])[2];

                SV3[0] = (vSets[thirdVertexIndex])[0]; //����������
                SV3[1] = (vSets[thirdVertexIndex])[1];
                SV3[2] = (vSets[thirdVertexIndex])[2];
                
                SV4[0] = (vSets[fourthVertexIndex])[0]; //���ĸ�����
                SV4[1] = (vSets[fourthVertexIndex])[1];
                SV4[2] = (vSets[fourthVertexIndex])[2];

                glVertex3f(SV1[0], SV1[1], SV1[2]);//�����ı�����Ƭ
                glVertex3f(SV2[0], SV2[1], SV2[2]);
                glVertex3f(SV3[0], SV3[1], SV3[2]);
                glVertex3f(SV4[0], SV4[1], SV4[2]);
                glEnd();
            }
        }

    }
    
}