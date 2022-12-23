# Dockerize a Jupyter Notebook File(Windows)

### Notebook Used:
#### Emotion Classification in Short Messages

Multi-class sentiment analysis problem to classify texts into five emotion categories: joy, sadness, anger, fear, neutral by using transfer learning using BERT (tensorflow keras).

Usage:


![image](https://user-images.githubusercontent.com/34805810/209344802-70c30b15-7f0e-4bbd-9dfe-e81ffdaa9590.png)


## Run the Notebook Locally

Make sure the code can run normally in local environment.
Take notes on the libraries it uses, for my case：*pandas*, *numpy*, "ktrain* which uses keras 

![image](https://user-images.githubusercontent.com/34805810/209344421-700b5010-5c92-4a6d-a82f-2d13ee5c7876.png)

## Download Docker

[Install Docker Desktop](https://docs.docker.com/desktop/install/windows-install/)


![image](https://user-images.githubusercontent.com/34805810/209345121-398af71f-6d81-442c-9c39-115c821c9934.png)

## Verify Installation

```
$ docker version
```

![image](https://user-images.githubusercontent.com/34805810/209346454-51a04082-64b2-44c0-a83c-dce0203a32f6.png)


It should display something like this👆

## Decide Base Image

There are several jupyter-notebook-related base images. 
Since our notebook uses *pandas*, *numpy*, "ktrain*(uses keras which runs on top of tensorflow),
*tensorflow-notebook* will be our choice, since it includes everything in jupyter/scipy-notebook(which has *pandas*, *numpy* included).


![image](https://user-images.githubusercontent.com/34805810/209347176-bcae691c-d366-40f4-afea-bfb7553a117e.png)

## Create an empty requirements.txt File (update later)

```
$ touch requirements.txt
```

## Writing Dockerfile

In the same folder of our notebook, we create our Dockerfile

```
FROM jupyter/tensorflow-notebook
COPY requirements.txt ./requirements.txt
COPY bert.ipynb ./bert.ipynb
COPY data ./data
COPY bert_model ./bert_model
RUN pip install -r requirements.txt
```

which uses the base image, and copies all files into our container


## Build the Dockerfile

```
$ docker build -t textemotionotebook .
```

## Make Sure Image is Created

```
$ docker images
```
![image](https://user-images.githubusercontent.com/34805810/209349393-34fe95ee-3ed2-4404-936f-a1e39da91e94.png)


## Run the Image

```
$ docker run -it -p 8888:8888 textemotionotebook
```
![image](https://user-images.githubusercontent.com/34805810/209349611-7e57e403-6c0a-4764-a4d0-0fc54dd9f1db.png)


Use the last link, e.g. http://127.0.0.1:8888/lab?token=...


![image](https://user-images.githubusercontent.com/34805810/209349859-ba68532d-3641-4c16-9848-6f7a30ce5573.png)

## Notebook Opened in Docker

image here

## Run the notebook

There should be warning suggesting the missing library: *ktrain*

## Update the Requirements File to Include the Package Needed

After rebuilding the docker and rerunning the image, the notebook can be run successfully

image here

## Push to DockerHub

First find the image ID by running ``` docker images ```

![image](https://user-images.githubusercontent.com/34805810/209350876-1f78baeb-fe00-4162-905c-c495f8d6b7ae.png)

## Tag the Image

```
$ docker tag d3e2d3a63640 astolo/textemotionotebook:first
```

## Push the Image

```
$ docker push astolo/textemotionotebook:first
```


[DockerHub](https://hub.docker.com/repository/docker/astolo/textemotionotebook)

Should be able to see the image in *My Profile*


![image](https://user-images.githubusercontent.com/34805810/209345543-095f8423-533a-4d21-b6e6-d13526be69d6.png)

## Pull the Image From Docker Hub

```
$ docker pull astolo/textemotionotebook:first
```

## Run the Image

```
$ docker run -it -p 8888:8888 astolo/textemotionotebook:first
```

Use the bottom link, you should see the notebook and run it successfully.

[Docker Stacks](http://www.affective-sciences.org/index.php/download_file/view/395/296/)




