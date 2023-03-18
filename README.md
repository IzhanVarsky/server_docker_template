# Docker GPU template

This is a template to run your models with Docker on GPU.

### Setting up

1. Write the requirements for the `pip` in [requirements.txt](requirements.txt).
2. Name your docker image in `docker_*.sh` files.
3. Edit the [Dockerfile](Dockerfile) if needed. For example, expose the port or change the `torch` versions or install
   something else.
4. In this Dockerfile you don't need to copy the files to the image using `COPY` command since it is linked with the
   local volume.
5. The commands to run are defined in [entry.sh](entry.sh).
6. Move your project to remote server using `rsync` or anything else.

* For example, I use `rsync -chavzP --stats ./my_files admin@my_host:/my_storage/ --exclude '*venv*'`.

7. Run `./docker_build_image.sh` to build your docker image.
8. After image building run `./docker_run_container_rm.sh` or `./docker_run_container_port.sh` run your container which
   will run your model.

### Notes, bugs, errors...

* If `*.sh` files cannot run, run `chmod 777 your_script_name.sh`.
* If there's `bash: ./script.sh: /bin/bash^M: bad interpreter: No such file or directory` error,
  run `./repair_bash_scripts_on_linux.sh`.
* If the docker building in the very begging is very slow because of context searching, write the huge files and huge
  folders in the [.dockerignore](.dockerignore) file.
* If there's an error with `apt install` while building, and docker suggests to run `apt-get update`, build the docker
  image with `--no-cache` option. (Add this option in [docker_build_image.sh](docker_build_image.sh), note: building
  with `--no-cache` may process very long time and sometimes cause new bugs/issues)
* There were also an error with Nvidia security bug, so if your `RUN apt-get update` fails, you can add:
  ``
  RUN rm /etc/apt/sources.list.d/cuda.list
  RUN apt-key del 7fa2af80
  RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
  ``
  before `RUN apt-get update`.
  !!! UPD: seems to be fixed by Nvidia and there's no need to use this!
* In [docker_run_container_rm.sh](docker_run_container_rm.sh) the container will be automatically removed after
  stopping (it saves memory).
* In [docker_run_container_port.sh](docker_run_container_port.sh) the exposed port is set and the container will be
  automatically restarted after system restarting. This type of running is needed only when you're deploying a server
  which have to "communicate" with the rest world. In this
* The desired Base Docker Image for Nvidia GPU and CUDA can be
  founded [here](https://hub.docker.com/r/nvidia/cuda/tags).

### How to manipulate with Docker

1. To stop docker container, run `docker ps`, which will display current running containers, find the id of your
   container and run `docker stop your_container_id`.
2. To view all create images and their statuses, run `docker images`.
3. To remove the container, run `docker rm your_container_id`.
4. To remove the image, run `docker rmi your_image_id`.
5. Find more info [here](https://docs.docker.com/).

### P.S.

* If you faced some errors/bugs, ask about it in issues section.
* If you know some other good solutions, for example with `Docker Compose`, PRs are welcomed.
