close all
clear all
clc
% PW represents the weight of individual patient
% PD represents the dose given to the individual patient
 [filename,pathname]=uigetfile({'*.jpg;*.tif;*.png;*.gif','all image file'},'image'); %input fused PET-CT image
a=imread([pathname filename]);
figure
PW=input('Enter patient weight : ');
PD=input('Enter the Dose : ');

f=imshow(a);
 
e = imellipse(gca,[]);% create ellipsical shape to crop as desired ROI
wait(e);
bw1= createMask(e,f);
bw=uint8(bw1);
a=uint8(a);
 
%result= a.*cat(3, bw, bw, bw);
result=a.*repmat(bw,[1,1,3]);
imshow(result)
 
result1=(result(:));
result1=result1(result1~=0);
SUV=immultiply(result1,PW/(1000*PD));
 
Mean_SUV=mean(SUV)
x= Mean_SUV;
 Calculated_SUV=-.2510*x^6 +11.4882*x^5 -67.705*x^4 +163.4672*x^3 -189.5899*x^2 +105.3830*x-21.46 % The given polynomial equation is our investigated SUV based on pixelwise information from fused PET-CT images