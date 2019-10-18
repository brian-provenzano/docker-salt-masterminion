IMAGEPREFIX="lab"
setup:
	@mkdir -p salt/{build,cache,config,etc,formulas,pillar,state,tests}
	@mkdir -p salt/state/{common,files}
	@cp src/master salt/etc/master
build:
	@docker build -t $(IMAGEPREFIX)/salt-master -f Dockerfile.master .
	@docker build -t $(IMAGEPREFIX)/salt-minion-ubuntu -f Dockerfile.minion.ubuntu .
	@docker build -t $(IMAGEPREFIX)/salt-minion-centos -f Dockerfile.minion.centos .
up:
	@docker-compose up
stop:
	@docker-compose stop
start:
	@docker-compose up --no-recreate
halt: stop
stats:
	@docker ps -q | xargs docker stats
show-images:
	@docker image ls
show-containers:
	@docker container ls --all
logs-master:
	@docker-compose logs -f salt-master
logs-minion1:
	@docker-compose logs -f salt-minion-ubuntu1
logs-minion2:
	@docker-compose logs -f salt-minion-ubuntu2
logs-minion3:
	@docker-compose logs -f salt-minion-centos
cli-master:
	@docker-compose exec salt-master bash
cli-minion1:
	@docker-compose exec salt-minion-ubuntu1 bash
cli-minion2:
	@docker-compose exec salt-minion-ubuntu2 bash
cli-minion3:
	@docker-compose exec salt-minion-centos bash
destroy:
	@docker-compose down --volumes
	@rm -fr salt/cache/*
	@rm -fr salt/etc/pki
clean-dangling-images:
	@docker image prune --force
clean-all-images:
	@docker image rm $(IMAGEPREFIX)/salt-master:latest
	@docker image rm $(IMAGEPREFIX)/salt-minion-ubuntu:latest
	@docker image rm $(IMAGEPREFIX)/salt-minion-centos:latest
