% Created by Huang Lu, Department of Electronic Engineering, Tsinghua University
% 2015/10/30, Friday, Beijing
% Code for Homework 3 of Communication and Network

clear all;  close all; clc;
x0 = rand(1,1000);
x0(x0<0.8) = 0;
x0(x0>=0.8) = 1;
y = sum(x0)
