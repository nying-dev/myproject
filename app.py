from flask import Flask, render_template, request, redirect, url_for, jsonify
from pandas.io import json
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import sigmoid_kernel
import numpy as np
import pandas as pd

app = Flask(__name__)

Policarpio_Store_Data=pd.read_csv('Policarpio_Store.csv')
Policarpio_Store_Clean=Policarpio_Store_Data.drop(columns=['Unit Price','Stock Quantity','Inventory Value',"Photo's Link"])

tfv = TfidfVectorizer(min_df=3,max_features=None,
                      strip_accents='unicode',analyzer='word',token_pattern=r'\w{1,}',
                      ngram_range=(1,3),
                      stop_words='english')

Policarpio_Store_Clean['Ingredients'] = Policarpio_Store_Clean['Ingredients'].fillna('')

tfv_policarpio  = tfv.fit_transform(Policarpio_Store_Clean['Ingredients'])
sig=sigmoid_kernel(tfv_policarpio,tfv_policarpio)

@app.route("/recomm",methods=['GET','POST'])
def recommend_recipe():
    if request.method =='POST':
        try:
            details=request.form
            title = details['title']
            idx = indices[title]
            sig_scores = sorted(sig_scores,key=lambda x:x[1],reverse=True)
            sig_scores = sig_scores[1:200]
            movies_indices =[i[0] for i in sig_scores]
            g = pd.DataFrame(df)
        except:
            return json.dumps([{"responce":"Item is not found in list"}],sort_keys=true,indent=4)
