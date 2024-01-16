from answer import AxisAngle


def main():
    AA = AxisAngle()
    vec = AA.from_rotation_mat([[0.866, -0.5, 0.0],
              [0.5, 0.866, 0.0],
              [0.0, 0.0, 1.0]])
    
    print(vec)
    
    mat = AA.to_rotation_mat(vec)
    print(mat)
    

if __name__=='__main__':
    main()