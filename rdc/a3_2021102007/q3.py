#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Oct 27 15:56:40 2023

@author: sreeja
"""

import numpy as np
import sympy as sp

L1 = 1
L2 = 1
L3 = 1
t = sp.Symbol('t')

def DH_matrices(parameters):
    a = np.array(parameters[:,0])
    alpha = np.array(parameters[:,1])
    d = np.array(parameters[:,2])
    theta = np.array(parameters[:,3])
    
    T = np.empty((parameters.shape[0], 4, 4))
    for i in range(parameters.shape[0]):
        T[i] = np.array([[np.cos(theta[i]), -np.sin(theta[i]), 0, a[i]],
                         [np.sin(theta[i]) * np.cos(alpha[i]), np.cos(theta[i]) * np.cos(alpha[i]), -np.sin(alpha[i]), -d[i] * np.sin(alpha[i])],
                         [np.sin(theta[i]) * np.sin(alpha[i]), np.cos(theta[i]) * np.sin(alpha[i]), np.cos(alpha[i]), d[i] * np.cos(alpha[i])],
                         [0, 0, 0, 1]])

    return T

def forward_kinematics(joint_angles):
    parameters = np.array([[0,-np.pi/2,0,joint_angles[0]],
                           [2,0,2,joint_angles[1]],
                           [1,np.pi/2,1,joint_angles[2]]])
    T = DH_matrices(parameters)
    ee_pose = np.matmul(T[0],T[1])
    ee_pose = np.matmul(ee_pose,T[2])
    return [T,ee_pose]

def velocity_kinematics(parameters,joints):
    T = DH_matrices(parameters)
    
    R = np.empty((parameters.shape[0], 3, 3))
    for i in range(parameters.shape[0]):
        R[i] = T[i][:3,:3]
        
    P = np.empty((parameters.shape[0], 3, 1))
    for i in range(parameters.shape[0]):
        P[i] = T[i][:3,3].reshape((3,1))
       
    v = np.empty((parameters.shape[0] + 1, 3, 1))
    w = np.empty((parameters.shape[0] + 1, 3, 1))
    v[0][:,0] = 0  
    w[0][:,0] = 0
    
    k = np.empty((3,1))
    k[0] = 0
    k[1] = 0
    k[2] = 1
    
    deriv = np.empty(len(joints))
    for i in range(len(joints)):
        deriv[i] = sp.diff(joints[i],t).subs(t, 1)
        
        
    for i in range(parameters.shape[0]):
        w[i + 1] = np.matmul(np.transpose(R[i]),w[i])
        w[i + 1] += (deriv[i]*k)
        
    d = np.array(parameters[:,2])
    for i in range(parameters.shape[0]):
        v[i + 1] = np.cross(P[i].flatten(),w[i].flatten()).reshape((3,1))
        v[i + 1] += v[i]
        v[i + 1] = np.matmul(np.transpose(R[i]),v[i+1])
        v[i + 1] += (d[i]*k)
        
    return [v[1:],w[1:]]

def Jacobian_matrix(joint_angles,parameters):
    #velocity Jacobian
    Jv = np.array([[-((L2*np.cos(joint_angles[1]) + L3*np.cos(joint_angles[1] + joint_angles[2]))*np.sin(joint_angles[0])) , -((L2*np.sin(joint_angles[1]) + L3*np.sin(joint_angles[1] + joint_angles[2]))*np.cos(joint_angles[0])) , L3*np.sin(joint_angles[1] + joint_angles[2])*np.cos(joint_angles[0])],
                   [(L2*np.cos(joint_angles[1]) + L3*np.cos(joint_angles[1] + joint_angles[2]))*np.cos(joint_angles[0]) ,  -((L2*np.sin(joint_angles[1]) + L3*np.sin(joint_angles[1] + joint_angles[2]))*np.sin(joint_angles[0]))  , L3*np.cos(joint_angles[1] + joint_angles[2])*np.sin(joint_angles[0])],
                   [0, L2*np.cos(joint_angles[0]) + L3*np.cos(joint_angles[1] + joint_angles[2]) , L3*np.cos(joint_angles[1] + joint_angles[2])]
                   ])
    
    #angular velocity Jacobian
    k = np.empty((3,1))
    k[0] = 0
    k[1] = 0
    k[2] = 1
    
    T = DH_matrices(parameters)
    R = np.empty((parameters.shape[0], 3, 3))
    for i in range(parameters.shape[0]):
        R[i] = T[i][:3,:3]
    
    R01 = R[0]
    R02 = np.matmul(R01,R[1])
    R03 = np.matmul(R02,R[2])
    
    Z01 = np.matmul(R01,k).reshape((1,3))
    Z02 = np.matmul(R02,k).reshape((1,3))
    Z03 = np.matmul(R03,k).reshape((1,3))
    
    Jw = np.stack([Z01,Z02,Z03],axis = -1).reshape((3,3))
    
    j_full = np.stack([Jv,Jw])
    return [Jv, Jw, j_full]
    
       
        
    

joints = [t,t**2,t**3,0]
joint_angles = [0,0,0]
parameters = np.array([[0,-np.pi/2,0,joint_angles[0]],
                       [2,0,2,joint_angles[1]],
                       [1,np.pi/2,1,joint_angles[2]]])
[v,w] = velocity_kinematics(parameters,joints)
[Jv, Jw, j_full] = Jacobian_matrix(joint_angles, parameters)
print(v)
print("\n")
print(w)
