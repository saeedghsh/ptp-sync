SHELL := /bin/bash

.PHONY: clean
clean:
	@echo "***** rm *~"
	@find . -name '*~'    -exec rm -f {} +

# build docker image from dockerfile
.PHONY: build-master
build-master:
	sudo docker image build --tag ptpmasterclock:deamon --file Dockerfile.master .

# # run docker container from the image and (attach -it: interactive + tty)
# # or, run docker container from the image detached and then attach
# sudo docker container run --detach --name masterclock ptpmasterclock:deamon
# sudo docker attach masterclock
.PHONY: run-master
run-master:
	sudo docker container run -it --name masterclock ptpmasterclock:deamon

# kill running container; and remove container and image
.PHONY: kill-rm-master
kill-rm-master:
	-sudo docker kill masterclock
	-sudo docker container rm --force masterclock
	sudo docker image rm --force ptpmasterclock:deamon


# sudo docker start masterclock -i -a
# sudo docker exec -it
# sudo docker stop
# sudo docker image list
# sudo docker container list
