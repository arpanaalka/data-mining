"""Problem to predict user Response for customer data of auto-insurance company"""

#import requried packages
import pandas as pd
import numpy as np
import random
from sklearn import metrics
from scipy import stats
import matplotlib.pyplot as plt
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.neighbors import NearestNeighbors as kn


def populate(N,i,knn_narray,DataSmoteMSample) :
	sample = DataSmoteMSample
	k=5
	newindex=0
	
	numattrs = len(sample.columns)
	sample = DataSmoteMSample.as_matrix(columns=None)
	
	synthetic = np.empty_like(sample)
	while N != 0 :
		nn = random.randint(0,k-1)
		
		point=knn_narray[i][nn]
		
		for attr in range(numattrs) :
			
			diff = sample[point][attr] - sample[i][attr]
			gap = random.random()
			
			synthetic[newindex][attr] = sample[i][attr] + gap*diff
		newindex = newindex + 1
		N=N-1
	#population =  np.concatenate((sample,synthetic))
	return synthetic
#############
def knn(DataSmoteMSample,k) :
	nbrs = kn(n_neighbors = k,algorithm='ball_tree').fit(DataSmoteMSample)
	distance, indices = nbrs.kneighbors(DataSmoteMSample)
	return indices
########################
def SMOTE(T,N,k,DataSmoteMSample) :
	if N <100 :
		T=(N/100)*T
		N=100
	N=np.int(N/100)	
	#sample = minority cls sample
	newindex = 0
	print T,"t"
	synthetic1 = np.empty_like(DataSmoteMSample)
	#synthetic sample array initialization
	for i in range(1,T) :
		knn_narray = knn(DataSmoteMSample,k)
		synthetic = populate(N,i,knn_narray,DataSmoteMSample)
		population =  np.concatenate((synthetic1,synthetic))
	return population
############################################
#loading data


Data=pd.read_csv("dataset.csv")

#print Data.head(2)
#setting ID, target , catogorical ,numerical and all col
#print Data.tail(2)



ID_col=["Customer"]
target_col=["Response"]
cat_cols=['Coverage', 'Education', 'Effective To Date', 'EmploymentStatus', 'Gender',  'Location Code', 'Marital Status', 'Monthly Premium Auto', 'Policy','Policy Type', 'Renew Offer Type', 'Response', 'Sales Channel','State', 'Vehicle Class','Vehicle Size']

num_cols= list(set(list(Data.columns))-set(cat_cols)-set(ID_col)-set(target_col))
smote_cols= list(set(cat_cols)-set(target_col))
num_cat_cols = num_cols+cat_cols
Data = Data.drop(Data.index[[8293]])
#handling missing values

for var in num_cat_cols:
    if Data[var].isnull().any()==True:			

#Create a new variable for each variable having missing value with VariableName_NA
        Data[var+'_NA']=Data[var].isnull()*1    	

#Impute numerical missing values with mean
Data[num_cols] = Data[num_cols].fillna(Data[num_cols].mean(),inplace=True)
#Impute categorical missing values with -9999
Data[cat_cols] = Data[cat_cols].fillna(value = -9999)
#print Data.head(2)
#print Data.tail(2)
#create label encoders for categorical features
for var in cat_cols:
	number = LabelEncoder()
	Data[var] = number.fit_transform(Data[var].astype('str'))
#Target variable is also a categorical so convert it
Data["Response"] = number.fit_transform(Data["Response"].astype('str'))


########################################### SSSSSSSSSSSSOMTEEEEEEEEEEEEEE ####################################################################

DataSmote= pd.DataFrame()

all_cols = num_cols+ cat_cols + target_col
for var in all_cols :
	DataSmote[var] = Data[var]

unbal=[]
unbal1=[]


#finding unbal col
for col in target_col :
	#if col == 'Coverage' : continue
	#item_frq=stats.itemfreq(DataSmote[col])
	item_freq = DataSmote[col].value_counts().to_dict()
	#rint item_freq
	item_value= item_freq.values()
	min_item=min(item_value)
	max_item=max(item_value)
	l=len(item_freq)
	denom = max_item + min_item
	
	if (min_item*100/8293 < 40 and l<6) :
		#print min_item*100/denom
		#DataSmote[col+'_unbal']=DataSmote[col]
		unbal1.append(col)

col_list=cat_cols

"""for var in unbal :
	item_freq = DataSmote[var].value_counts().to_dict()
	print "var",item_freq 
for var in unbal1 :
	item_freq = DataSmote[var].value_counts().to_dict()
	print "var",item_freq 
"""
for var in unbal1 :
	item_freq = DataSmote[var].value_counts().to_dict()
	print item_freq
	item_value= item_freq.values()
	print item_value
	print min(item_value)
	min_item = min(item_value)
	item_key= min(item_freq, key=item_freq.get)
	print "item_key",item_key
	
	DataSmoteMSample = DataSmote[DataSmote[var]==item_key]
	population = SMOTE(min_item ,300 , 5,DataSmoteMSample)
	print len(population)
	all_cols=list(set(all_cols)- set(ID_col))
	sample_as_df = pd.DataFrame(population,columns = all_cols)
	#syntheticSample = pd.DataFrame(synthetic,columns = all_cols)
	syntheticSample = pd.DataFrame(population,columns = all_cols)
	frames = [DataSmoteMSample,syntheticSample]
	
	

DataNew=Data[all_cols]
initial_data=Data
DataTree=pd.concat([DataNew,sample_as_df])


#######################tree on mod data
DataTree['is_train'] = np.random.uniform(0, 1, len(DataTree)) <= .75
Train, Test = DataTree[DataTree['is_train']==True], DataTree[DataTree['is_train']==False]
Data['is_train'] = np.random.uniform(0, 1, len(Data)) <= .75
Train1, Test1 = Data[Data['is_train']==True], Data[Data['is_train']==False]
other=['is_train']
TrainNew=Train[all_cols]
TrainNew=pd.concat([TrainNew,sample_as_df])
features=list(set(list(Data.columns))-set(ID_col)-set(target_col)-set(other))

x_train = TrainNew[features].values
y_train = TrainNew["Response"].values
x_test = Test[list(features)].values
y_Test = Test["Response"].values
x_test1=Test1[list(features)].values
y_test1=Test1["Response"].values
#training random forest

rf = RandomForestClassifier(n_estimators=50,max_depth=12) 
rf.fit(x_train, y_train)

train_pred=rf.predict_proba(x_train)[:,1]

TrainNew["predResponse"]=train_pred
l=len(train_pred)
temp=np.ones(l)

#sampling prediction output to 0-no and 1-yes
for i in range(0,l) :
	if train_pred[i] <=.5:
		temp[i]=0
TrainNew["intResponse"]=temp

pred=temp
given=TrainNew["Response"]
y=pred-given
z=np.count_nonzero(y)
#print "z=",z,"len:",len(y)
#print "prediction is:",(len(y)-z)*100/len(y),"%"
#testing model

final_output = rf.predict_proba(x_test1)[:,1]
l=len(final_output)
temp=np.ones(l)
Test1["prediction"]=final_output
#sampling prediction output to 0-no and 1-yes
for i in range(0,l) :
	if final_output[i] <=.4:
		temp[i]=0
Test1["intResponse"]=temp
Test1["givenResponse"]=Test1["Response"]

#plotting
pred=temp
given=Test1["Response"]
y=pred-given
z=np.count_nonzero(y)
print "z=",z,"len:",len(y)
print "correct prediction is:",(len(y)-z)*100/len(y),"%"
x=np.linspace(0,l,num=l)
plt.plot(x,y,'x')
plt.ylim([-1.5,1.5])
plt.title("plot for correct and wrong prediction")
plt.show()

#writing to a file here Response= yes equivalent to 1 and no to 0

Test1.to_csv('Round31_out.csv',columns=['Customer','prediction','intResponse','givenResponse'])
DataTree.to_csv('R.csv',columns=all_cols)




