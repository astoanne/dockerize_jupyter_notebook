FROM jupyter/tensorflow-notebook
COPY requirements.txt ./requirements.txt
COPY bert.ipynb ./bert.ipynb
COPY data ./data
COPY bert_model ./bert_model
RUN pip install -r requirements.txt
