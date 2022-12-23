# Dockerize a Jupyter Notebook File(Windows)

### Notebook Used:
#### Emotion Classification in Short Messages

Multi-class sentiment analysis problem to classify texts into five emotion categories: joy, sadness, anger, fear, neutral by using transfer learning using BERT (tensorflow keras).

Usage:


![image](https://user-images.githubusercontent.com/34805810/209344802-70c30b15-7f0e-4bbd-9dfe-e81ffdaa9590.png)


## Run the Notebook Locally

Make sure the code can run normally in local environment.
Take notes on the libraries it uses, for my case：**pandas**, **numpy**, **ktrain** which uses **keras** 

![image](https://user-images.githubusercontent.com/34805810/209344421-700b5010-5c92-4a6d-a82f-2d13ee5c7876.png)

## Download Docker

[Install Docker Desktop](https://docs.docker.com/desktop/install/windows-install/)


![image](https://user-images.githubusercontent.com/34805810/209345121-398af71f-6d81-442c-9c39-115c821c9934.png)

## Verify Installation

```
$ docker version
```

![image](https://user-images.githubusercontent.com/34805810/209346454-51a04082-64b2-44c0-a83c-dce0203a32f6.png)


## Decide Base Image

There are several jupyter-notebook-related base images. 
Since our notebook uses **pandas**, **numpy**, **ktrain**(uses **keras** which runs on top of **tensorflow**),
**tensorflow-notebook** will be our choice, since it includes everything in **jupyter/scipy-notebook**(which has **pandas**, **numpy** included).


![image](https://user-images.githubusercontent.com/34805810/209347176-bcae691c-d366-40f4-afea-bfb7553a117e.png)


[Docker Stacks](http://www.affective-sciences.org/index.php/download_file/view/395/296/)


## Create an Empty requirements.txt File (update later)

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

![image](https://user-images.githubusercontent.com/34805810/209350876-1f78baeb-fe00-4162-905c-c495f8d6b7ae.png)


## Run the Image

```
$ docker run -it -p 8888:8888 textemotionotebook
```
![image](https://user-images.githubusercontent.com/34805810/209349611-7e57e403-6c0a-4764-a4d0-0fc54dd9f1db.png)


Use the last link, e.g. http://127.0.0.1:8888/lab?token=...


![image](https://user-images.githubusercontent.com/34805810/209349859-ba68532d-3641-4c16-9848-6f7a30ce5573.png)

## Notebook Opened in Docker

![image](https://user-images.githubusercontent.com/34805810/209393808-a5979705-5465-4f2c-a0ec-8de6991934e0.png)

## Run the notebook

There should be warning suggesting the missing library: **ktrain**

## Update the Requirements File

Update requirements.txt to include the the required library
```
ktrain
```
After rebuilding the docker and rerunning the image, the notebook can be run successfully

![image](https://user-images.githubusercontent.com/34805810/209394073-31d45d8c-b185-4972-be09-01118c691c21.png)


![image](https://user-images.githubusercontent.com/34805810/209393944-0047b046-a036-4056-a637-ab7169c736fb.png)


## Getting Image ID

First find the image ID by running ``` docker images ```

![image](https://user-images.githubusercontent.com/34805810/209350876-1f78baeb-fe00-4162-905c-c495f8d6b7ae.png)

## Tag the Image

```
$ docker tag d3e2d3a63640 astolo/textemotionotebook:first
```

## Push the Image to DockerHub

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

Use the bottom link, the notebook should run successfully.


# To Verify My Assignment

```
$ docker pull astolo/textemotionotebook:first
$ docker run -it -p 8888:8888 astolo/textemotionotebook:first
```
Use the bottom link, http://127.0.0.1:8888/lab?token=...

If you are not ready to wait for 10 hours to retrain the model, start from tag "RUN FROM HERE" in the notebook

# Other Works I Did

I first used an audio-related notebook, which improvises a pieze of jazz music. Later I found out that it was not trivial to play audio inside docker after going through a large number of tutorials trying to find a way to listen to my generated midi music file inside docker. 

I also tried to shrink the size of my image by using more than one dockerfile and seperating the build and package stage, or using docker-compose but soon made the file looks pretty ugly and unreadable, which I believe was not the intension of this assignment: to dockerize a simple application. Plus most tutorials focus on nodejs or c or java based projects which are more natural to break down into stages compared to jupyter-notebook projects. 

## Side Notes
If you are to ```git clone``` this repo, the notebook has to run from the top. Because there is a size limitation for github, I was unable to upload the ```.h5``` file of the pretrained model, but if you
```
$ docker pull astolo/textemotionotebook:first
$ docker run -it -p 8888:8888 astolo/textemotionotebook:first
```
there should not be a problem running from the tag "RUN FROM HERE".
