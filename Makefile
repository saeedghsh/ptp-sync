SHELL := /bin/bash

.PHONY: clean
clean:
	@echo "***** rm *~"
	@find . -name '*~'    -exec rm -f {} +

# build docker image from dockerfile
.PHONY: build-master
build-master:
	docker image build --tag ptpmasterclock:daemon --file Dockerfile.master .

# # run docker container from the image and (attach -it: interactive + tty)
# # or, run docker container from the image detached and then attach
# docker container run --detach --name masterclock ptpmasterclock:daemon
# docker attach masterclock
.PHONY: run-master
run-master:
	docker container run -it --privileged --network host --name masterclock ptpmasterclock:daemon

# stops running container, saves the state (sends sigterm, if not sends sigkill)
.PHONY: stop-master
stop-master:
	docker stop masterclock

# for previously stopped containers, not replace run
.PHONY: start-master
start-master:
	docker start masterclock -i -a

# kill running container; and remove container and image
.PHONY: kill-rm-master
kill-rm-master:
	-docker kill masterclock
	-docker container rm --force masterclock
	docker image rm --force ptpmasterclock:daemon


# execute a command inside the container
# docker exec -it masterclock ls # run ls inside the container
# docker exec -it masterclock bash # run a bash inside the container, and attach (-it)

# docker logs --follow masterclock
# docker logs --follow --since -1h masterclock

# docker image list
# docker container list

# docker ps
# docker ps -a
