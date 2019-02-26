clear all

x=ncread('C:\Users\wonchang.FRN5516-MKC2\Documents\StormSurge\LHS2_A_0001_001_maxele.63.nc','x');
y=ncread('C:\Users\wonchang.FRN5516-MKC2\Documents\StormSurge\LHS2_A_0001_001_maxele.63.nc','y');

fileID = fopen('stationListV1','r');
formatSpec = '%f';
sizeA = [2 Inf];
station_locations=round(fscanf(fileID,formatSpec,sizeA),4);

location_extract=[];
for i=1:1271
    [minval,whichmin]=min(deg2km(distance(station_locations(2,i),station_locations(1,i),y,x)));
    location_extract(i)=whichmin;
end

x_subset=x(location_extract);
y_subset=y(location_extract);

name_par_table=readtable('LHS2_A_par.csv');

zeta_max=zeros([3156,size(x,1)]);
zeta_max_subset=zeros([3156,1271]);
for i=1:3156
filename=strcat(name_par_table{i,1},'_maxele.63.nc');
temp=ncread(filename{1},'zeta_max');
zeta_max(i,:)=temp;
zeta_max_subset(i,:)=temp(location_extract);
end

save('zeta_max_subset.mat','x_subset','y_subset','zeta_max_subset','station_locations','name_par_table')

save('zeta_max.mat','x','y','zeta_max','name_par_table','-v7.3')

