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

### Notes:

* If `*.sh` files cannot run, run `chmod 777 your_script_name.sh`.
* If there's `bash: ./script.sh: /bin/bash^M: bad interpreter: No such file or directory` error,
  run `./repair_bash_scripts_on_linux.sh`.
* If the docker building in the very begging is very slow because of context searching, write the huge files and huge
  folders in the [.dockerignore](.dockerignore) file.
* In [docker_run_container_rm.sh](docker_run_container_rm.sh) the container will be automatically removed after
  stopping (it saves memory).
* In [docker_run_container_port.sh](docker_run_container_port.sh) the exposed port is set and the container will be
  automatically restarted after system restarting.
* The desired Base Docker Image for Nvidia GPU and CUDA can be
  founded [here](https://hub.docker.com/r/nvidia/cuda/tags).

### P.S.

If you know some other good solutions, for example with `Docker Compose`, PRs are welcomed.